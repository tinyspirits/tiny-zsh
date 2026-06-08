#!/usr/bin/env bash
# =============================================================================
# MYZSH - Lightweight Zsh Framework
# Cài đặt framework vào thư mục ~/.myzsh
# =============================================================================
# CÁCH DÙNG: sh install.sh
# =============================================================================

set -e

MYZSH_DIR="$HOME/.myzsh"
ZSHRC="$HOME/.zshrc"

# ── Màu sắc cho output ──────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info()    { echo -e "${CYAN}[myzsh]${RESET} $1"; }
success() { echo -e "${GREEN}[myzsh]${RESET} ✓ $1"; }
warn()    { echo -e "${YELLOW}[myzsh]${RESET} ⚠ $1"; }
error()   { echo -e "${RED}[myzsh]${RESET} ✗ $1"; exit 1; }

# ── Kiểm tra Zsh đã cài chưa ───────────────────────────────────────────────
command -v zsh >/dev/null 2>&1 || error "Zsh chưa được cài. Chạy: brew install zsh (macOS) hoặc apt install zsh (Linux)"

echo -e "${BOLD}"
cat << 'EOF'
  _____ _             _____ ____  _   _ 
 |_   _(_)_ __  _   _|__  // ___|| | | |
   | | | | '_ \| | | | / / \___ \| |_| |
   | | | | | | | |_| |/ /_  ___) |  _  |
   |_| |_|_| |_|\__, /____||____/|_| |_|
                |___/                   

 Lightweight Zsh Framework
EOF
echo -e "${RESET}"

# ── Sao chép files vào ~/.myzsh ────────────────────────────────────────────
info "Đang cài đặt vào $MYZSH_DIR ..."

# Tạo backup nếu đã tồn tại
if [ -d "$MYZSH_DIR" ]; then
    BACKUP="$HOME/.myzsh.backup.$(date +%Y%m%d%H%M%S)"
    warn "Đã tìm thấy ~/.myzsh, backup sang $BACKUP"
    mv "$MYZSH_DIR" "$BACKUP"
fi

# Copy toàn bộ framework vào home
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp -r "$SCRIPT_DIR" "$MYZSH_DIR"
success "Đã copy files vào $MYZSH_DIR"

# ── Thêm dòng source vào .zshrc ────────────────────────────────────────────
SOURCE_LINE='source "$HOME/.myzsh/myzsh.zsh"'

if grep -qF 'myzsh.zsh' "$ZSHRC" 2>/dev/null; then
    warn ".zshrc đã có dòng source myzsh, bỏ qua"
else
    # Backup .zshrc trước khi sửa
    [ -f "$ZSHRC" ] && cp "$ZSHRC" "$ZSHRC.bak.$(date +%Y%m%d)"
    echo "" >> "$ZSHRC"
    echo "# ── MyZsh Framework ──────────────────────────────────" >> "$ZSHRC"
    echo "$SOURCE_LINE" >> "$ZSHRC"
    success "Đã thêm source vào $ZSHRC"
fi

echo ""
echo -e "${GREEN}${BOLD}✓ Cài đặt hoàn tất!${RESET}"
echo ""
echo -e "  Khởi động lại terminal hoặc chạy: ${CYAN}source ~/.zshrc${RESET}"
echo ""
echo -e "  Để custom: ${CYAN}nano ~/.myzsh/myzsh.zsh${RESET}"
echo ""
