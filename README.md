# MyZsh — Lightweight Zsh Framework

Framework Zsh nhỏ gọn, dễ hiểu, dễ custom — viết bằng tiếng Việt cho người Việt.

---

## Cài đặt

```bash
git clone https://github.com/you/myzsh.git ~/.myzsh-src
cd ~/.myzsh-src
sh install.sh
```

Sau đó **khởi động lại terminal** hoặc chạy:

```bash
source ~/.zshrc
```

---

## Cấu trúc thư mục

```
~/.myzsh/
├── myzsh.zsh              ← Điểm vào chính (source từ .zshrc)
├── custom.zsh             ← File CỦA BẠN — thêm alias/function cá nhân ở đây
│
├── lib/
│   ├── utils.zsh          ← Hàm tiện ích (màu sắc, git, path...)
│   └── zsh-config.zsh     ← Cấu hình Zsh cơ bản (completion, history, keybinds)
│
├── themes/
│   ├── minimal.zsh-theme  ← Theme mặc định: sạch + git status
│   └── powerline.zsh-theme← Theme phong cách Powerline (cần Nerd Font)
│
└── plugins/
    ├── git/               ← Aliases & functions cho Git
    ├── aliases/           ← Aliases hữu ích hàng ngày
    ├── history/           ← Tìm kiếm history nâng cao (tích hợp fzf)
    └── autosuggestions/   ← Gợi ý lệnh từ history
```

---

## Cách custom

### 1. Đổi theme

Mở `~/.myzsh/myzsh.zsh`, tìm dòng:

```zsh
export MYZSH_THEME="minimal"
```

Đổi thành tên theme khác. Theme có sẵn: `minimal`, `powerline`.

Để **tạo theme mới**:

```bash
cp ~/.myzsh/themes/minimal.zsh-theme ~/.myzsh/themes/mytheme.zsh-theme
# Sửa file mytheme.zsh-theme theo ý thích
# Đổi MYZSH_THEME="mytheme" trong myzsh.zsh
```

### 2. Thêm / bỏ plugin

Trong `~/.myzsh/myzsh.zsh`:

```zsh
export MYZSH_PLUGINS=(
    git          # Bật
    aliases      # Bật
    history      # Bật
    # autosuggestions   # Tắt (comment lại)
)
```

Để **tạo plugin mới**:

```bash
mkdir -p ~/.myzsh/plugins/myplugin
vi ~/.myzsh/plugins/myplugin/myplugin.plugin.zsh
# Thêm "myplugin" vào MYZSH_PLUGINS trong myzsh.zsh
```

### 3. Thêm alias / function cá nhân

Mở `custom.zsh` bằng lệnh:

```bash
myzrc
```

Thêm alias vào, lưu, rồi reload:

```bash
reload
```

**Không bao giờ sửa file trong `lib/` hay plugin gốc** — hãy override trong `custom.zsh`.

### 4. Tuỳ chỉnh theme không cần sửa file theme

Thêm vào `custom.zsh`:

```zsh
MYZSH_PROMPT_SYMBOL="→"
MYZSH_COLOR_PATH="magenta"
MYZSH_SHOW_TIME=false
```

---

## Cài thêm công cụ (khuyến nghị)

| Công cụ | Tác dụng | Cài |
|---------|----------|-----|
| `fzf` | Tìm kiếm history/file đẹp | `brew install fzf` |
| `zsh-autosuggestions` | Gợi ý lệnh mờ khi gõ | `brew install zsh-autosuggestions` |
| `zsh-syntax-highlighting` | Tô màu lệnh khi gõ | `brew install zsh-syntax-highlighting` |
| `eza` | Thay thế `ls` hiện đại hơn | `brew install eza` |
| `bat` | Thay thế `cat` có màu | `brew install bat` |
| `ripgrep` | Tìm trong file nhanh hơn grep | `brew install ripgrep` |

---

## Tham chiếu nhanh

| Lệnh | Tác dụng |
|------|----------|
| `reload` | Reload `.zshrc` |
| `myzrc` | Mở `custom.zsh` để sửa |
| `zrc` | Mở `.zshrc` để sửa |
| `hs <từ>` | Tìm trong history |
| `mkcd <tên>` | Tạo thư mục và cd vào |
| `extract <file>` | Giải nén (tự nhận format) |
| `bak <file>` | Backup file nhanh |
| `topcmds` | 10 lệnh dùng nhiều nhất |
| `gclean-branches` | Xoá branch đã merge |
| `gcq "msg"` | git add all + commit |
| `gpush` | Push branch + set upstream |

---

## Cấu trúc một plugin (template)

```zsh
# plugins/myplugin/myplugin.plugin.zsh

# Kiểm tra dependency
myzsh_has "sometool" || {
    myzsh_warn "Plugin myplugin: cần cài sometool"
    return
}

# Alias
alias x='sometool do-something'

# Hàm
myfunction() {
    echo "Xin chào $1"
}
```

---

## Cấu trúc một theme (template)

```zsh
# themes/mytheme.zsh-theme

# Ký hiệu và màu
MY_SYMBOL="❯"
MY_COLOR="cyan"

# Hàm build prompt (chạy mỗi khi hiện prompt)
_myzsh_precmd_prompt() {
    local path_part="%F{$MY_COLOR}%~%f"
    local git_part=$(_myzsh_git_prompt)   # Hàm có sẵn trong utils.zsh
    PROMPT="${path_part}${git_part}"$'\n'"${MY_SYMBOL} "
    RPROMPT="%F{240}%D{%H:%M}%f"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _myzsh_precmd_prompt
```

---

## License

MIT — Dùng thoải mái, sửa thoải mái.
