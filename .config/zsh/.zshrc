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

alias sh='start-hyprland &> /tmp/hypr.log'

alias pkgi='sudo pacman -S'

alias pkgr='sudo pacman -R'
alias pkgrs='sudo pacman -Rs'
alias pkgrns='sudo pacman -Rns'

alias pkgs='pacman -Ss'
alias pkgsi='pacman -Qs'

alias pkginfo='pacman -Si'
alias pkginfoi='pacman -Qi'

alias pkgup='sudo pacman -Sy'
alias pkgug='sudo pacman -Syu'

# Clean package cache (keep last 3)
alias pkgc='paccache -r'
# Remove all cached packages
alias pkgcc='sudo pacman -Scc'

alias pkgl='pacman -Q'
# List explicitly installed packages
alias pkgexp='pacman -Qe'
# List orphan packages
alias pkgorph='pacman -Qdt'
# Remove orphan packages
alias pkgrorph='sudo pacman -Rns $(pacman -Qdtq)'

alias pkgf='pacman -F'
# List package files
alias pkgfiles='pacman -Ql'
# Find package owning a file
alias pkgown='pacman -Qo'

# List package dependencies
alias pkgdeps='pactree'
# Reverse dependencies
alias pkgrdeps='pactree -r'

# Download package without installing
alias pkgdl='sudo pacman -Sw'

stove()
{
  cd ~/.git-repos/way_dots
  stow .; cd - > /dev/null
}

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

#=-[KEYBINDS]-=#
bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
