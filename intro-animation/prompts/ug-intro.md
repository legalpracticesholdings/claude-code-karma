# Ug Intro — living prompt

**Version:** v11 (travel direction dominant, taller Ug)

## Locked context
- Character is **Ug**: Pete as a bald caveman. Locked to the approved caricature.
- The series is Pete's **Asia travel vlog**. Multiple versions eventually; **v1 rides the Asian scooter**.
- 3 seconds, 16:9, cold open, cuts on action.

## Changelog
- **v2** — trail bike replaced with a black Asian maxi-scooter (Honda PCX type).
- **v2** — scooter turned to face **screen right**, same direction Ug walks, so he rides off the way he was already heading.
- **v3** — the near background is now **Vietnamese rice paddies with farmers in conical nón lá hats**, bent over planting in flooded, mirror-flat fields.
- **v3** — *(assumed, say the word and it reverts)* the **volcano is replaced by limestone karst peaks**. Every rice-field reference shows karsts, and they are the Vietnam signature; a volcano next to a paddy reads prehistoric, which now fights the joke instead of feeding it.
- **v11** — **travel direction made the dominant constraint.** v10's four absolute left/right club anchors competed with his walking direction, and the model resolved the conflict by flipping him round to walk away from the scooter. The club is now defined RELATIVE to his travel ("behind him, on the side away from the scooter") rather than by frame-absolute direction, with facing pinned first and hardest. Stacking independent absolute directions lets a model trade one against another; deriving them from one primary fact does not.
- **v11** — **Ug back to the taller build** of the earlier renders. Less literal to the reference, preferred on screen.
- **v10** — **pulled back further** on request. Framing is now specified as proportions of the frame rather than adjectives: "wider" is not actionable, "Ug occupies about a third of the frame height" is. The face-legibility clause was fighting the pull-back and has been dropped.
- **v9** — **club now pinned as a DRAG.** Renders had him ploughing it forward like a snowplough. Same failure class as the scooter: "behind him" is ambiguous unless the model already knows which way he faces. Fixed with the same four-anchor treatment plus a clean-ground negative.
- **v9** — **beard corrected to stubble.** This was an error in the prompt, not the model: the character block said "full grey beard and moustache" when the approved reference is close-cropped grey stubble with skin showing through. The model rendered what it was asked for.
- **v8** — **wider frame, staged in depth.** Ug starts near camera at the far left, the scooter sits smaller and further up the track, with a long visible run of dirt between them. Pulling back flat would shrink Pete's face, which is the whole point of this version, so the distance is bought with perspective instead of zoom.
- **v8** — **camera locked off.** The whole gag plays inside one static wide frame. Camera moves are where AI video loses object permanence: whatever leaves frame can come back deformed. Keeping Ug and the scooter both visible throughout gives the model continuous reference and lets the six beats actually chain.
- **v8** — beats **explicitly numbered** in the film prompt, so the sequence is an ordered list rather than a paragraph a model can reorder.
- **v7** — **orientation rewritten.** The first render put the scooter facing Ug despite a capitalised instruction. Single left/right statements are unreliable in image models, so the direction is now pinned by four redundant anchors: which end is nearest Ug, which named parts sit at which end, which flank we view, and two explicit negatives.
- **v6** — paddies are **lush green growing rice, not flooded mirror water**. Aesthetics aside, the deciding factor is technical: rippling water and reflections are where AI video artefacts live, and that render budget is better spent on Ug than on background nobody is watching.
- **v6** — scooter **locked black** with chrome and pale detail. It keeps the machine mundane, which is what the wheelie and the V8 play against, and a dark silhouette separates cleanly from mid-green.
- **v5** — one or two farmers now **glance up as Ug tears past**, tracked by the swing of their conical hat brims. Deliberately written as fleeting and background-scale: at this length a staged reaction would eat the gag rather than add to it.
- **v5** — the scooter now sounds like a **thunderous V8**, not a scooter. Same joke as the wheelie, in the audio track.
- **v4** — the **vaulting mount and the wheelie exit are both restored**, and deliberately played as absurd rather than corrected for realism. A commuter scooter is the funnier machine to do these on, not the reason to drop them.

---

## Prompt A — establishing keyframe (image)

References: **1)** approved Ug caricature (character + art style) · **2)** black scooter photo (machine)
· **3)** rice-paddy photos (setting, hats, working postures)

