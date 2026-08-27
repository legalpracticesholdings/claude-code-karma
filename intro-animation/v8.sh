#!/usr/bin/env bash
# Synthesise a big-block V8 soundtrack for the intro.
#
# Neither video model would give one: both returned a small-engine buzz.
# Higgsfield's audio models are text-to-speech only, so we build it here.
#
# An engine is IMPULSIVE, not tonal. Each firing is a sharp crack that rings
# and decays in the exhaust; it is the transient that makes the ear hear
# "engine", and the fundamental that makes it hear "big". An earlier version
# lowpassed everything away to hit a bass-dominant measurement and produced a
# smooth drone - the number was right and the sound was wrong. So: a damped
# resonant burst per firing, kept broadband, with the weight carried by the
# firing rate rather than by filtering the life out of it.
#
#   f_fire = rpm / 60 * (cylinders / 2) = rpm / 15
#   800rpm idle = 53Hz, 4500rpm = 300Hz
#
# Crossplane V8s fire unevenly across the banks, which is where the lumpy
# off-beat throb comes from - modelled by alternating pulse weight.
#
# Usage: ./v8.sh <out.wav> [duration]
set -euo pipefail
OUT="${1:?usage: v8.sh <out.wav> [duration]}"
DUR="${2:-3.0}"
FFMPEG="${FFMPEG:-$(node -e "console.log(require('ffmpeg-static'))" 2>/dev/null || echo ffmpeg)}"
SR=48000

T_START=1.30   # ignition bark as he lands astride
T_REV=2.05     # throttle pinned, front wheel comes up
F_IDLE=48      # ~720rpm, lopey
F_MAX=290      # ~4350rpm
K=$(awk -v a="$F_IDLE" -v b="$F_MAX" -v t0="$T_REV" -v t1="$DUR" 'BEGIN{printf "%.4f",(b-a)/(t1-t0)}')

# Phase in CYCLES (not radians), integrated analytically so idle and ramp join
# without a click.
PH="(if(lt(t,${T_REV}), ${F_IDLE}*t, ${F_IDLE}*t + 0.5*${K}*(t-${T_REV})*(t-${T_REV})))"
FR="(${PH}-floor(${PH}))"                      # 0..1 within each firing
CY="(floor(${PH}))"                            # which firing

# Alternating bank weight -> the lumpy V8 throb.
AMP="(1.0-0.30*mod(${CY},2))"

# One firing = a hard attack ringing down through pipe resonances.
PULSE="(${AMP}*exp(-7.0*${FR})*(sin(2*PI*3.0*${FR})+0.60*sin(2*PI*6.5*${FR})+0.35*sin(2*PI*11.0*${FR})+0.20*sin(2*PI*19.0*${FR})))"

ENV="(if(lt(t,${T_START}),0,\
if(lt(t,${T_START}+0.06),(t-${T_START})/0.06,\
if(lt(t,${T_REV}),0.5,\
min(1.0,0.5+0.5*(t-${T_REV})/0.40)))))"

"$FFMPEG" -y -hide_banner -loglevel error \
  -f lavfi -i "aevalsrc=exprs='${ENV}*${PULSE}':s=${SR}:d=${DUR}" \
  -f lavfi -i "anoisesrc=c=brown:r=${SR}:d=${DUR}:a=0.6" \
  -filter_complex "\
   [0:a]volume=4.0,alimiter=limit=0.95[dry];\
   [dry]equalizer=f=80:w=1.1:t=o:g=10,\
        equalizer=f=190:w=1.0:t=o:g=6,\
        equalizer=f=430:w=1.2:t=o:g=4,\
        equalizer=f=1100:w=1.4:t=o:g=-3,\
        lowpass=f=6500[body];\
   [1:a]lowpass=f=260,volume=0.55[rumble];\
   [body][rumble]amix=inputs=2:weights='1 0.5':normalize=0[mix];\
   [mix]acompressor=threshold=0.10:ratio=5:attack=3:release=140,\
        bass=g=8:f=70:w=0.7,\
        alimiter=limit=0.93,\
        afade=t=out:st=$(awk -v d="$DUR" 'BEGIN{printf "%.2f",d-0.30}'):d=0.30[out]" \
  -map "[out]" -ac 2 -ar ${SR} "$OUT"

band () { "$FFMPEG" -hide_banner -loglevel info -i "$OUT" -af "$1,volumedetect" -f null - 2>&1 | sed -n 's/.*mean_volume: \(.*\)/\1/p'; }
echo "bass    <150Hz : $(band 'lowpass=f=150')"
echo "midbody 150-800: $(band 'highpass=f=150,lowpass=f=800')"
echo "rasp   0.8-4kHz: $(band 'highpass=f=800,lowpass=f=4000')"
