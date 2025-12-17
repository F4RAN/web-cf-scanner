# web-cf-scanner

**Scan Cloudflare IPs directly in the browser.**  
A small Vue-based web app that helps you test Cloudflare IP candidates from your browser and keep a shortlist of the ones that respond best.

Live demo: https://f4ran.github.io/web-cf-scanner/
---

## What it does

Because browsers cannot perform raw ICMP ping, this project focuses on **HTTP(S)-level testing** (request timing / basic reachability) to quickly compare IP candidates from a simple UI. Use it to:

- Try many Cloudflare IPs without installing native tools
- Compare responsiveness in your current network environment
- Copy/export the best candidates for further testing or configuration

---

## Tech Stack

- Vue (Vue CLI project)
- Static deployment via GitHub Pages

---

## Getting Started

### Prerequisites
- Node.js (LTS recommended)
- npm (or yarn/pnpm if you prefer)

### Install
```bash
npm install
```

### Run locally (development)
```bash
npm run serve
```

### Build (production)
```bash
npm run build
```

### Lint
```bash
npm run lint
```

---

## Deployment (GitHub Pages)

This repository includes a `deploy.sh` script (see repo root) citeturn3view0.  
A typical workflow is:

```bash
bash deploy.sh
```

(If you change the deployment strategy, ensure the app is built with the correct public/base path for GitHub Pages.)

---

## Contributing

Issues and pull requests are welcome. If you add features, please keep the UI lightweight and keep scans non-blocking (avoid freezing the main thread).

---

## License

MIT citeturn3view0
