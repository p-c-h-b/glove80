#!/usr/bin/env bash
# Render one themed PNG per layer into images/ for the README.
set -euo pipefail
cd "$(dirname "$0")"

BG="#0d1117"
mkdir -p images

keymap -c kd_config.yaml parse -z config/glove80.keymap -o glove80.kd.yaml

for layer in base num fun mouse world magic; do
  svg="/tmp/kd_${layer}.svg"
  keymap -c kd_config.yaml draw -z glove80 glove80.kd.yaml -s "$layer" > "$svg"
  # inject a full-canvas dark rect so the PNG background matches the theme
  sed -i "s|\(<svg[^>]*>\)|\1<rect x=\"0\" y=\"0\" width=\"100%\" height=\"100%\" fill=\"$BG\"/>|" "$svg"
  inkscape "$svg" --export-type=png --export-filename="images/${layer}.png" \
    --export-background="$BG" --export-background-opacity=1 2>/dev/null
  echo "wrote images/${layer}.png"
done
