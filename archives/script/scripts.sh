#!/usr/bin/env bash

# ╔═══════════════════════════════════════════════════════════════════════╗
# ║              EXEMPLOS DE SCRIPTS PARA O ROFI LAUNCHER                 ║
# ║        Salve cada função em ~/scripts/ com o nome correspondente       ║
# ╚═══════════════════════════════════════════════════════════════════════╝

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  1. system-update.sh - Atualização completa do sistema
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT1'
#!/usr/bin/env bash
echo "🔄 Atualizando o sistema..."
echo ""

# Atualiza repositórios oficiais e AUR
yay -Syu --noconfirm

# Atualiza flatpak se instalado
if command -v flatpak &> /dev/null; then
    echo ""
    echo "📦 Atualizando Flatpak..."
    flatpak update -y
fi

# Limpa cache antigo
echo ""
echo "🧹 Limpando cache..."
yay -Sc --noconfirm

echo ""
echo "✅ Sistema atualizado com sucesso!"
SCRIPT1

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  2. clean-system.sh - Limpeza profunda
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT2'
#!/usr/bin/env bash
echo "🧹 Limpando o sistema..."
echo ""

# Remove pacotes órfãos
echo "🗑️  Removendo pacotes órfãos..."
orphans=$(pacman -Qtdq)
if [ -n "$orphans" ]; then
    sudo pacman -Rns $orphans --noconfirm
else
    echo "Nenhum pacote órfão encontrado"
fi

# Limpa cache do pacman
echo ""
echo "📦 Limpando cache do pacman..."
sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

