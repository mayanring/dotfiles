# PATH configuration
set -gx PATH ./bin $HOME/.local/bin $HOME/.local/share/omarchy/bin $PATH

# Environment variables
set -gx EDITOR nvim
set -gx SUDO_EDITOR $EDITOR

alias hx='helix'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cat="bat"

# Git
alias gst='git status'

# Package management
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

# Compression
alias decompress="tar -xzf"

# Functions
function compress
    tar -czf "$argv[1].tar.gz" "$argv[1]"
end

function open
    xdg-open $argv >/dev/null 2>&1
end

function web2app
    if test (count $argv) -ne 3
        echo "Usage: web2app <AppName> <AppURL> <IconURL> (IconURL must be in PNG -- use https://dashboardicons.com)"
        return 1
    end

    set APP_NAME "$argv[1]"
    set APP_URL "$argv[2]"
    set ICON_URL "$argv[3]"
    set ICON_DIR "$HOME/.local/share/applications/icons"
    set DESKTOP_FILE "$HOME/.local/share/applications/$APP_NAME.desktop"
    set ICON_PATH "$ICON_DIR/$APP_NAME.png"

    mkdir -p "$ICON_DIR"

    if not curl -sL -o "$ICON_PATH" "$ICON_URL"
        echo "Error: Failed to download icon."
        return 1
    end

    echo "[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME
Exec=chromium --new-window --ozone-platform=wayland --app=\"$APP_URL\" --name=\"$APP_NAME\" --class=\"$APP_NAME\"
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupNotify=true" >"$DESKTOP_FILE"

    chmod +x "$DESKTOP_FILE"
end

function web2app-remove
    if test (count $argv) -ne 1
        echo "Usage: web2app-remove <AppName>"
        return 1
    end

    set APP_NAME "$argv[1]"
    set ICON_DIR "$HOME/.local/share/applications/icons"
    set DESKTOP_FILE "$HOME/.local/share/applications/$APP_NAME.desktop"
    set ICON_PATH "$ICON_DIR/$APP_NAME.png"

    rm -f "$DESKTOP_FILE"
    rm -f "$ICON_PATH"
end

function refresh-xcompose
    pkill fcitx5
    setsid fcitx5 &>/dev/null &
end

# Tool initialization
if type -q mise
    mise activate fish | source
end

if type -q zoxide
    zoxide init fish | source
end

starship init fish | source
