#!/usr/bin/env bash
# Convert square renders into web-ready jpegs for the rabbit scroll-driven canvas.
# Source:
#   ui/src/flythrough_1920/fly_NNNN.jpg  — 1920x1920 jpg, all 360 frames
# Output (ui/src/pages/rabbit/frames/):
#   fly_NNN.jpg                          — 1440x1440, q=72 (single series, used everywhere)
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
src_dir="$(cd "$here/../../flythrough_1920" && pwd)"
out_dir="$here/frames"
mkdir -p "$out_dir"

# Clear stale outputs (any old portrait / @hi files).
rm -f "$out_dir"/fly_*.jpg

total=360
for i in $(seq 1 $total); do
  src=$(printf "%s/fly_%04d.jpg" "$src_dir" "$i")
  dst=$(printf "%s/fly_%03d.jpg" "$out_dir" "$i")
  if [[ ! -f "$src" ]]; then
    echo "missing source: $src" >&2
    exit 1
  fi

  sips --resampleWidth 1440 -s format jpeg -s formatOptions 72 "$src" --out "$dst" > /dev/null

  if (( i % 30 == 0 )); then
    printf "frame %3d / %d\n" "$i" "$total"
  fi
done

echo
echo "Done. Output size:"
du -sh "$out_dir"