# Limpa cache de usuário
echo ""
echo "🗂️  Limpando cache de usuário..."
rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash/*

# Limpa logs antigos
echo ""
echo "📋 Limpando logs do sistema..."
sudo journalctl --vacuum-time=7d

# Mostra espaço liberado
echo ""
echo "💾 Espaço em disco:"
df -h / | tail -n 1

echo ""
echo "✅ Limpeza concluída!"
SCRIPT2

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  3. backup-config.sh - Backup de dotfiles
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT3'
#!/usr/bin/env bash
BACKUP_DIR="$HOME/Backups/dotfiles-$(date +%Y%m%d-%H%M%S)"

echo "💾 Fazendo backup das configurações..."
echo "📁 Destino: $BACKUP_DIR"
echo ""

mkdir -p "$BACKUP_DIR"

# Lista de diretórios para backup
configs=(
    "$HOME/.config/i3"
    "$HOME/.config/rofi"
    "$HOME/.config/polybar"
    "$HOME/.config/alacritty"
    "$HOME/.config/kitty"
    "$HOME/.config/nvim"
    "$HOME/.config/picom"
    "$HOME/.zshrc"
    "$HOME/.bashrc"
    "$HOME/.gitconfig"
)

# Faz backup de cada configuração
for config in "${configs[@]}"; do
    if [ -e "$config" ]; then
        echo "✓ Copiando $(basename $config)..."
        cp -r "$config" "$BACKUP_DIR/"
    fi
done

# Cria arquivo com lista de pacotes instalados
echo ""
echo "📝 Salvando lista de pacotes..."
pacman -Qqe > "$BACKUP_DIR/pkglist.txt"
pacman -Qqm > "$BACKUP_DIR/aurlist.txt"

echo ""
echo "✅ Backup concluído em: $BACKUP_DIR"
notify-send "Backup Completo" "Dotfiles salvos em $BACKUP_DIR"
SCRIPT3

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  4. project-switcher.sh - Seletor de projetos
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT4'
#!/usr/bin/env bash
PROJECTS_DIR="$HOME/projects"
TERMINAL="alacritty"

# Busca diretórios de projetos (até 2 níveis)
projects=$(fd -H -t d . "$PROJECTS_DIR" --max-depth 2 --min-depth 1)

# Mostra menu com rofi
selected=$(echo "$projects" | rofi -dmenu -i -p "󰈙 Projetos" -theme-str 'window {width: 600px;}')

if [ -n "$selected" ]; then
    # Abre terminal no projeto selecionado
    $TERMINAL --working-directory "$selected" &
    
    # Se tiver um editor preferido, abra também
    if command -v code &> /dev/null; then
        code "$selected" &
    fi
fi
SCRIPT4

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  5. git-push-all.sh - Push em todos os repos
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT5'
#!/usr/bin/env bash
PROJECTS_DIR="$HOME/projects"

echo "󰊢 Buscando repositórios Git..."
echo ""

# Encontra todos os repositórios git
repos=$(find "$PROJECTS_DIR" -name ".git" -type d -prune | sed 's/\/.git$//')

if [ -z "$repos" ]; then
    echo "❌ Nenhum repositório encontrado!"
    exit 1
fi

# Processa cada repositório
for repo in $repos; do
    repo_name=$(basename "$repo")
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📁 Repositório: $repo_name"
    echo ""
    
    cd "$repo" || continue
    
    # Verifica se há mudanças
    if [[ -n $(git status -s) ]]; then
        echo "✓ Mudanças detectadas"
        git add .
        git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
        git push
        echo "✅ Push realizado!"
    else
        echo "○ Sem mudanças"
    fi
    echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Processo concluído!"
notify-send "Git Push All" "Todos repositórios processados"
SCRIPT5

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  6. dev-server.sh - Inicia servidor de desenvolvimento
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT6'
#!/usr/bin/env bash

echo "🚀 Iniciando servidor de desenvolvimento..."
echo ""

# Detecta tipo de projeto e inicia servidor apropriado
if [ -f "package.json" ]; then
    echo "📦 Projeto Node.js detectado"
    
    # Verifica qual comando usar
    if grep -q "\"dev\":" package.json; then
        npm run dev
    elif grep -q "\"start\":" package.json; then
        npm start
    else
        echo "❌ Nenhum script 'dev' ou 'start' encontrado em package.json"
    fi
    
elif [ -f "manage.py" ]; then
    echo "🐍 Projeto Django detectado"
    python manage.py runserver
    
elif [ -f "app.py" ] || [ -f "main.py" ]; then
    echo "🐍 Projeto Python detectado"
    python3 -m http.server 8000
    
elif [ -f "index.html" ]; then
    echo "🌐 Projeto HTML estático detectado"
    python3 -m http.server 8000
    
else
    echo "❓ Tipo de projeto não detectado"
    echo "Iniciando servidor HTTP simples..."
    python3 -m http.server 8000
fi
SCRIPT6

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  7. quick-note.sh - Criar nota rápida
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT7'
#!/usr/bin/env bash
NOTES_DIR="$HOME/Documents/notes"
EDITOR="${EDITOR:-nvim}"

mkdir -p "$NOTES_DIR"

# Pergunta o título da nota
title=$(rofi -dmenu -p " Título da nota" -theme-str 'window {width: 500px;}')

if [ -z "$title" ]; then
    exit 0
fi

# Cria arquivo com timestamp
filename="$NOTES_DIR/$(date +%Y%m%d-%H%M%S)-${title// /-}.md"

# Template da nota
cat > "$filename" <<EOF
# $title

**Data:** $(date '+%d/%m/%Y %H:%M')

---

EOF

# Abre no editor
$EDITOR "$filename"

notify-send "Nota Criada" "Salva em: $(basename $filename)"
SCRIPT7

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  8. todo.sh - Gerenciador de tarefas simples
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT8'
#!/usr/bin/env bash
TODO_FILE="$HOME/.todo.txt"
touch "$TODO_FILE"

while true; do
    # Mostra lista de tarefas
    clear
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "           📝 TODO LIST"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    if [ -s "$TODO_FILE" ]; then
        nl -w2 -s'. ' "$TODO_FILE"
    else
        echo "  (Sem tarefas)"
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "1) Adicionar tarefa"
    echo "2) Remover tarefa"
    echo "3) Limpar todas"
    echo "4) Sair"
    echo ""
    read -p "Escolha: " choice
    
    case $choice in
        1)
            read -p "Nova tarefa: " task
            echo "$task" >> "$TODO_FILE"
            ;;
        2)
            read -p "Número da tarefa: " num
            sed -i "${num}d" "$TODO_FILE"
            ;;
        3)
            > "$TODO_FILE"
            echo "Lista limpa!"
            sleep 1
            ;;
        4)
            break
            ;;
    esac
done
SCRIPT8

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  9. pomodoro.sh - Timer Pomodoro
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT9'
#!/usr/bin/env bash
WORK_TIME=25  # minutos
BREAK_TIME=5  # minutos

pomodoro() {
    local minutes=$1
    local message=$2
    
    notify-send "🍅 Pomodoro" "$message - $minutes minutos"
    
    for ((i=minutes*60; i>0; i--)); do
        printf "\r⏱️  %02d:%02d restantes" $((i/60)) $((i%60))
        sleep 1
    done
    
    echo ""
    notify-send -u critical "🍅 Pomodoro" "$message concluído!"
    
    # Toca som (se tiver paplay instalado)
    if command -v paplay &> /dev/null; then
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    fi
}

echo "🍅 Iniciando Pomodoro..."
echo ""

while true; do
    pomodoro $WORK_TIME "Tempo de trabalho"
    
    read -p "Continuar? (s/n): " continue
    if [[ "$continue" != "s" ]]; then
        break
    fi
    
    pomodoro $BREAK_TIME "Tempo de pausa"
done

echo "✅ Sessão Pomodoro finalizada!"
SCRIPT9

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  10. screen-record.sh - Gravação de tela
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
: <<'SCRIPT10'
#!/usr/bin/env bash
OUTPUT_DIR="$HOME/Videos/screen-recordings"
mkdir -p "$OUTPUT_DIR"

# Gera nome do arquivo
filename="$OUTPUT_DIR/recording-$(date +%Y%m%d-%H%M%S).mp4"

# Menu de opções
option=$(echo -e "Tela inteira\nÁrea selecionada\nCancelar" | \
    rofi -dmenu -p "󰄀 Gravar" -theme-str 'window {width: 300px;}')

case "$option" in
    "Tela inteira")
        notify-send "Gravação" "Iniciando em 3 segundos..."
        sleep 3
        ffmpeg -f x11grab -s 1920x1080 -i :0.0 "$filename"
        ;;
    "Área selecionada")
        notify-send "Gravação" "Selecione a área..."
        slop=$(slop -f "%x %y %w %h")
        read -r X Y W H <<< "$slop"
        ffmpeg -f x11grab -s ${W}x${H} -i :0.0+${X},${Y} "$filename"
        ;;
    *)
        exit 0
        ;;
esac

notify-send "Gravação Concluída" "Salvo em: $(basename $filename)"
SCRIPT10

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 INSTRUÇÕES:"
echo ""
echo "1. Crie o diretório: mkdir -p ~/scripts"
echo "2. Copie cada script acima para seu arquivo correspondente"
echo "3. Dê permissão de execução: chmod +x ~/scripts/*.sh"
echo "4. Configure o launcher.sh com os caminhos corretos"
echo ""
echo "✨ Todos os scripts estão prontos para uso!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
