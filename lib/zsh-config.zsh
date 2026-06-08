# =============================================================================
# LIB/ZSH-CONFIG.ZSH — Cấu hình Zsh cơ bản
# =============================================================================

# ── Options ───────────────────────────────────────────────────────────────────
setopt AUTO_CD              # Gõ tên thư mục không cần gõ cd
setopt CORRECT              # Gợi ý sửa lỗi chính tả lệnh
setopt INTERACTIVE_COMMENTS # Cho phép # comment trong terminal
setopt EXTENDED_GLOB        # Glob nâng cao (**, ^pattern, ...)
setopt NO_BEEP              # Tắt tiếng bíp
setopt COMBINING_CHARS      # Hỗ trợ ký tự Unicode tổ hợp
setopt AUTO_MENU            # Tự mở menu khi Tab lần 2
setopt COMPLETE_IN_WORD     # Completion ngay tại vị trí con trỏ
setopt ALWAYS_TO_END        # Sau khi complete, con trỏ nhảy ra cuối
setopt GLOB_DOTS            # Hoàn thành cả file ẩn (bắt đầu bằng .)

# ── Completion system ─────────────────────────────────────────────────────────
autoload -Uz compinit

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Substring matching — CHỈ 1 dòng matcher-list duy nhất
# l:|=* r:|=*  →  gõ "spirit" tìm được "tiny-spirit"
# m:{a-zA-Z}={A-Za-z}  →  không phân biệt hoa/thường
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'

# Menu highlight
zstyle ':completion:*' menu select

# Nhóm và mô tả
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'

# Màu file giống ls
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ── History ───────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# ── Keybindings ───────────────────────────────────────────────────────────────
bindkey -e

bindkey '^[[A' history-search-backward   # ↑
bindkey '^[[B' history-search-forward    # ↓
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word           # Ctrl+→
bindkey '^[[1;5D' backward-word          # Ctrl+←

# ── Biến môi trường ───────────────────────────────────────────────────────────
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'