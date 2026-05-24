#!/bin/bash
# Eldritch.sh — PortMaster launch script for R36S (ArkOS)
# Place this file in: /roms/ports/Eldritch.sh

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# PortMaster standard environment
if [ -d "/opt/system/Tools/PortMaster/" ]; then
    controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
    controlfolder="/opt/tools/PortMaster"
elif [ -d "$HOME/PortMaster/" ]; then
    controlfolder="$HOME/PortMaster"
else
    controlfolder="/roms/ports/PortMaster"
fi

source "$controlfolder/control.txt"
get_controls

GAMEDIR="$(dirname "$(readlink -f "$0")")/eldritch"
export PORTMASTER_HOME="$(dirname "$(readlink -f "$0")")"

cd "$GAMEDIR"
> "$GAMEDIR/log.txt" 2>&1

# ---------------------------------------------------------------------------
# R36S/ArkOS video config
# ArkOS uses KMS/DRM — NOT "mali" (that was OpenPandora only)
# Leave SDL_VIDEODRIVER unset so SDL2 auto-detects (usually kmsdrm or fbdev).
# Uncomment only if SDL fails to detect:
# export SDL_VIDEODRIVER=kmsdrm
# ---------------------------------------------------------------------------
unset SDL_VIDEODRIVER

# Audio config
export SDL_AUDIODRIVER="${SDL_AUDIODRIVER:-alsa}"

# Library path
export LD_LIBRARY_PATH="$GAMEDIR/lib:$LD_LIBRARY_PATH"

# ---------------------------------------------------------------------------
# Pre-create prefs.cfg so the game starts at the correct resolution (640x480)
# without needing a first-run resolution change cycle.
# Format from ConfigManager::Write(): "Key = Value\n"
# This file is loaded from GetUserDataPath() = $PORTMASTER_HOME/eldritch/userdata/
# ---------------------------------------------------------------------------
mkdir -p "$GAMEDIR/userdata"
PREFS="$GAMEDIR/userdata/prefs.cfg"
if [ ! -f "$PREFS" ]; then
    cat > "$PREFS" << 'EOF'
Fullscreen = true
VSync = false
FXAA = false
UpscaleFullscreen = false
EOF
    echo "[Eldritch] Created default prefs.cfg" >> "$GAMEDIR/log.txt"
fi

# ---------------------------------------------------------------------------
# Controller support
# ---------------------------------------------------------------------------
$ESUDO kill -9 $(pidof gptokeyb) 2>/dev/null || true

# Launch the game
printf "[Eldritch] Starting...\n" >> "$GAMEDIR/log.txt"

# $GPTOKEYB "Eld" -c "$GAMEDIR/eldritch.gptk" &
./Eld >> "$GAMEDIR/log.txt" 2>&1

# Cleanup
# $ESUDO kill -9 $(pidof gptokeyb) 2>/dev/null || true
$ESUDO systemctl restart oga_events 2>/dev/null || true

printf "[Eldritch] Exited.\n" >> "$GAMEDIR/log.txt"
