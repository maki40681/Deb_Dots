#=-[HISTORY MANAGEMENT]-=#
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/zsh/.zsh_history
setopt histignorealldups sharehistory

#=-[MODERN COMPLETION SYSTEM]-=#
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#=-[ALIASES]-=#
alias \
      ll='exa -lah' \
      sx='ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" &> /tmp/dwm.log' \

alias \
      pkgr='sudo nala remove' \
      pkgi='sudo nala install' \
      pkgup='sudo nala update' \
      pkgug='sudo nala upgrade'

alias \
      ga='git add' \
      gl='git log' \
      gd='git diff' \
      gp='git push' \
      gc='git clone' \
      gs='git status' \
      gcm='git commit -m'

#=-[FUNCTIONS]-=#
pkgs()
{
  apt search "$1" \
  | sed -nE '/testing/s/(.*)\/(.*)/\1/p' \
  | less
}

pkgfs()
{
  apt-file search "$1" \
  | sed -nE 's/([a-z-]*):(.*)/\1/p' \
  | uniq \
  | less
}

rnamewall()
{
  for file in $(ls ~/PICs/WALLs \
    | egrep -v '^.{6}\.jpg$')
  do
    cd ~/PICs/WALLs
    mv -v "$file" $(tr -dc a-z0-9 < /dev/urandom \
		    | head -c 6; echo '').jpg
    cd - > /dev/null
  done
}

slbuild()
{
  [ -e config.h ] && make install && rm *.o && \
  find ./ -type f -executable -exec rm {} \;
}

stove()
{
  cd ~/.git-repos/satan_cultists
  stow .; cd - > /dev/null
}

y()
{
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    	builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

swayimg-delete() {
    while IFS= read -r file; do
        rm -f -- "$file"
    done < <(swayimg "$@")
}

smv()
{
    local target=$1

    [[ -z $target ]] && {
        print -u2 "Usage: smv <target-directory>"
        return 1
    }

    mkdir -p -- "$target" || return

    swayimg * | while IFS= read -r file; do
        mv -v -- "$file" "$target/"
    done
}

#=-[ZSH PLUGINS]-=#
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

#=-[KEYBINDS]-=#
bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
