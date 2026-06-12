#!/usr/bin/env bash
# Regenerate the themed keymap diagram (glove80.svg + glove80.pdf) from the keymap.
set -euo pipefail
cd "$(dirname "$0")"

BG="#0d1117"

keymap -c kd_config.yaml parse -z config/glove80.keymap -o glove80.kd.yaml
python3 mark-held.py glove80.kd.yaml
keymap -c kd_config.yaml draw glove80.kd.yaml > glove80.svg

# keymap-drawer emits no background; inject a full-canvas rect so the canvas is
# dark in every renderer (browser, image viewers, PDF), not just the PDF page.
sed -i "s|\(<svg[^>]*>\)|\1<rect x=\"0\" y=\"0\" width=\"100%\" height=\"100%\" fill=\"$BG\"/>|" glove80.svg

inkscape glove80.svg --export-type=pdf --export-filename=glove80.pdf \
  --export-background="$BG" --export-background-opacity=1 2>/dev/null

echo "wrote $(pwd)/glove80.pdf"
