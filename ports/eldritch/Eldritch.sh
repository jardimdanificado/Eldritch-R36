#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

GAMEDIR="/$directory/ports/eldritch"

cd "$GAMEDIR"

> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

# Create prefs.cfg if it does not yet exist
[ ! -d "$GAMEDIR/userdata" ] && mkdir -p "$GAMEDIR/userdata"
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

$GPTOKEYB "Eld" -c "$GAMEDIR/eldritch.gptk" &
pm_platform_helper "$GAMEDIR/Eld"
./Eld

pm_finish