> Cartoon illustration in EXACTLY the art style of the first reference: bold varied-weight ink
> outlines, flat cel shading with cross-hatch texture accents, saturated comic-book palette.
>
> **DIRECTION OF TRAVEL — THE MOST IMPORTANT FACT IN THIS IMAGE.** Ug is walking RIGHTWARD, TOWARD
> the scooter, closing the distance to it. His head, face, chest, knees and toes ALL point RIGHT.
> The scooter is AHEAD of him, up the track. **He is NOT walking away from it. He is NOT facing
> left. His back is NOT turned to the scooter.** Everything else follows from this.
>
> **CHARACTER — Ug.** The bald caveman from the first reference: completely
> bald sun-tanned dome, heavy dark bushy eyebrows, deep-set eyes,
> weathered creased face. **BUILD: tall and rangy, long legs, upright stance — a big man, not a
> small one. NOT squat, NOT dwarfish, NOT short-legged, NOT a large head on a little body.**
> **His beard is CLOSE-CROPPED GREY STUBBLE
> — short silver-grey stubble hugging the jawline, chin and upper lip with skin showing through it,
> exactly as in the reference. NOT a long, full or bushy beard.** Yellow-orange leopard-spotted fur
> tunic over one shoulder, bare hairy arms and legs, big bare feet. He hauls an enormous knobbly
> dark-brown wooden club.
>
> **THE CLUB — defined relative to his travel, not to the frame.** He grips the club's thin handle
> end low beside his hip, and its heavy knobbly head TRAILS ALONG THE GROUND BEHIND HIM — behind
> meaning *on the side away from the scooter*, back down the stretch of track he has already
> covered. It gouges a furrow and kicks up dust in his wake. He is not pushing it, not swinging it,
> not carrying it ahead of himself. **The ground between him and the scooter is clean, undisturbed
> dirt — no furrow, no dust, nothing dragged across it.**
>
> **COMPOSITION — EXTREME WIDE, staged in depth.** A very wide cinematic side-on establishing
> shot, 16:9, camera a long way back. Two small figures in a big landscape.
> **Ug's whole standing body occupies only about ONE THIRD of the frame height.** He is at the FAR
> LEFT, nearest to camera, full body, mid-stride, walking toward the RIGHT along the track.
> **The scooter sits far up the track to the RIGHT**, small in frame through perspective.
> **A very large expanse of empty dirt track separates them — roughly a third of the frame's
> width** — the ground he still has to cover.
> Generous open sky across the upper third, and the paddies and karsts spread wide around them.
> Both Ug and the scooter are fully inside the frame with a lot of air around them; nothing is
> cropped at the edges.
>
> **THE MACHINE — a modern Asian scooter, NOT a dirt bike and NOT a trail bike.** In the RIGHT
> third of frame, drawn from the second reference photo: a glossy black step-through maxi-scooter
> (Honda PCX type) — **glossy black bodywork**, tall clear windscreen, twin chrome-stalk mirrors,
> long black bench seat with a pale grey top, smooth flowing panels, silver alloy wheels with a
> front disc brake, a chrome exhaust, side stand down. Keep bright chrome and pale highlights on it
> so the dark silhouette still reads as a machine and not a flat black blob.
> **CRITICAL — WHICH WAY THE SCOOTER POINTS.** It is parked pointing AWAY from Ug, aimed up the
> track toward the RIGHT of frame: the same direction Ug is walking, and the direction he will
> ride off in. Pinned four ways, all of which must hold:
> **(1)** Its REAR END is the end NEAREST Ug. **(2)** The red tail-light, rear number plate and rear
> wheel are therefore on the LEFT-hand side of the scooter as we see it, while the front wheel,
> forks, headlight, tall windscreen and handlebars are on the RIGHT-hand side as we see it.
> **(3)** We are looking at the scooter's LEFT-HAND FLANK. **(4)** If Ug sat on it now he would be
> facing RIGHT, ready to ride away to the right.
> **DO NOT draw the scooter facing Ug. DO NOT put the windscreen, headlight or handlebars on the
> left-hand side.** Perfectly ordinary, modern, and completely out of place here.
>
> **SETTING — rural Vietnam.** Ug walks along a dry ochre dirt track on a raised earth bund.
> Immediately behind him, filling the middle of the frame, are **lush green rice paddies in full
> growth** — dense, vivid green rice standing knee-high in neat rows, low earth bunds dividing the
> fields. Solid green fields, NOT flooded mirror-water; little or no standing water visible. Working those paddies are **Vietnamese farmers in conical straw nón lá hats** — simple
> work shirts and rolled trousers, several bent double planting seedlings, one straightened up with
> a bundle of rice under one arm, one further off carrying a bucket along a bund. Beyond the fields,
> hazy grey-green **limestone karst peaks** rise out of the mist, with a few coconut palms and a
> distant tin-roofed farm building. Warm, humid, bright daylight; soft teal-to-cream sky.
>
> Full-bleed illustration. No text, no captions, no watermark.

