#!/bin/bash

set -euo pipefail

HYPR_ROOT="$HOME/.config/hypr"
ENTRYPOINT="$HYPR_ROOT/conf/keybinding.lua"
ROFI_CONFIG="$HOME/.config/rofi/config-compact.rasi"

if [[ ! -f "$ENTRYPOINT" ]]; then
  echo "Error: Hyprland keybinding entrypoint not found:"
  echo "  $ENTRYPOINT"
  exit 1
fi

if [[ ! -f "$ROFI_CONFIG" ]]; then
  echo "Error: Rofi config not found:"
  echo "  $ROFI_CONFIG"
  exit 1
fi

TMPFILE="$(mktemp)"
trap 'rm -f "$TMPFILE"' EXIT

python3 - "$HYPR_ROOT" "$ENTRYPOINT" > "$TMPFILE" <<'PY'
import sys
import re
from pathlib import Path


# =========================================================
# Configuration
# =========================================================

HYPR_ROOT = Path(sys.argv[1]).expanduser().resolve()
ENTRYPOINT = Path(sys.argv[2]).expanduser().resolve()


# =========================================================
# Lua helpers
# =========================================================

def strip_comment(line):
    """
    Remove a Lua -- comment while respecting quoted strings.
    """
    quote = None
    escaped = False
    i = 0

    while i < len(line):
        char = line[i]

        if quote:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
        else:
            if char in ("'", '"'):
                quote = char
            elif char == "-" and i + 1 < len(line) and line[i + 1] == "-":
                return line[:i]

        i += 1

    return line


def split_top_level(text, delimiter=","):
    """
    Split a Lua expression on a delimiter while ignoring
    strings and nested (), {}, [].
    """
    parts = []
    start = 0

    paren = 0
    brace = 0
    bracket = 0

    quote = None
    escaped = False

    i = 0

    while i < len(text):
        char = text[i]

        if quote:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None

            i += 1
            continue

        if char in ("'", '"'):
            quote = char

        elif char == "(":
            paren += 1
        elif char == ")":
            paren -= 1
        elif char == "{":
            brace += 1
        elif char == "}":
            brace -= 1
        elif char == "[":
            bracket += 1
        elif char == "]":
            bracket -= 1

        elif (
            char == delimiter
            and paren == 0
            and brace == 0
            and bracket == 0
        ):
            parts.append(text[start:i].strip())
            start = i + 1

        i += 1

    parts.append(text[start:].strip())

    return parts


def split_concat(expr):
    """
    Split Lua string concatenation:

        mainMod .. " + RETURN"

    into:

        ["mainMod", '" + RETURN"']
    """
    parts = []

    quote = None
    escaped = False

    paren = 0
    brace = 0
    bracket = 0

    start = 0
    i = 0

    while i < len(expr):
        char = expr[i]

        if quote:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None

            i += 1
            continue

        if char in ("'", '"'):
            quote = char
            i += 1
            continue

        if char == "(":
            paren += 1
        elif char == ")":
            paren -= 1
        elif char == "{":
            brace += 1
        elif char == "}":
            brace -= 1
        elif char == "[":
            bracket += 1
        elif char == "]":
            bracket -= 1

        elif (
            char == "."
            and i + 1 < len(expr)
            and expr[i + 1] == "."
            and paren == 0
            and brace == 0
            and bracket == 0
        ):
            parts.append(expr[start:i].strip())
            i += 2
            start = i
            continue

        i += 1

    parts.append(expr[start:].strip())

    return parts


def unquote(value):
    value = value.strip()

    if len(value) >= 2:
        if value[0] == '"' and value[-1] == '"':
            return value[1:-1]

        if value[0] == "'" and value[-1] == "'":
            return value[1:-1]

    return None


# =========================================================
# Lua variable resolver
# =========================================================

class LuaEnvironment:
    def __init__(self):
        self.variables = {}

    def resolve(self, expression, depth=0):
        if depth > 20:
            return expression.strip()

        expression = expression.strip()

        # String literal
        literal = unquote(expression)
        if literal is not None:
            return literal

        # Concatenation
        parts = split_concat(expression)

        if len(parts) > 1:
            return "".join(self.resolve(part, depth + 1) for part in parts)

        # Plain variable
        if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", expression):
            if expression in self.variables:
                return self.resolve(
                    self.variables[expression],
                    depth + 1,
                )

        return expression

    def collect(self, text):
        """
        Collect simple assignments such as:

            local mainMod = "SUPER"
            local TERMINAL = "kitty"
            local FOO = BAR
        """

        for line in text.splitlines():
            code = strip_comment(line).strip()

            match = re.match(
                r"^(?:local\s+)?"
                r"([A-Za-z_][A-Za-z0-9_]*)"
                r"\s*=\s*(.+?)\s*$",
                code,
            )

            if not match:
                continue

            name = match.group(1)
            value = match.group(2).strip()

            # Don't treat tables/functions/dispatcher calls as
            # simple variables.
            if value.startswith("{"):
                continue

            if value.startswith("function"):
                continue

            if value.startswith("hl."):
                continue

            self.variables[name] = value


# =========================================================
# require() resolution
# =========================================================

