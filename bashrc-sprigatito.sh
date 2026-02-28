# ║         🌿 Sprigatito Rice — bash additions       ║
# ╚══════════════════════════════════════════════════╝

# ── PATH ─────────────────────────────────────────────
export PATH="$HOME/local/bin:$PATH"

# ── Aliases ───────────────────────────────────────────
alias please='sudo'                          # manners cost nothing
alias oops='git commit --amend --no-edit'    # we've all been there
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# yeet: rm -rf with a conscience
yeet() {
    if [[ -z "$1" ]]; then
        echo "🌿 yeet <path> — rm -rf but you have to mean it"
        return 1
    fi
    read -rp "🌿 yeet '$1'? this is permanent. (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        rm -rf "$1" && echo "🌿 yeeted." || echo "🌿 yeet failed. the forest is safe."
    else
        echo "🌿 abort. everything is fine. nothing happened."
    fi
}

# ── Starship prompt ──────────────────────────────────
eval "$(starship init bash)"

