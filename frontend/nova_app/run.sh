#!/bin/bash
# ─────────────────────────────────────────
#  Nova Voice Assistant — Dev Runner
#  Starts Flutter Web on http://localhost:5000
# ─────────────────────────────────────────

echo ""
echo "  ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ "
echo "  ████╗  ██║██╔═══██╗██║   ██║██╔══██╗"
echo "  ██╔██╗ ██║██║   ██║██║   ██║███████║"
echo "  ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║"
echo "  ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║"
echo "  ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝"
echo ""
echo "  Voice Assistant — Flutter Web"
echo "  ─────────────────────────────"
echo "  🌐 Frontend : http://localhost:5000"
echo "  ⚡ Backend  : http://localhost:8000"
echo ""

# Install dependencies
flutter pub get

# Run on port 5000
flutter run -d chrome \
  --web-port 5000 \
  --web-hostname localhost
