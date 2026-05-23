# Eldritch — R36S PortMaster Port

**Eldritch** is a Lovecraftian first-person roguelike by Minor Key Games (David Pittman).

> ⚠️ **This port requires game files from a purchased copy of Eldritch.**
> The engine is open source (zlib license); the game content is not included.

---

## Installation

### 1. Copy the port folder

Copy the entire `eldritch/` folder to your SD card:

```
/roms/ports/
├── Eldritch.sh
└── eldritch/
    ├── Eld              ← compiled binary (aarch64)
    └── ...
```

### 2. Add game data files

Purchase Eldritch from [Steam](https://store.steampowered.com/app/252900/Eldritch/) or [GOG](https://www.gog.com/game/eldritch).

Copy the following `.cpk` files from your Eldritch installation into `/roms/ports/eldritch/eldritch/`:

| File | Required? |
|---|---|
| `eldritch-base.cpk` | ✅ Yes |
| `eldritch-audio.cpk` | ✅ Yes |
| `eldritch-textures.cpk` | ✅ Yes |
| `eldritch-meshes.cpk` | ✅ Yes |
| `eldritch-world.cpk` | ✅ Yes |

**Steam location (Linux):**
```
~/.steam/steam/steamapps/common/Eldritch/
```

**Steam location (Windows):**
```
C:\Program Files (x86)\Steam\steamapps\common\Eldritch\
```

### 3. Launch

Eldritch will appear in PortMaster (or directly in the Ports section of your frontend).

---

## Controls (R36S)

| Action | Button |
|---|---|
| Move | Left Stick / D-Pad |
| Look | Right Stick |
| Attack / Use | A |
| Jump | B |
| Crouch | R1 |
| Interact (Frob) | X |
| Inventory | Y |
| Pause / Menu | Start |
| Sprint | L1 |

---

## Save Data

Saves are stored in `/roms/ports/eldritch/userdata/`.

---

## Known Issues

- Resolution is fixed at 640×480 (R36S native screen)
- Target frame rate is 30fps (Cortex-A35 @ 1.5GHz)
- Mouse cursor is not visible (controller-only mode)

---

## Credits

- **Eldritch** by [Minor Key Games](https://eldritchgame.com/) — released under zlib license
- **OpenPandora port** by [ptitSeb](https://github.com/ptitSeb/Eldritch) (GLES2 + OpenAL)
- **R36S adaptation**: community port
