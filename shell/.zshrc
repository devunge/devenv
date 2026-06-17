# If you come from bash you might have to change your $PATH.

#Vars
PATH=/bin:/sbin:/usr/bin:/usr/local/bin:$HOME/.local/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="ys" # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

export GO_BIN="$HOME/go/bin/"

export DRMEMORY_BIN="/opt/drmemory/bin/"
export ZIG_DIR="$HOME/.zig"
export CARGO_BIN="$HOME/.cargo/bin/"
export NODE_BIN="$NVM_DIR/versions/node/v24.13.1/bin/"
export MINICONDA_BIN="$HOME/miniconda3/bin/"
export JAVA_BIN="/opt/java/jdk-21-oracle/bin/"

export CODE_LANG_BIN="$NODE_BIN:$CARGO_BIN:$JAVA_BIN:$MINICONDA_BIN:$ZIG_DIR"

export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch $(uname -m)"
export EDITOR=nvim
export JAVA_HOME="/opt/java/jdk-21-oracle/"
export NVM_DIR="$HOME/.nvm"
export RUST_DIR="$HOME/.cargo"
export OPENCODE_HOME="$HOME/.opencode"

export PATH="$DRMEMORY_BIN:$GO_BIN:$CODE_LANG_BIN:$OPENCODE_HOME/bin/:$PATH" 

export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always {}"'
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
export PROJECTS_DIR="$HOME/projects"

#plugins
plugins=(
    git
    docker
    docker-compose
    npm
    sudo
    node
    python
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    zsh-z
)

#source 
source $ZSH_CUSTOM/aliases.zsh
source $ZSH_CUSTOM/functions.zsh
source $ZSH_CUSTOM/completion.zsh
source $ZSH/oh-my-zsh.sh

bindkey '^F' fzf-file-widget

superfile() {
  spf
  zle reset-prompt
}
zle -N superfile
bindkey '^E' superfile

zle -N edit_conf_file
bindkey '^Q' edit_conf_file
alias q=edit_conf_file

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

[ -s "$RUST_DIR/env" ] && . "$RUST_DIR/env"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

#compdef mcat

autoload -U is-at-least

_mcat() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'-t+[Color theme]:THEME:(catppuccin nord monokai dracula gruvbox one-dark solarized tokyo-night makurai-light makurai-dark ayu ayu-mirage github synthwave material rose-pine kanagawa vscode everforest autumn spring)' \
'--theme=[Color theme]:THEME:(catppuccin nord monokai dracula gruvbox one-dark solarized tokyo-night makurai-light makurai-dark ayu ayu-mirage github synthwave material rose-pine kanagawa vscode everforest autumn spring)' \
'-o+[Output format]:format:(html md image inline interactive)' \
'--output=[Output format]:format:(html md image inline interactive)' \
'--spx=[Pixel bounding box for image rendering, auto-detected by default (e.g. 1920x1080, 1920xauto, autox1080)]:WxH:_default' \
'--sc=[Bounding box in columns x rows, auto-detected by default, affects both image sizing and markdown rendering (e.g. 100x20, 100xauto, autox20)]:WxH:_default' \
'--scalex=[Scale multiplier applied over both spx and sc width]:float:_default' \
'--scaley=[Scale multiplier applied over both spx and sc height]:float:_default' \
'--md-image=[What images to render in the markdown]:mode:(all small none auto)' \
'--padding=[Horizontal padding]:PADDING:_default' \
'--color=[]:COLOR:(never always auto)' \
'--pager=[Modify the default pager]:command:_default' \
'--paging=[]:PAGING:(never always auto)' \
'--img-width=[Image render width (e.g. 80% of terminal, 40c columns, 1920px pixels)]:size:_default' \
'--img-height=[Image render height (e.g. 80% of terminal, 40c rows, 1080px pixels)]:size:_default' \
'--img-zoom=[Image zoom level]:level:_default' \
'--img-x-offset=[X offset from top-left corner in pixels]:pixels:_default' \
'--img-y-offset=[Y offset from top-left corner in pixels]:pixels:_default' \
'--sort=[Sort method]:SORT:(name size time type)' \
'--ls-x-padding=[Cell x padding (e.g. 3c columns, 10% of the terminal, 100px pixels)]:size:_default' \
'--ls-y-padding=[Cell y padding (e.g. 2c rows, 10% of the terminal, 100px pixels)]:size:_default' \
'--ls-min-width=[Minimum cell width (e.g. 2c columns, 10% of the terminal, 100px pixels)]:size:_default' \
'--ls-max-width=[Maximum cell width (e.g. 16c columns, 10% of the terminal, 100px pixels)]:size:_default' \
'--ls-height=[Cell height (e.g. 2c rows, 10% of the terminal, 100px pixels)]:size:_default' \
'--ls-items-per-row=[Maximum items per row]:count:_default' \
'--generate=[Generate shell completions]:shell:(bash elvish fish powershell zsh)' \
'--stdin-piped[]' \
'-i[Shortcut for --output inline]' \
'-I[Shortcut for --output interactive]' \
'--report[Show capabilities and terminal info]' \
'--silent[Remove loading bars]' \
'--no-linenumbers[Disable line numbers in code blocks]' \
'-f[Shortcut for --md-image none]' \
'--force-embed-images[Embed images as base64 in markdown. Images inside archives lack file paths and are normally dropped. This embeds them as data URIs for a complete output, useful when saving markdown for an external renderer. Enabled automatically when rendering images]' \
'--header[Shows YAML headers too]' \
'-c[Force ANSI formatting on]' \
'-C[Force ANSI formatting off]' \
'-p[Force paging on]' \
'-P[Force paging off]' \
'--kitty[Use Kitty image protocol]' \
'--iterm[Use iTerm2 image protocol]' \
'--sixel[Use Sixel image protocol]' \
'--ascii[Use ASCII art output]' \
'--no-center[Disable centering the image in the terminal]' \
'--style-html[Add styling to HTML output]' \
'-a[Include hidden files]' \
'--hidden[Include hidden files]' \
'--hyprlink[Add hyperlinks to file names]' \
'-X[Shortcut for --sort type]' \
'-S[Shortcut for --sort size]' \
'-r[Reverse the order of items]' \
'--reverse[Reverse the order of items]' \
'--fetch-chromium[Download and prepare chromium]' \
'--fetch-ffmpeg[Download and prepare ffmpeg]' \
'--fetch-clean[Clean up local binaries]' \
'-v[Enable verbose debug logging]' \
'--verbose[Enable verbose debug logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::input -- Input source (file/dir/url/ls):_default' \
&& ret=0
}

(( $+functions[_mcat_commands] )) ||
_mcat_commands() {
    local commands; commands=()
    _describe -t commands 'mcat commands' commands "$@"
}

if [ "$funcstack[1]" = "_mcat" ]; then
    _mcat "$@"
else
    compdef _mcat mcat
fi


eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(mise activate zsh)"




# opencode
export PATH=/home/fevunge/.opencode/bin:$PATH

# bun completions
[ -s "/home/fevunge/.bun/_bun" ] && source "/home/fevunge/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
