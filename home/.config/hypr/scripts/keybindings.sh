#!/bin/bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#

CONFIG="$HOME/.config/hypr/conf/keybindings.lua"

echo "Reading keybindings from: $CONFIG"

keybinds=$(
  python3 - "$CONFIG" <<'PY'
import os
import re
import sys

root = os.path.abspath(sys.argv[1])
hypr_dir = os.path.dirname(os.path.dirname(root))

seen = set()
files = []


# ---------------------------------------------------------
# Recursively load Lua modules from require()
# ---------------------------------------------------------

def resolve_module(module):
    return os.path.join(
        hypr_dir,
        *module.split(".")
    ) + ".lua"


def load_file(path):
    path = os.path.abspath(path)

    if path in seen:
        return

    if not os.path.isfile(path):
        return

    seen.add(path)

    with open(path, encoding="utf-8") as f:
        data = f.read()

    files.append((path, data))

    for module in re.findall(
        r'require\s*\(\s*["\']([^"\']+)["\']\s*\)',
        data
    ):
        load_file(resolve_module(module))


load_file(root)


# ---------------------------------------------------------
# Resolve simple Lua local string variables
# ---------------------------------------------------------

variables = {
    "mainMod": "SUPER",
}

for _, data in files:
    for name, value in re.findall(
        r'\blocal\s+(\w+)\s*=\s*["\']([^"\']*)["\']',
        data
    ):
        variables[name] = value


def resolve(expr):
    expr = expr.strip()

    parts = re.split(r"\s*\.\.\s*", expr)

    result = []

    for part in parts:
        part = part.strip()

        if len(part) >= 2 and part[0] in "\"'" and part[-1] == part[0]:
            part = part[1:-1]

        elif part in variables:
            part = variables[part]

        result.append(part)

    return "".join(result)


# ---------------------------------------------------------
# Extract balanced hl.bind(...) calls
# ---------------------------------------------------------

def extract_binds(data):
    binds = []
    search_from = 0

    while True:
        start = data.find("hl.bind(", search_from)

        if start == -1:
            break

        depth = 0
        quote = None
        escaped = False
        end = None

        for i in range(start + len("hl.bind(") - 1, len(data)):
            c = data[i]

            if quote:
                if escaped:
                    escaped = False
                elif c == "\\":
                    escaped = True
                elif c == quote:
                    quote = None

                continue

            if c in "\"'":
                quote = c

            elif c == "(":
                depth += 1

            elif c == ")":
                depth -= 1

                if depth == 0:
                    end = i + 1
                    break

        if end is None:
            break

        binds.append((start, end, data[start:end]))
        search_from = end

    return binds


# ---------------------------------------------------------
# Split hl.bind arguments at top-level commas
# ---------------------------------------------------------

def split_args(call):
    inner = call[len("hl.bind("):-1]

    args = []
    start = 0
    depth = 0
    quote = None
    escaped = False

    for i, c in enumerate(inner):

        if quote:
            if escaped:
                escaped = False
            elif c == "\\":
                escaped = True
            elif c == quote:
                quote = None

            continue

        if c in "\"'":
            quote = c

        elif c in "({[":
            depth += 1

        elif c in ")}]":
            depth -= 1

        elif c == "," and depth == 0:
            args.append(inner[start:i].strip())
            start = i + 1

    args.append(inner[start:].strip())

    return args


# ---------------------------------------------------------
# Parse a key expression
# ---------------------------------------------------------

def parse_key(expr):
    return resolve(expr)


# ---------------------------------------------------------
# Parse description from the bind's source line.
#
# Since descriptions are now inline Lua comments, we only
# need the physical line containing the completed bind.
# ---------------------------------------------------------

def description_after(data, end):
    line_end = data.find("\n", end)

    if line_end == -1:
        line_end = len(data)

    line = data[end:line_end]

    match = re.search(r'--\s*(.*)$', line)

    if match:
        return match.group(1).strip()

    return ""


# ---------------------------------------------------------
# Generate output
# ---------------------------------------------------------

for path, data in files:

    for start, end, call in extract_binds(data):

        args = split_args(call)

        if len(args) < 2:
            continue

        key = parse_key(args[0])
        description = description_after(data, end)

        if not description:
            # Don't clutter the menu with undocumented binds.
            continue

        print(f"{key}  +  {description}\r")

PY
)

rofi \
  -dmenu \
  -i \
  -markup \
  -eh 2 \
  -replace \
  -p "Keybinds" \
  -config ~/.config/rofi/config-compact.rasi \
  <<<"$keybinds"
