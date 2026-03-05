#!/usr/bin/env bash
# Theme-aware kitty startup — reads active_theme to decide what to show

ACTIVE_THEME=$(cat ~/.config/kawaiishell/active_theme 2>/dev/null || echo "sprigatito")

case "$ACTIVE_THEME" in
    kawaiishell)
        ~/.config/kitty/kawaiishell-splash.sh
        ;;
    sprigatito|*)
        # Original sprigatito startup
        kitten icat --align center ~/.config/kitty/sprigatito.png 2>/dev/null

        INCIDENT_FILE="$HOME/.local/share/sprigatito-rice/incident_date"
        if [[ -f "$INCIDENT_FILE" ]]; then
            INCIDENT_DATE=$(cat "$INCIDENT_FILE")
            TODAY=$(date +%Y-%m-%d)
            DAYS=$(( ( $(date -d "$TODAY" +%s) - $(date -d "$INCIDENT_DATE" +%s) ) / 86400 ))
            echo -e "\e[38;2;123;201;111m  🌿 \e[0m\e[38;2;245;243;231m${DAYS} days since the last incident.\e[0m"
        fi

        ~/local/bin/sprigatito-says
        echo
        ;;
esac

exec bash --login
