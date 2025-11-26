# ==============================
# ZSH / Oh-My-Zsh Setup
# ==============================
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export EDITOR=nvim
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Wayland setup for SSH
if [[ -n $SSH_CONNECTION && $TTY == /dev/pts/* ]]; then
    export DISPLAY=:1
    export XDG_RUNTIME_DIR=/run/user/1000
    export WAYLAND_DISPLAY=wayland-1
fi

# Powerlevel10k theme
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# ==============================
# Zinit Plugin Manager
# ==============================
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit
    git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# ------------------------------
# Plugins 🔌
# ------------------------------
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode

# FZF integration if installed
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ==============================
# Aliases 🧪
# ==============================
alias cls="clear"
alias q='exit'
alias ls="eza --icons=always"
alias ll="eza --icons=always -la"
alias la="eza --icons=always -a"
alias update="sudo pacman -Syu"
alias cmatrix='cmatrix -C yellow'
alias venv='source .venv/bin/activate'  
alias die='poweroff'
alias ip-info='curl -S https://ipinfo.io | jq'
alias spotdl='spotdl --format flac'
alias time-to-music='cd ~/Music/downloads/ && source .venv/bin/activate'
alias tty-clock='tty-clock -sSd 1 -C 3'
alias please='sudo'

# ==============================
# ZSH History 📜
# ==============================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ==============================
# Powerlevel10k Configuration
# ==============================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================
# Pyenv Configuration
# ==============================
export PATH="$HOME/.pyenv/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    
    if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# ==============================
# LS_COLORS (Gruvbox)
# ==============================
eval "$(dircolors -b ~/.dircolors)"

# ==============================
# POWERLEVEL10K - GRUVBOX THEME
# ==============================

# --- DIRECTORY & PATH ---
POWERLEVEL9K_DIR_BACKGROUND=235
POWERLEVEL9K_DIR_FOREGROUND=223
POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=166
POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=109
POWERLEVEL9K_DIR_ANCHOR_BOLD=true
POWERLEVEL9K_DIR_HOME_FOREGROUND=223
POWERLEVEL9K_DIR_HOME_BACKGROUND=236
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=223
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=236
POWERLEVEL9K_DIR_WRITABLE_FOREGROUND=215
POWERLEVEL9K_DIR_WRITABLE_BACKGROUND=235
POWERLEVEL9K_DIR_READONLY_FOREGROUND=239
POWERLEVEL9K_DIR_READONLY_BACKGROUND=235
POWERLEVEL9K_DIR_VCS_FOREGROUND=214
POWERLEVEL9K_DIR_VCS_BACKGROUND=235
POWERLEVEL9K_DIR_SYMLINK_FOREGROUND=109
POWERLEVEL9K_DIR_SYMLINK_BACKGROUND=235

# --- GIT / VCS ---
POWERLEVEL9K_VCS_GIT_HOOKS=true
POWERLEVEL9K_VCS_SHOW=true
POWERLEVEL9K_VCS_SHOW_UNTRACKED=true
POWERLEVEL9K_VCS_SHOW_UNSTAGED=true
POWERLEVEL9K_VCS_SHOW_STAGED=true
POWERLEVEL9K_VCS_FOREGROUND=223
POWERLEVEL9K_VCS_BACKGROUND=235

# --- PYENV ---
POWERLEVEL9K_PYENV_FOREGROUND=223
POWERLEVEL9K_PYENV_BACKGROUND=235

# --- PROMPT CHAR / STATUS ---
# Success ✔
POWERLEVEL9K_PROMPT_CHAR_OK_VCS_FOREGROUND=109
POWERLEVEL9K_PROMPT_CHAR_OK_VCS_BACKGROUND=235
POWERLEVEL9K_STATUS_OK_FOREGROUND=109
POWERLEVEL9K_STATUS_OK_BACKGROUND=235

# Failure ✘
POWERLEVEL9K_PROMPT_CHAR_ERROR_FOREGROUND=167
POWERLEVEL9K_PROMPT_CHAR_ERROR_BACKGROUND=235

# Partial pipe failure ⚠️
POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=214

# --- OS & HOSTNAME ---
POWERLEVEL9K_OS_ICON_SHOW=true
POWERLEVEL9K_OS_ICON_FOREGROUND=223
POWERLEVEL9K_OS_ICON_BACKGROUND=235
POWERLEVEL9K_HOSTNAME_SHOW=true
POWERLEVEL9K_HOSTNAME_FOREGROUND=223
POWERLEVEL9K_HOSTNAME_BACKGROUND=235

# --- TIME & MISC ---
POWERLEVEL9K_TIME_FOREGROUND=223
POWERLEVEL9K_TIME_BACKGROUND=235
POWERLEVEL9K_RAINBOW=false


