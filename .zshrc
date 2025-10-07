# ----- JACK'S MINIMAL ZSH -----

HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# To find both fd-find & bat
export PATH="$HOME/.local/bin:$PATH"

export XCURSOR_SIZE=24
export XCURSOR_THEME=Adwaita

# ----- Plugins -----
# Correct plugin paths (Oh My Zsh custom folder)
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# ----- FZF -----
# Keybindings & completion (for Ctrl+R history only)
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# Disable Ctrl+T and Alt+C (we only want Ctrl+R for history)
bindkey -r '^t'
bindkey -r '\ec'

# FZF preview options (uses bat/batcat)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always {} | head -200"'

# ----- Aliases -----
alias ll='ls -lah --group-directories-first --color=auto'
alias please='sudo $(fc -ln -1)'

# ----- Prompt -----
eval "$(starship init zsh)"

# ----- Ctrl+F: fuzzy search all files in $HOME and open in Neovim -----
fvim_all_widget() {
  local sel
  sel="$(
    fd --type f --hidden --follow \
       --exclude .git \
       --exclude node_modules \
       --exclude '*.cache' \
       --exclude .local \
       --exclude snap \
       --exclude .mozilla \
       --exclude .steam \
       . "$HOME" 2>/dev/null | fzf
  )" || return
  nvim "$sel"
  zle reset-prompt
}
zle -N fvim_all_widget
bindkey '^f' fvim_all_widget

# ----- Auto-start tmux if not already inside -----
if command -v tmux >/dev/null 2>&1; then
  [ -z "$TMUX" ] && exec tmux
fi
