# Not Lost. Building. — your founder daily driver

A single, self-contained web app that pushes you to show up every day and build
your own thing: a countdown to your target, a morning-intent / evening-reflection
ritual, a "don't break the chain" day streak, an 8-stage roadmap (clarity → first
dollar), a shipped log, identity reminders, and a state-aware coach.

Everything runs in the browser. Your data (streaks, reflections, goals) never
leaves your device — it lives in that browser's local storage.

## Folder contents

```
index.html            The app (open this / deploy this)
manifest.webmanifest  Makes it installable as a phone app (PWA)
sw.js                 Service worker — makes it work offline once installed
icon.svg / icon-*.png App icons
mac-notifications/     OPTIONAL Mac-only nudges (ignore if you're on Android)
README.md             This file
```

---

## ▶ Put it on your Android phone (the main way to use it)

A local file won't install properly. You need it behind an HTTPS URL once — then
Chrome turns it into a real installable app. Two free ways:

### Option A — Netlify Drop (easiest, no command line)
1. On this Mac, go to **https://app.netlify.com/drop** in a browser.
2. Drag the whole **FounderDashboard** folder onto that page.
3. You instantly get a live URL like `https://random-name.netlify.app`.
4. (Optional) Sign up free to *keep* it permanent and rename the URL. If you skip
   signup the site is temporary — for a daily driver, sign up so it stays.
5. On your **Android phone**, open that URL in **Chrome**.
6. Chrome shows an **Install** banner (or menu ⋮ → **Install app / Add to Home
   screen**). Tap it. Now it's an app icon on your home screen, works offline.

### Option B — GitHub Pages (if you prefer git)
1. Create a new repo, put these files at the root, push.
2. Repo **Settings → Pages → Deploy from branch → main / root**.
3. Open the `github.io` URL on your phone → Install app.

Once installed, open it from the home-screen icon — not the browser tab — so it
runs full-screen like a native app.

---

## Notifications on Android (so it actually pushes you)

True scheduled web-push needs a small backend server (there's no reliable way for
a web app to schedule notifications by itself). Two paths:

**Now — zero setup (recommended to start):**
Use your phone's own tools to fire the nudge at set times:
- **Google Calendar:** create a recurring daily event at ~9am ("Founder: today's
  one thing") and ~8pm ("Founder: log today"). Paste your app URL in the event so
  the notification is one tap from opening it.
- or **Clock app alarms / any reminder app** with the same labels.

This is low-tech but reliable and pushes you every day with no infrastructure.

**Later — real web push (a good first thing to actually ship):**
You're a backend engineer — a tiny push service is well within reach and would be
a real, finishable side project:
- Generate VAPID keys, add a `push` handler to `sw.js`, subscribe the client.
- A small serverless cron (e.g. Cloudflare Workers / a free scheduler) sends the
  push morning & evening.
Tell me when you want this and I'll build it with you.

---

## Your data: backup, restore, move between phones

- In the app: **Settings & backup → Export backup** saves a `.json` file. Do this
  every so often — a browser cache-clear wipes local data.
- **Import backup** restores it, or moves your history to a new phone.
- Data does **not** sync automatically between devices (by design — each device is
  independent). Use export/import to move it.
- If you'd already entered data in the old `~/Desktop/founder-dashboard.html`,
  open it, Export, then Import into the deployed version. After that you can delete
  the Desktop file.

---

## Optional: Mac notifications (skip if you're on Android)

If you ever want desktop nudges on this Mac:
```
cd ~/FounderDashboard/mac-notifications
./install.sh          # 9am + 8pm; or ./install.sh 8 21 for custom times
./uninstall.sh        # turn them off
```
These are separate from the phone and only affect this Mac.

---

## Editing & privacy

- It's one plain `index.html`. Open it in any editor to change the coach messages,
  quotes, roadmap stages, daily "moves", or identity reminders — they're plain
  arrays near the top of the `<script>`.
- Heads up: your personal identity reminders and default "why" text are written
  into `index.html`. If you deploy to a **public** URL, that text is technically
  viewable by anyone with the link (your streaks/notes are NOT — those stay on your
  device). If you'd rather keep the personal lines private, tell me and I'll move
  them to first-run inputs so nothing personal is baked into the shipped file.
