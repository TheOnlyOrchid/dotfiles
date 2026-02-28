#!/usr/bin/env bash
# 🌿 Sprigatito rice installer
set -euo pipefail

G='\033[38;2;123;201;111m'; C='\033[38;2;245;243;231m'; RESET='\033[0m'
info() { echo -e "${G}🌿${RESET} ${C}$*${RESET}"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info "Installing Sprigatito rice from $DOTFILES..."

# ── Kitty
mkdir -p ~/.config/kitty
cp "$DOTFILES/kitty/kitty.conf"       ~/.config/kitty/
cp "$DOTFILES/kitty/startup.sh"       ~/.config/kitty/ && chmod +x ~/.config/kitty/startup.sh
cp "$DOTFILES/kitty/startup.session"  ~/.config/kitty/
[[ -f "$DOTFILES/kitty/sprigatito.png" ]] && cp "$DOTFILES/kitty/sprigatito.png" ~/.config/kitty/

# ── Starship
mkdir -p ~/.config
cp "$DOTFILES/starship/starship.toml" ~/.config/starship.toml

# ── Fastfetch
mkdir -p ~/.config/fastfetch
cp "$DOTFILES/fastfetch/config.jsonc"   ~/.config/fastfetch/
cp "$DOTFILES/fastfetch/sprigatito.txt" ~/.config/fastfetch/
# Fix HOME path in fastfetch config
sed -i "s|~/.config/fastfetch/|$HOME/.config/fastfetch/|g" ~/.config/fastfetch/config.jsonc

# ── Kvantum
mkdir -p ~/.config/Kvantum/Sprigatito
cp "$DOTFILES/kvantum/Sprigatito/Sprigatito.kvconfig" ~/.config/Kvantum/Sprigatito/
[[ -f "$DOTFILES/kvantum/Sprigatito/Sprigatito.svg" ]] && \
    cp "$DOTFILES/kvantum/Sprigatito/Sprigatito.svg" ~/.config/Kvantum/Sprigatito/
cp "$DOTFILES/kvantum/kvantum.kvconfig" ~/.config/Kvantum/

# ── KDE colour scheme + plasma theme
mkdir -p ~/.local/share/color-schemes
cp "$DOTFILES/kde/color-schemes/Sprigatito.colors" ~/.local/share/color-schemes/

mkdir -p ~/.local/share/plasma/desktoptheme/Sprigatito
cp "$DOTFILES/kde/plasma-desktoptheme/Sprigatito/"* ~/.local/share/plasma/desktoptheme/Sprigatito/

# ── Plasmoid
mkdir -p ~/.local/share/plasma/plasmoids/com.sprigatito.incident/contents/ui
cp "$DOTFILES/kde/plasmoids/com.sprigatito.incident/metadata.json" \
    ~/.local/share/plasma/plasmoids/com.sprigatito.incident/
cp "$DOTFILES/kde/plasmoids/com.sprigatito.incident/contents/ui/main.qml" \
    ~/.local/share/plasma/plasmoids/com.sprigatito.incident/contents/ui/

# ── KDE system configs
for f in kdeglobals plasmarc plasmashellrc kwinrc breezerc kscreenlockerrc ksplashrc kcminputrc; do
    [[ -f "$DOTFILES/kde/$f" ]] && cp "$DOTFILES/kde/$f" ~/.config/"$f"
done
[[ -f "$DOTFILES/kde/plasma-appletsrc" ]] && \
    cp "$DOTFILES/kde/plasma-appletsrc" ~/.config/plasma-org.kde.plasma.desktop-appletsrc

# ── GTK
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
cp "$DOTFILES/gtk/gtk-3.0/settings.ini" ~/.config/gtk-3.0/
cp "$DOTFILES/gtk/gtk-4.0/settings.ini" ~/.config/gtk-4.0/

# ── local/bin scripts
mkdir -p ~/local/bin
cp "$DOTFILES/local-bin/"* ~/local/bin/
chmod +x ~/local/bin/*

# ── bashrc additions
if ! grep -q "Sprigatito Rice" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    cat "$DOTFILES/bashrc-sprigatito.sh" >> ~/.bashrc
    info "Appended bashrc additions. Run: source ~/.bashrc"
else
    info "bashrc additions already present — skipping"
fi

# ── Incident date (initialise if missing)
mkdir -p ~/.local/share/sprigatito-rice
[[ ! -f ~/.local/share/sprigatito-rice/incident_date ]] && \
    date +%Y-%m-%d > ~/.local/share/sprigatito-rice/incident_date

# ── Apply KDE settings
info "Applying KDE settings..."
plasma-apply-colorscheme Sprigatito 2>/dev/null || true
plasma-apply-desktoptheme Sprigatito 2>/dev/null || true
plasma-apply-wallpaperimage ~/Pictures/wallpaper/sprigatito_wallpaper.png 2>/dev/null || true
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true

info "Done! 🌿 Restart plasmashell to apply panel changes:"
info "  plasmashell --replace &"
echo
info "Don't forget:"
echo "  sudo papirus-folders -C green --theme Papirus-Dark"
echo "  sudo cp -r ~/temp/copilot/sddm-sprigatito /usr/share/sddm/themes/sprigatito"
