#!/bin/bash

# Text formatting :3
tx=$(date +"%a %d.%m %H:%M")
len=${#tx}

# Color saturation and lightnessss
sat=100
light=70

# Initialize output...
output=""

# Gradient
for (( i=0; i<len; i++ )); do
  char="${tx:i:1}"
  hue=$(( (i * 360 / len) % 360 ))
  rgb=$(convert -size 1x1 xc:"hsl($hue,${sat}%,${light}%)" -format "%[hex:u]" info:- 2>/dev/null)
  [ -z "$rgb" ] && rgb="FFFFFF"
  output+="<span foreground=\"#$rgb\">$char</span>"
done

# Escape output and slap it on teh module uwu
escaped_output=$(printf '%s' "$output" | sed 's/"/\\"/g')
echo "{\"text\": \"$escaped_output\"}"
