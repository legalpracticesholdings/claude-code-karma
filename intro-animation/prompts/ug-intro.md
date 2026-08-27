# Ug Intro — living prompt

**Version:** v13 (proven constraints restored, prompt is numbered so nothing gets cut again)

## Locked context
- Character is **Ug**: Pete as a bald caveman. Locked to the approved caricature.
- The series is Pete's **Asia travel vlog**. Multiple versions eventually; **v1 rides the Asian scooter**.
- 3 seconds, 16:9, cold open, cuts on action.

## Changelog
- **v13** — **the doc is now the prompt.** Prompt A is sent verbatim, numbered section by section.
  Every regression so far — the beard, the pushed club, the giant, and twice the scooter facing the
  wrong way — came from re-typing a shortened prompt into the API call and dropping a clause that
  was already working. Fixing the newest bug kept knocking out an older fix. Numbered sections make
  an omission visible.
- **v13** — **four-anchor scooter orientation restored.** v12 compressed it to a single sentence
  and the scooter immediately turned to face Ug again, exactly as it did before v7. Single left/right
  statements are unreliable in image models; the four redundant anchors are not, so they stay.
- **v13** — **scale pinned to the farmers, not the frame.** v10 specified Ug as a fraction of frame
  height and the model satisfied it by shrinking the landscape, making him a giant. Relative measures
  survive a change of framing; absolute ones fight it.
- **v13** — **pulled back further again**, and framing now states the whole scene must fit with
  margin on all four sides rather than giving a target size for Ug.
- **v2** — trail bike replaced with a black Asian maxi-scooter (Honda PCX type).
- **v2** — scooter turned to face **screen right**, same direction Ug walks, so he rides off the way he was already heading.
- **v3** — the near background is now **Vietnamese rice paddies with farmers in conical nón lá hats**, bent over planting in flooded, mirror-flat fields.
- **v3** — *(assumed, say the word and it reverts)* the **volcano is replaced by limestone karst peaks**. Every rice-field reference shows karsts, and they are the Vietnam signature; a volcano next to a paddy reads prehistoric, which now fights the joke instead of feeding it.
- **v12** — **character block rewritten to match the approved cartoon.** Ug is now clean-shaven with a tall domed bald skull and level brows. The old block still described the grey stubble beard, the short round head and a faintly disapproving expression, all three of which were rejected. Once the Reference Element is registered this block becomes a fallback: the Element carries the likeness and the prose only backs it up.
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

References: the **Ug Reference Element** (character + likeness, embedded in the prompt as
`<<<38d4ef6c-967f-436a-8377-ec9ba862faf2>>>`) · the **black scooter photo** (machine)

