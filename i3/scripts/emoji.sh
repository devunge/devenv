emoji=$(exec /home/fevunge/.config/rofi/emoji/emoji.pl 2>/dev/null)
echo "$emoji"
echo "$emoji" | xclip -selection clipboard
notify-send "Emoji" "$emoji cliped"
