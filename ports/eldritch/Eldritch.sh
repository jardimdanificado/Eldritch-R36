#!/bin/bash
# Eldritch.sh — PortMaster launch script
# Place this file in: /roms/ports/Eldritch.sh

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
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Video config
# let sdl decide the video driver
unset SDL_VIDEODRIVER

# uncomment this just in case sdl cant find the driver
# export SDL_VIDEODRIVER=kmsdrm

# Audio config
export SDL_AUDIODRIVER="${SDL_AUDIODRIVER:-alsa}"

# Library path
export LD_LIBRARY_PATH="$GAMEDIR/lib:$LD_LIBRARY_PATH"

# Create prefs.cfg
mkdir -p "$GAMEDIR/userdata"
PREFS="$GAMEDIR/userdata/prefs.cfg"
if [ ! -f "$PREFS" ]; then
    cat > "$PREFS" << 'EOF'
Fullscreen = true
VSync = false
FXAA = false
UpscaleFullscreen = false
EOF
    echo "[Eldritch] Created default prefs.cfg"
fi

# Launch the game
printf "[Eldritch] Starting...\n"

$GPTOKEYB "Eld" -c "$GAMEDIR/eldritch.gptk" &
./Eld

# Cleanup
printf "[Eldritch] Exited.\n"
pm_finish