> Cartoon illustration: bold varied-weight ink outlines, flat cel shading, saturated comic-book
> palette. Full-bleed, 16:9.
>
> **1. DIRECTION OF TRAVEL — THE MOST IMPORTANT FACT IN THIS IMAGE.** Ug walks RIGHTWARD, TOWARD
> the scooter, closing the distance. Head, face, chest, knees and toes ALL point RIGHT. The scooter
> is AHEAD of him, up the track. **He is NOT walking away from it. He is NOT facing left. His back
> is NOT turned to it.** Everything else follows from this.
>
> **2. CHARACTER — Ug: <<<38d4ef6c-967f-436a-8377-ec9ba862faf2>>>**, exactly as in the element.
> Completely bald, tall narrow domed skull, clean-shaven, level horizontal brows, easy-going and
> good-humoured. Leopard-spotted fur tunic over one shoulder, bare arms and legs, bare feet. He
> hauls an enormous smooth knobbly wooden club — rounded burls, no spikes.
>
> **3. HIS SIZE — judged against the farmers, never against the frame.** Stand Ug beside the
> farmers in the paddies and he is the SAME HEIGHT as them, just heavier built. **He is NOT a
> giant, NOT towering, NOT larger than the landscape.** An ordinary big man in an ordinary field.
>
> **4. THE CLUB — defined relative to his travel, not to the frame.** He grips the thin handle end
> low beside his hip; the heavy knobbly head TRAILS ALONG THE GROUND BEHIND HIM — behind meaning
> *on the side away from the scooter*, back down the track he has already covered — gouging a
> furrow and kicking up dust in his wake. Not pushing it, not swinging it, not carrying it ahead.
> **The ground between him and the scooter is clean undisturbed dirt: no furrow, no dust.**
>
> **5. THE MACHINE — a modern Asian scooter, NOT a dirt bike, NOT a trail bike.** Glossy black
> step-through maxi-scooter (Honda PCX type): tall clear windscreen, twin chrome-stalk mirrors,
> long bench seat with a pale grey top, silver alloy wheels, front disc brake, chrome exhaust, side
> stand down. Keep bright chrome and pale highlights so it reads as a machine, not a black blob.
>
> **6. WHICH WAY THE SCOOTER POINTS — pinned four ways, ALL of which must hold.** It is parked
> pointing AWAY from Ug, aimed up the track toward the RIGHT of frame: the same direction Ug walks
> and the direction he will ride off in.
> **(1)** Its REAR END is the end NEAREST Ug.
> **(2)** The red tail-light, rear number plate and rear wheel are therefore on the LEFT-hand side
> of the scooter as we see it, while the front wheel, forks, headlight, tall windscreen and
> handlebars are on the RIGHT-hand side as we see it.
> **(3)** We are looking at the scooter's LEFT-HAND FLANK.
> **(4)** If Ug sat on it now he would be facing RIGHT, ready to ride away to the right.
> **DO NOT draw the scooter facing Ug. DO NOT put the windscreen, headlight or handlebars on the
> left-hand side.**
>
> **7. COMPOSITION — EXTREME WIDE. THE WHOLE SCENE MUST FIT.** Camera a very long way back, locked
> off, side-on. Two small figures in a big landscape. Ug is at the FAR LEFT, full body, mid-stride;
> the scooter is far up the track to the RIGHT, small through perspective; a very large expanse of
> empty dirt track separates them. Generous open sky across the upper third and wide margins on all
> four sides — sky above, foreground track below, landscape running out past both figures. **Nothing
> is cropped at any edge and nothing crowds the frame. If in doubt, pull back further.**
>
> **8. SETTING — rural Vietnam.** A dry ochre dirt track on a raised earth bund. Behind it, filling
> the middle of the frame, **lush green rice paddies in full growth** — dense vivid green rice
> knee-high in neat rows, low earth bunds dividing the fields, little or no standing water. Working
> them are **Vietnamese farmers in conical straw nón lá hats**, several bent double planting, one
> straightened with a bundle of rice, one carrying a bucket along a bund. Beyond, hazy grey-green
> **limestone karst peaks** in the mist, a few coconut palms, a distant tin-roofed farm building.
> Warm humid bright daylight, soft teal-to-cream sky.
>
> No text, no captions, no watermark.

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
4. **Reference Element — DONE.** Ug is registered as a Higgsfield Reference Element
   and addressed from the prompt with `<<<element_id>>>`, so identity is carried by the
   asset rather than by prose.

### The Ug Element

| | |
|---|---|
| Name | `Ug` |
| Element id | `38d4ef6c-967f-436a-8377-ec9ba862faf2` |
| Source image | image_job `33becc69-e3df-4b69-b33a-e2eac3be77e7` |

Usage: embed `<<<38d4ef6c-967f-436a-8377-ec9ba862faf2>>>` inside the prompt of
`generate_image` or `generate_video`. Works with Nano Banana Pro and Kling 3.0.

The source is a cartoonisation of a **photograph of Peter actually wearing the
costume and holding a club**. That photo is what finally settled the likeness after
roughly twenty renders of describing his face in prose. The lesson is worth keeping:
when likeness matters, get real reference rather than better adjectives.

### Why an Element and not a Soul

| Method | Usable by | Verdict |
|---|---|---|
| Sheet as image reference | any model | works, but re-described every time |
| **Reference Element** | Nano Banana Pro **and Kling 3.0** | **correct for this pipeline** |
| Soul (trained identity) | `soul_2` / `soul_cinematic` only | cannot be used by our video model |

Soul is the intuitive answer and the wrong one here: Kling 3.0 renders the film and
cannot consume a Soul, so identity would lock for stills and break the moment it moved.
Elements span both models we actually use.
