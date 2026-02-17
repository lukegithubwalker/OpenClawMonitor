# ClawScope Dashboard

ClawScope is a Flutter Web monitoring dashboard for the OpenClaw AI assistant. It includes Three.js 3D visualizations, real-time WebSocket updates, historical charts, alerting, and a remote control panel.

## Quick Start

```bash
flutter pub get
flutter run -d chrome
```

## Build

```bash
flutter build web
```

## Environment Configuration

Copy `.env.example` to `.env` and set the values, then run the build helper:

```bash
./tool/build_with_env.sh
```

## Backend

- Cloudflare Workers backend in `clawscope-backend/`
- VPS agent in `clawscope-agent/`

## Recommended Hosting

- Flutter Web: Vercel or Cloudflare Pages
- Backend: Cloudflare Workers
- VPS Agent: Hostinger VPS with Caddy reverse proxy
