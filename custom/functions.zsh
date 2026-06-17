t () {
  LEVEL=${2:-1}
  DIRECTORY=${1:-.}
  eza "$DIRECTORY" --tree --level="$LEVEL" --icons
}

p-open () {
  projects=$(fd -H -t d . "$PROJECTS_DIR" --max-depth 1 --min-depth 1)
  choose=$(echo "$projects" | awk -F'/' '{ print $5 }' | gum filter)
  if [ -z "$choose" ]; then
    return 1
  fi
  cd "$PROJECTS_DIR/$choose" || exit 11
  README.md
  gum confirm "open with VSCode?" && {
    code .
  }
}

p-new () {
  name=$(gum input --header="project name" --no-show-help --header.foreground=5 --placeholder="..." --prompt=": " --padding="1 1")
  if [[ ! -z "$name" ]]; then
    dir="$PROJECTS_DIR/$name"
    mkdir "$dir/"
    cp "$HOME/templates/README.md" "$dir/README.md"
    cp "$HOME/templates/CHANGELOG.md" "$dir/CHANGELOG.md"
    cd "$dir"
    git init
    git add README.md
    git commit -m "chore: add README.md default template into project"
    git add CHANGELOG.md
    git commit -m "chore: create CHANGELOG.md file to log project's relevants changes"
    tool=$(gum filter --placeholder="Tool" "c/c++" "python" "lua" "nodejs")
    if [[ ! -z "$tool" ]]; then
      if [[ $tool == "clang" ]]; then
        cp ~/templates/main.c  "$dir/"
        echo -e "build/\ntarget/\na.out" > "$dir/.gitignore"
      fi
    fi
  else
    gum log --structured --level debug "canceled" "cause" "no name"
  fi
}

p-rm () {
  projects=$(fd -H -t d . "$PROJECTS_DIR" --max-depth 1 --min-depth 1)
  choose=$(echo "$projects" | awk -F'/' '{ print $5 }' | gum filter --placeholder "project to remove")
  if [ -z "$choose" ]; then
    return 1
  fi
  cd "$HOME"
  sudo del "$PROJECTS_DIR/$choose"
}

 

dserve() {
  server=$(ss -tulnp | grep "LISTEN" | awk '{ printf "%s\n", $5 }' | gum choose)
  if [ ! -z "$server" ]; then
    chromium "http:\\$server"
  fi
}

 edit_conf_file () {
   conf=$(gum filter --placeholder="Configurations" "shell terminal" "i3 window manager" "polybar" "tmux" "terminal alias" "terminal functions" "reload")
   if [[ ! -z "$conf" ]]; then
    if [[ "$conf" == "shell terminal" ]]; then
     nvim "$HOME/.zshrc"   
    elif [[ "$conf" == "i3 window manager"  ]]; then
      nvim "$HOME/.config/i3/config"
    elif [[ "$conf" == "polybar" ]]; then
      vim "$HOME/.config/polybar/config.ini"
    elif [[ "$conf" == "tmux" ]]; then
      vim "$HOME/.config/tmux/tmux.conf"
    elif [[ "$conf" == "terminal alias" ]]; then
      vim "$HOME/.oh-my-zsh/custom/aliases.zsh"
    elif [[ "$conf" == "terminal functions" ]]; then
      sudo nvim "$HOME/.oh-my-zsh/custom/functions.zsh"
    elif [[ "$conf" == "reload" ]]; then
      gum log --structured --level info "reloading shell..."
      source "$HOME/.zshrc"
    else
      gum log --structured --level debug "canceled" "cause" "$conf not found"
    fi
  else
    gum log --structured --level debug "canceled" "cause" "no name"
  fi 
  zle -N edit_conf_file
 }

chpwd() {
  pwd
}

install() {
  if [ "$#" -eq 0 ]; then
    gum log  --structured --level error "No package specified for installation."
    package=$(run_input "Package")
    echo "$package"
    return 1
  fi
  gum confirm "Install package(s): $* ?" && {
    yay -S "$1"
    if [ "$?" -eq 0 ]; then
      echo "- $1" >> "$HOME/archives/data/tools.md"
      gum log --structured --level info "Process finished successfully: $*"
    else
      gum log --structured --level error "Failed to install package(s): $*"
    fi
  }
}

template() {
  template_dir="/home/fevunge/templates/"
  template=$( run_select $(ls /home/fevunge/templates/))
  #template=$(ls /home/fevunge/templates/ | run_select "Template")
  if [[ -z "$template" ]]; then 
    gum log --structured --level info "none selected"
    return
  fi
  if [[ "$template" == "ADR.md" ]]; then
    adr_number=$(gum input --header="adr name" --no-show-help --header.foreground=5 --placeholder="NNN-description" --prompt="ADR- " --padding="1 1")
    cp -r "$template_dir$template" "./ADR-$adr_number.md"
    return 0
  fi
  gum confirm "rename: $template ?" && {
    name=$(gum input --header="New name" --no-show-help --header.foreground=5 --placeholder="..." --prompt=":: " --padding="1 1")
  } || {
    name=$template
  }
  cp -r "$template_dir$name" .
}

video_wallpaper() {
  xwinwrap -ov -fs -- mpv -wid %WID \
    --loop \
    --no-audio \
    --no-input-default-bindings \
    --no-osc \
    --no-osd-bar \
    --cursor-autohide=always \
    --cursor-autohide-fs-only \
    --no-input-cursor \
    --panscan=1.0 \
    --no-keepaspect-window \
    "$1" &
 }

dayly () {
  if [[ "$1" == "list" ]]; then
    mcat "$HOME/archives/data/dayly_log"
  else
    date=$(date | tr ' ' '_')
    name=$(echo "$date.md")
    vim "$HOME/archives/data/dayly_log/$name"
  fi
}

