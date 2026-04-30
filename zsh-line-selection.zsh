# zle-selection.zsh
# Editor-like selection semantics for ZLE (emacs mode)

# Only activate in emacs keymap
bindkey -e >/dev/null 2>&1 || return

# ----- Shift+Arrow: start/extend selection -----

select-backward-char() {
  if (( ! REGION_ACTIVE )); then
    zle set-mark-command
  fi
  zle backward-char
}
zle -N select-backward-char

select-forward-char() {
  if (( ! REGION_ACTIVE )); then
    zle set-mark-command
  fi
  zle forward-char
}
zle -N select-forward-char

bindkey '^[[1;2D' select-backward-char
bindkey '^[[1;2C' select-forward-char

# ----- Plain arrows: cancel selection -----

plain-backward-char() {
  (( REGION_ACTIVE )) && MARK=''
  zle backward-char
}
zle -N plain-backward-char
bindkey '^[[D' plain-backward-char

plain-forward-char() {
  (( REGION_ACTIVE )) && MARK=''
  zle forward-char
}
zle -N plain-forward-char
bindkey '^[[C' plain-forward-char

# ----- Delete semantics -----

smart-backward-delete() {
  if (( REGION_ACTIVE )); then
    zle kill-region
    MARK=''
  else
    zle backward-delete-char
  fi
}
zle -N smart-backward-delete
bindkey '^?' smart-backward-delete