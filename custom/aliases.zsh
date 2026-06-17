#Global Aliases
alias -g G='| rg'
alias -g EMPTY='echo "" > '
alias -g L='| lolcat -a -d 2 -s 60'
alias -g J='| jq'
alias -g CLIP='| xclip -selection clipboard'
alias -g PAGE='| gum pager'
alias -g B='| gum style --border-foreground="111" --border=rounded --bold --foreground=121'
alias -g CL='| wc -l | gum style --border-foreground="111" --border=rounded --bold --foreground=121'
alias -g CW='| wc -w | gum style --border-foreground="111" --border=rounded --bold --foreground=121'
alias -g CB='| wc -c | gum style --border-foreground="111" --border=rounded --bold --foreground=121'

#Suffix Aliases
alias -s zig="$EDITOR"
alias -s c="$EDITOR"
alias -s md="mcat --pager='gum pager --no-soft-wrap' --theme=catppuccin --md-image none"
alias -s py="$EDITOR"
alias -s sh="zsh"
alias -s js="$EDITOR"
alias -s ts="$EDITOR"
alias -s cpp="$EDITOR"
alias -s go="$EDITOR"
alias -s lua="$EDITOR"
alias -s json="mcat"
alias -s yml="mcat"
alias -s yaml="mcat"
alias -s log="mcat"
alias -s html="chromium"
alias -s pdf="chromium"
alias -s mkv="mpv"
alias -s mp4="mpv"
alias -s exs="$EDITOR"
alias -s erl="$EDITOR"
alias -s rs="$EDITOR"

# Aliases úteis
alias update='yay -Syu'
alias remove='yay -Rns'
alias cat='mcat --theme=catppuccin --no-center'
alias vim='nvim'
alias lg='lazygit'
alias lk='lazydocker'
alias lq='sqlit'
alias lnpm='lazynpm'
alias lss="lazyssh"
alias dk='docker'
alias dkc='docker-compose'
alias lc='/home/fevunge/.nvm/versions/node/v24.13.1/bin/lazycommit -t conventional'
alias cop="copilot"
alias tree='exa -T'
alias runconf='vim /usr/local/bin/run'
alias minecraft='java -jar ~/archives/java/TLauncher.jar'
alias mconda='source ~/miniconda3/bin/activate'
alias ws='websocat'
alias clock='tty-clock -sc -C 4 -b'
alias x="exit"
alias c="clear"
alias vps="ssh administrator@192.168.1.20"

