#!/usr/bin/env bash
# Synthesise a big-block V8 soundtrack for the intro.
#
# Neither video model would give us one: both returned a small-engine buzz
# (energy peaking in the 0.5-3kHz band, with the bass 5-6dB BELOW it, when a
# V8 is the exact inverse). Higgsfield's audio models are text-to-speech only.
# So we build it from first principles instead of asking.
#
# A V8's exhaust note is a pulse train at the firing frequency:
#   f_fire = rpm / 60 * (cylinders / 2) = rpm / 15
# So 800rpm idle = 53Hz, 4500rpm = 300Hz. Summing harmonics of that gives the
# sawtooth-ish exhaust; a half-frequency term adds the lumpy off-beat throb a
# crossplane V8 is recognised by; filtered noise on top is induction roar.
# Everything is lowpassed hard so the result is bass-dominant by construction.
#
# Usage: ./v8.sh <out.wav> [duration]
set -euo pipefail
OUT="${1:?usage: v8.sh <out.wav> [duration]}"
DUR="${2:-3.0}"
FFMPEG="${FFMPEG:-$(node -e "console.log(require('ffmpeg-static'))" 2>/dev/null || echo ffmpeg)}"
SR=48000

# Beat timing (seconds, in the finished 3s cut)
T_START=1.30   # ignition bark as he lands astride
T_REV=2.05     # throttle pinned, front wheel comes up
F_IDLE=55      # ~825rpm
F_MAX=300      # ~4500rpm
K=$(awk -v a="$F_IDLE" -v b="$F_MAX" -v t0="$T_REV" -v t1="$DUR" 'BEGIN{printf "%.4f",(b-a)/(t1-t0)}')

# Instantaneous phase: constant at idle, then a linear frequency ramp
# integrated analytically so the two halves join without a click.
PH="(2*PI*(if(lt(t,${T_REV}), ${F_IDLE}*t, ${F_IDLE}*t + 0.5*${K}*(t-${T_REV})*(t-${T_REV}))))"

# Envelope: silent until ignition, a bark, settle to idle, then swell to full.
ENV="(if(lt(t,${T_START}),0,\
if(lt(t,${T_START}+0.10),(t-${T_START})/0.10,\
if(lt(t,${T_REV}),0.55,\
min(1.0,0.55+0.45*(t-${T_REV})/0.45)))))"

# Exhaust: harmonic stack (sawtooth-like) + half-order lumpy throb.
EXH="(0.55*sin(${PH})+0.30*sin(2*${PH})+0.20*sin(3*${PH})+0.13*sin(4*${PH})\
+0.09*sin(5*${PH})+0.06*sin(6*${PH})+0.22*sin(0.5*${PH}))"

"$FFMPEG" -y -hide_banner -loglevel error \
  -f lavfi -i "aevalsrc=exprs='${ENV}*${EXH}':s=${SR}:d=${DUR}" \
  -f lavfi -i "anoisesrc=c=pink:r=${SR}:d=${DUR}:a=0.5" \
  -filter_complex "\
   [0:a]alimiter=limit=0.95,volume=3.0[core];\
   [core]lowpass=f=520:p=2,highpass=f=32[body];\
   [1:a]lowpass=f=900,highpass=f=160,volume=0.30[air];\
   [body][air]amix=inputs=2:weights='1 0.35':normalize=0[mix];\
   [mix]bass=g=11:f=85:w=0.6,treble=g=-9:f=2200,\
        acompressor=threshold=0.12:ratio=4:attack=8:release=180,\
        alimiter=limit=0.92,\
        afade=t=out:st=$(awk -v d="$DUR" 'BEGIN{printf "%.2f",d-0.35}'):d=0.35[out]" \
  -map "[out]" -ac 2 -ar ${SR} "$OUT"

echo "--- band balance (bass must beat buzz) ---"
band () { "$FFMPEG" -hide_banner -loglevel info -i "$OUT" -af "$1,volumedetect" -f null - 2>&1 | sed -n 's/.*mean_volume: \(.*\)/\1/p'; }
echo "bass   <150Hz : $(band 'lowpass=f=150')"
echo "buzz  0.5-3kHz: $(band 'highpass=f=500,lowpass=f=3000')"
