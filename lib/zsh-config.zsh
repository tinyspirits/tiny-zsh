# =============================================================================
# LIB/ZSH-CONFIG.ZSH — Cấu hình Zsh cơ bản
# =============================================================================
# Tất cả setopt, bindkey, và cấu hình completion nằm ở đây.
# NOTE: Bạn có thể bật/tắt từng phần bằng cách comment dòng đó lại (#)
# =============================================================================

# ── Options (setopt) ──────────────────────────────────────────────────────────
# NOTE: Tham khảo đầy đủ: man zshoptions
#       Thêm "NO" trước tên để tắt. Ví dụ: setopt NOSHARE_HISTORY

setopt AUTO_CD              # Gõ tên thư mục không cần gõ cd
setopt CORRECT              # Gợi ý sửa lỗi chính tả lệnh
setopt INTERACTIVE_COMMENTS # Cho phép # comment trong terminal
setopt EXTENDED_GLOB        # Glob nâng cao (**, ^pattern, ...)
setopt NO_BEEP              # Tắt tiếng bíp
setopt COMBINING_CHARS      # Hỗ trợ ký tự Unicode tổ hợp (emoji, v.v.)

# ── Completion system ─────────────────────────────────────────────────────────
# NOTE: Đây là hệ thống tự động hoàn thành (Tab) của Zsh.
#       compinit phải được gọi sau khi load tất cả các hàm completion.

autoload -Uz compinit

# Tối ưu: chỉ chạy compinit đầy đủ 1 lần/ngày, dùng cache cho các lần sau
# Cache lưu tại ~/.zcompdump
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit                    # Lần đầu trong ngày: load đầy đủ
else
    compinit -C                 # Các lần sau: dùng cache (nhanh hơn)
fi

# ── Kiểu hiển thị completion menu ────────────────────────────────────────────
# NOTE: Bỏ comment dòng nào bạn muốn dùng

# Highlight lựa chọn đang focus trong menu
zstyle ':completion:*' menu select

# Hoàn thành không phân biệt hoa/thường
# NOTE: Đổi thành "false" nếu muốn phân biệt hoa/thường
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Hiện nhóm và mô tả trong menu completion
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'

# Màu cho file trong completion (giống ls)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Hoàn thành cả file ẩn (bắt đầu bằng .)
# NOTE: Comment dòng này nếu không muốn thấy file ẩn trong completion
setopt GLOB_DOTS

# ── History ───────────────────────────────────────────────────────────────────
# NOTE: Cấu hình lịch sử lệnh. Thay đổi HISTSIZE để lưu nhiều/ít hơn.

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000        # NOTE: Số lệnh lưu trong RAM
SAVEHIST=50000        # NOTE: Số lệnh lưu vào file

setopt SHARE_HISTORY          # Chia sẻ history giữa các tab/cửa sổ terminal
setopt HIST_IGNORE_DUPS       # Không lưu lệnh trùng liền nhau
setopt HIST_IGNORE_ALL_DUPS   # Xoá lệnh trùng cũ hơn trong history
setopt HIST_IGNORE_SPACE      # Lệnh bắt đầu bằng space không lưu vào history
setopt HIST_REDUCE_BLANKS     # Xoá khoảng trắng thừa trước khi lưu
setopt INC_APPEND_HISTORY     # Lưu ngay lập tức (không đợi đóng terminal)

# ── Keybindings ───────────────────────────────────────────────────────────────
# NOTE: Zsh có 2 mode: emacs (mặc định) và vi
#       Bỏ comment dòng bindkey -v nếu muốn dùng vi mode

bindkey -e   # Emacs mode (Ctrl+A đầu dòng, Ctrl+E cuối dòng, v.v.)
# bindkey -v # NOTE: Bỏ comment để dùng Vi mode thay thế

# Phím điều hướng trong history
bindkey '^[[A' history-search-backward   # ↑ tìm lệnh cũ khớp prefix
bindkey '^[[B' history-search-forward    # ↓ tìm lệnh mới hơn

# Phím Home/End/Delete
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[3~' delete-char

# Ctrl+← / Ctrl+→ nhảy theo từ
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ── Biến môi trường mặc định ─────────────────────────────────────────────────
# NOTE: Đặt editor, pager, v.v. ở đây. Đổi thành nano/vim/code tuỳ thích.

export EDITOR="${EDITOR:-nano}"    # NOTE: Đổi thành vim / nvim / code
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"

# Màu cho lệnh man (trang hướng dẫn)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
