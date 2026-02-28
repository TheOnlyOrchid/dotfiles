#!/usr/bin/env bash
# 🌿 Kitty startup — Sprigatito welcomes you

# Show Sprigatito art with kitten icat (true center)
kitten icat --align center ~/.config/kitty/sprigatito.png 2>/dev/null

# Show days since last incident inline (fun greeting)
INCIDENT_FILE="$HOME/.local/share/sprigatito-rice/incident_date"
if [[ -f "$INCIDENT_FILE" ]]; then
    INCIDENT_DATE=$(cat "$INCIDENT_FILE")
    TODAY=$(date +%Y-%m-%d)
    DAYS=$(( ( $(date -d "$TODAY" +%s) - $(date -d "$INCIDENT_DATE" +%s) ) / 86400 ))
    if [[ $DAYS -eq 0 ]]; then
        echo -e "\e[38;2;139;94;60m  🌿 \e[0m\e[38;2;245;243;231mToday is the incident. We do not speak of it.\e[0m"
    elif [[ $DAYS -eq 1 ]]; then
        echo -e "\e[38;2;123;201;111m  🌿 \e[0m\e[38;2;245;243;231m1 glorious day since the last incident. A new record? Probably not.\e[0m"
    else
        echo -e "\e[38;2;123;201;111m  🌿 \e[0m\e[38;2;245;243;231m${DAYS} days since the last incident. We're on a streak (don't jinx it).\e[0m"
    fi
fi

echo
# Drop into normal interactive shell
exec bash --login
