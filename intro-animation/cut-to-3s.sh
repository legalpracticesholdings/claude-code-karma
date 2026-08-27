#!/usr/bin/env bash
# Compress a 5-second Higgsfield take down to exactly 3.00s.
#
# The video model needs five seconds to actually perform six beats — asked for
# three it silently drops the last ones. So we shoot long and compress in the
# edit: every beat survives, and the 1.67x speed-up reads as comic urgency
# rather than fast-forward. Audio is pitch-preserved via atempo.
#
# Usage: ./cut-to-3s.sh <input.mp4> <output.mp4>
set -euo pipefail

IN="${1:?usage: cut-to-3s.sh <input.mp4> <output.mp4>}"
OUT="${2:?usage: cut-to-3s.sh <input.mp4> <output.mp4>}"
FFMPEG="${FFMPEG:-$(node -e "console.log(require('ffmpeg-static'))" 2>/dev/null || echo ffmpeg)}"

SRC_DUR=$("$FFMPEG" -hide_banner -i "$IN" 2>&1 | sed -n 's/.*Duration: \([0-9:.]*\).*/\1/p' \
  | awk -F: '{print ($1*3600)+($2*60)+$3}')
RATE=$(awk -v d="$SRC_DUR" 'BEGIN{printf "%.6f", d/3.0}')
echo "source ${SRC_DUR}s -> 3.00s (${RATE}x)"

"$FFMPEG" -y -hide_banner -loglevel error -i "$IN" \
  -filter_complex "[0:v]setpts=PTS/${RATE}[v];[0:a]atempo=${RATE}[a]" \
  -map "[v]" -map "[a]" \
  -t 3.0 \
  -c:v libx264 -profile:v high -pix_fmt yuv420p -crf 18 -preset slow \
  -c:a aac -b:a 192k -movflags +faststart \
  "$OUT"

"$FFMPEG" -hide_banner -i "$OUT" 2>&1 | grep -E "Duration|Stream"
