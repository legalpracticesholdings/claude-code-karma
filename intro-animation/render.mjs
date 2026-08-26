/**
 * Renders caveman-intro.html to a frame-exact master.
 *
 *   node render.mjs [--out dist] [--scale 1] [--contact]
 *
 * Frames are pulled one at a time via window.__renderAt(t), so the output is
 * deterministic: no wall-clock timing, no dropped frames.
 */
import { chromium } from "playwright";
import { execFileSync } from "node:child_process";
import { mkdirSync, writeFileSync, rmSync } from "node:fs";
import { dirname, resolve, join } from "node:path";
import { fileURLToPath } from "node:url";
import ffmpegStatic from "ffmpeg-static";

const HERE = dirname(fileURLToPath(import.meta.url));
const argv = process.argv.slice(2);
const arg = (k, d) => { const i = argv.indexOf(k); return i === -1 ? d : argv[i + 1]; };

const OUT = resolve(HERE, arg("--out", "renders"));
const FRAMES = join(OUT, "frames");
const CONTACT = argv.includes("--contact");
const FFMPEG = process.env.FFMPEG || ffmpegStatic || "ffmpeg";
const PAGE = "file://" + join(HERE, "caveman-intro.html");

rmSync(FRAMES, { recursive: true, force: true });
mkdirSync(FRAMES, { recursive: true });

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 900 } });

const problems = [];
page.on("pageerror", (e) => problems.push("pageerror: " + e.message));
page.on("console", (m) => { if (m.type() === "error") problems.push("console: " + m.text()); });

await page.goto(PAGE, { waitUntil: "load" });
await page.waitForFunction(() => typeof window.__renderAt === "function");

const film = await page.evaluate(() => window.__FILM);
const total = Math.round(film.FPS * film.DUR);
console.log(`rendering ${total} frames @ ${film.W}x${film.H} ${film.FPS}fps`);

for (let i = 0; i < total; i++) {
  const t = i / film.FPS;
  const data = await page.evaluate((t) => {
    window.__renderAt(t);
    return document.getElementById("film").toDataURL("image/png");
  }, t);
  writeFileSync(join(FRAMES, `f${String(i).padStart(4, "0")}.png`),
    Buffer.from(data.slice(data.indexOf(",") + 1), "base64"));
  if (i % 15 === 0) process.stdout.write(`  ${i}/${total}\n`);
}
await browser.close();

if (problems.length) {
  console.error("\nPage reported problems:");
  for (const p of new Set(problems)) console.error("  " + p);
}

const ff = (args) => execFileSync(FFMPEG, ["-y", "-hide_banner", "-loglevel", "error", ...args], { stdio: "inherit" });
const seq = join(FRAMES, "f%04d.png");
const R = ["-framerate", String(film.FPS), "-i", seq];

console.log("encoding master.mp4");
ff([...R, "-c:v", "libx264", "-preset", "slow", "-crf", "16",
    "-pix_fmt", "yuv420p", "-movflags", "+faststart", join(OUT, "caveman-intro.mp4")]);

console.log("encoding caveman-intro.webm");
ff([...R, "-c:v", "libvpx-vp9", "-crf", "28", "-b:v", "0", "-pix_fmt", "yuv420p",
    join(OUT, "caveman-intro.webm")]);

console.log("encoding caveman-intro.gif");
ff([...R, "-vf", "fps=25,scale=800:-1:flags=lanczos,split[a][b];[a]palettegen=stats_mode=diff[p];[b][p]paletteuse=dither=bayer:bayer_scale=3",
    join(OUT, "caveman-intro.gif")]);

if (CONTACT) {
  console.log("building contact sheet");
  ff(["-i", seq, "-vf", "select='not(mod(n\\,5))',scale=480:-1,tile=6x3", "-frames:v", "1",
      join(OUT, "contact-sheet.png")]);
}
console.log("done ->", OUT);
