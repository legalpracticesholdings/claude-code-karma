# Club to Throttle

A 3-second cold open for Pete's Asia vlog. A caveman trudges in dragging his club,
spots a motorbike, hurls the club over his shoulder and rides off in a cloud of dust.

## Deliverables

| File | Use |
|------|-----|
| `renders/caveman-intro.mp4` | Master — 1920×1080, 30 fps, H.264 / yuv420p, 3.00 s |
| `renders/caveman-intro.webm` | VP9, for the web |
| `renders/caveman-intro.gif` | 800 px loop, for chat and thumbnails |
| `caveman-intro.html` | The animation itself, plus a scrubbable player |

No audio track — drop a sting under it in the edit.

## Beat sheet

| # | In | Beat |
|---|-----|------|
| 1 | 0.00 s | Trudge — he drags the club in from stage left |
| 2 | 0.95 s | Double take — boots lock up, eyes go wide |
| 3 | 1.28 s | Club away — one wind-up and it is gone over his shoulder |
| 4 | 1.62 s | The leap — crouch, spring, a full-frame arc onto the saddle |
| 5 | 2.00 s | Touchdown — hard enough to bottom the suspension out |
| 6 | 2.16 s | Gone — front wheel up, dust, out the right of frame |

## How it works

`caveman-intro.html` is a single self-contained page. Everything is drawn with the
Canvas 2D API — no images, no video, no libraries. The whole scene is a pure
function of time: `renderFrame(ctx, t)` for any `t` in `[0, 3]` produces the same
pixels every time, with no RNG and no reliance on wall-clock timing. That is what
makes the render frame-exact, and it means the browser preview and the MP4 match.

Structure, top to bottom:

- **Art layer** — `backdrop()` (sky, sun, volcano, parallax ridges and ground),
  `caveman()`, `bike()`, `club()`, and the dust/speed-line effects.
- **Rig** — `rig()` turns a pose object (joint angles, lean, head tilt, face state)
  into world-space joint positions. `ik()` solves a two-bone chain when it is easier
  to say "put the hand on the grip" than to name the angles.
- **Choreography** — `poseFor(t)` builds the pose for every grounded and airborne
  beat; `riderPose(t)` handles him once he is welded to the bike.
- **Player** — the transport bar, beat-marked scrubber and keyboard controls.

Two coordinate tricks worth knowing before you edit:

- The action is drawn at 1:1 and then scaled by `ACT_S` about the ground line, so
  changing that one number resizes the whole performance without anything floating
  off the ground.
- While he is riding, the caveman is drawn *inside* the bike's transform, so the
  wheelie rotates the pair together. His pose coordinates there are bike-local.

## Re-rendering

```bash
npm install      # playwright + a static ffmpeg
npm run render   # 90 frames via headless Chromium, then MP4 / WebM / GIF
```

`render.mjs` drives the page one frame at a time through `window.__renderAt(t)`
rather than recording playback, so nothing is dropped. Useful flags:

```bash
node render.mjs --out renders --contact
```

## Tweaking it

Most changes are one number in `caveman-intro.html`:

| Want | Change |
|------|--------|
| Different timing | the `K` object — every beat boundary in seconds |
| Bigger or smaller action | `ACT_S` |
| Bike colour | `BODY` / `BODY_D` |
| Longer or shorter cut | `DUR` (the player and renderer both read it) |
| Where he stops and leaps from | `SKID_X`, `BIKE_X` |

To put Pete's channel name on the end, draw it in `renderFrame` after the action —
but bear in mind the last frame cuts on action deliberately, so a title card would
need a few frames added to `DUR`.