---

## Prompt B — the 3-second film (video)

Start image: the keyframe above.

> Continuous single side-on tracking shot. 2D cartoon animation holding the EXACT art style,
> colours and character design of the starting frame — Ug's face and likeness stay identical
> throughout, and the scooter stays the same glossy black step-through scooter facing screen right.
>
> **THE CAMERA IS LOCKED OFF.** One static wide shot. Do not cut, do not zoom, do not track. Ug and
> the scooter both stay inside the frame the entire time; the action travels left to right across
> the shot rather than the camera following it. Only at the very end may the frame drift slightly
> right as he goes.
>
> **The beats, in this exact order:**
> **1.** Ug trudges from the far left toward the scooter, the club's heavy head DRAGGING along the
> ground behind him to the left, gouging a furrow and kicking up dust in his wake.
> **2.** He stops dead and jolts upright, eyes wide — he has spotted it.
> **3.** He flings the club away behind him to the LEFT; it spins off out of frame.
> **4.** He charges the last stretch of track and **VAULTS clean over the scooter in one bound,
> landing astride the seat**.
> **5.** The scooter's **front wheel snaps up into an improbable wheelie**.
> **6.** He tears away to the RIGHT in a billowing cloud of ochre dust and exits the frame.
>
> Play the vault and the wheelie big and cartoonish — this tiny commuter scooter absolutely should
> not be able to do either, and that is the joke.
>
> **SOUND: the scooter must roar like a huge American V8 muscle car** — a deep, thunderous,
> guttural big-block bellow, throttle blipping and then howling flat out as he tears away.
> Absolutely NOT a scooter sound: no small-engine buzz, no moped whine, no 125cc rasp. The engine
> note should be comically, impossibly oversized for the machine making it.
>
> Behind him the rice paddies and the farmers in conical hats work on throughout — bending,
> planting, the green rice swaying. As Ug tears past, **one or two of the nearest farmers straighten up
> and turn to follow him**, the wide brims of their conical hats swinging round to track him.
> Keep this fleeting — a brief background glance caught in passing, never a staged reaction, never
> a pause in their work. They stay small and soft in the depth of field, the camera never cuts to
> them, and Ug remains the focus of the shot throughout.
>
> Camera pans right to follow him. Hand-drawn cartoon animation, bold ink outlines, flat cel
> shading. No text, no captions, no subtitles, no watermark.

---

## Open items
None blocking. Everything above is locked; the next real information comes from generating a
keyframe and looking at it, not from more discussion.

---

## Character lock (added after the v11 renders)

Facial likeness kept drifting shot to shot. Root cause: the only reference was a
three-quarter *front* view, while every shot in the film is a side profile — so the
model was inventing his profile from scratch every single generation.

Fix, in order:

1. **Real photo references.** Four photos of Peter — front neutral, side profile,
   three-quarter, smiling — uploaded as `image_references`, with the approved
   caricature supplying only the drawing style. Likeness from photographs, style
   from the cartoon.
2. **Named identity features** instead of generic description. What makes him
   recognisable: very heavy low-set grey brows, deep horizontal forehead creases,
   bald tanned crown with cropped silver at the temples, deep-set hooded eyes,
   broad fleshy nose with a bump on the bridge, wide mouth with a slight downturn,
   heavy jaw and jowls, thick creased neck, ruddy weathered skin. Grey stubble, never
   a beard.
3. **Sheets, not single frames.** A full-body turnaround (front / three-quarter /
   profile / back) and a six-portrait head-and-expression sheet, including the shock
   and the whoop the film needs.
4. **Reference Element next.** Register the approved sheet as a Higgsfield
   Reference Element and address it from the prompt, so identity is carried by the
   asset rather than by prose.

### Why an Element and not a Soul

| Method | Usable by | Verdict |
|---|---|---|
| Sheet as image reference | any model | works, but re-described every time |
| **Reference Element** | Nano Banana Pro **and Kling 3.0** | **correct for this pipeline** |
| Soul (trained identity) | `soul_2` / `soul_cinematic` only | cannot be used by our video model |

Soul is the intuitive answer and the wrong one here: Kling 3.0 renders the film and
cannot consume a Soul, so identity would lock for stills and break the moment it moved.
Elements span both models we actually use.
