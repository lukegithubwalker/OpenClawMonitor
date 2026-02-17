#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "Missing .env file. Copy .env.example to .env and fill values."
  exit 1
fi

set -a
source .env
set +a

flutter build web \
  --dart-define=API_BASE_URL="$API_BASE_URL" \
  --dart-define=WS_URL="$WS_URL" \
  --dart-define=API_KEY="$API_KEY"