def resolve_require(module):
    """
    Resolve:

        require("conf.keybindings.default")

    against:

        ~/.config/hypr/

    resulting in:

        ~/.config/hypr/conf/keybindings/default.lua
    """

    relative = Path(*module.split("."))

    candidates = [
        HYPR_ROOT / f"{relative}.lua",
        HYPR_ROOT / relative / "init.lua",
    ]

    for candidate in candidates:
        candidate = candidate.resolve()

        if candidate.is_file():
            return candidate

    return None


# =========================================================
# Recursive Lua loader
# =========================================================

visited = set()
files = []


def load_file(path):
    path = path.resolve()

    if path in visited:
        return

    if not path.is_file():
        return

    visited.add(path)
    files.append(path)

    try:
        text = path.read_text(encoding="utf-8")
    except OSError:
        return

    # Lua's require syntax we're interested in.
    pattern = re.compile(
        r"""
        \brequire
        \s*
        \(
        \s*
        (?:
            "([^"]+)"
            |
            '([^']+)'
        )
        \s*
        \)
        """,
        re.VERBOSE,
    )

    for match in pattern.finditer(text):
        module = match.group(1) or match.group(2)

        resolved = resolve_require(module)

        if resolved:
            load_file(resolved)


load_file(ENTRYPOINT)


# =========================================================
# Read all Lua files
# =========================================================

environment = LuaEnvironment()

contents = {}

for path in files:
    try:
        text = path.read_text(encoding="utf-8")
    except OSError:
        continue

    contents[path] = text
    environment.collect(text)


# =========================================================
# Extract hl.bind() calls
# =========================================================

def extract_bind_calls(text):
    """
    Find every:

        hl.bind(...)

    including multiline calls.

    Returns:

        (arguments, ending_position)
    """

    results = []

    needle = "hl.bind("

    i = 0

    while True:
        start = text.find(needle, i)

        if start == -1:
            break

        # Position immediately after the opening '('.
        pos = start + len(needle)

        depth = 1
        quote = None
        escaped = False

        while pos < len(text):
            char = text[pos]

            if quote:
                if escaped:
                    escaped = False
                elif char == "\\":
                    escaped = True
                elif char == quote:
                    quote = None

            else:
                if char in ("'", '"'):
                    quote = char

                elif char == "(":
                    depth += 1

                elif char == ")":
                    depth -= 1

                    if depth == 0:
                        arguments = text[start + len(needle):pos]
                        results.append((start, pos + 1, arguments))
                        i = pos + 1
                        break

            pos += 1
        else:
            break

    return results


# =========================================================
# Description extraction
# =========================================================

def description_after(text, end):
    """
    Look for an inline Lua comment immediately after hl.bind():

        hl.bind(...) -- Open the terminal
    """

    line_end = text.find("\n", end)

    if line_end == -1:
        line_end = len(text)

    trailing = text[end:line_end]

    match = re.search(r"--\s*(.+?)\s*$", trailing)

    if match:
        return match.group(1).strip()

    return ""


# =========================================================
# Normalize key combinations
# =========================================================

def normalize_key(key):
    key = key.strip()

    # Resolve variables first.
    key = environment.resolve(key)

    # Remove quotes that might remain.
    literal = unquote(key)

    if literal is not None:
        key = literal

    # Normalize whitespace around +.
    key = re.sub(r"\s*\+\s*", " + ", key)

    # Collapse remaining whitespace.
    key = re.sub(r"\s+", " ", key)

    return key.strip()


# =========================================================
# Parse bindings
# =========================================================

bindings = []

for path in files:
    text = contents.get(path)

    if not text:
        continue

    for start, end, arguments in extract_bind_calls(text):
        args = split_top_level(arguments)

        if not args:
            continue

        key_expression = args[0]

        key = normalize_key(key_expression)

        if not key:
            continue

        description = description_after(text, end)

        # If there isn't a migrated description, derive a
        # small fallback from the dispatcher.
        if not description:
            dispatcher = " ".join(args[1:])

            match = re.search(
                r"hl\.dsp\.([A-Za-z0-9_]+)",
                dispatcher,
            )

            if match:
                description = match.group(1)

            elif "hl.exec_cmd" in dispatcher:
                description = "Execute command"

            else:
                description = "Keybinding"

        bindings.append((key, description))


# =========================================================
# Output
# =========================================================

# Normalize key formatting and determine the widest key.
normalized_bindings = []

for key, description in bindings:
    key = re.sub(r"\s*\+\s*", " + ", key)
    key = re.sub(r"\s+", " ", key).strip()

    normalized_bindings.append((key, description.strip()))

max_key_width = max(
    len(key)
    for key, _ in normalized_bindings
)

for key, description in normalized_bindings:
    # Add a small, consistent gap between the two columns.
    padded_key = key.ljust(max_key_width + 4)

    print(f"{padded_key}{description}")

PY

# Make sure the parser actually produced something.
if [[ ! -s "$TMPFILE" ]]; then
    echo "Error: no keybindings were found."
    exit 1
fi

# Don't let a stale Rofi instance/socket make us wait around.
pkill -x rofi 2>/dev/null || true
sleep 0.05

rofi \
    -dmenu \
    -i \
    -eh 2 \
    -p "Keybinds" \
    -config "$ROFI_CONFIG" \
    < "$TMPFILE"
