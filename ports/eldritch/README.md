# Eldritch — R36S Port

**Eldritch** is a Lovecraftian first-person roguelike by Minor Key Games.

> **This port requires game files from a purchased copy of Eldritch.**
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

Purchase Eldritch from [Steam](https://store.steampowered.com/app/252630/Eldritch/).

Copy all the `.cpk` files from your Eldritch installation into `/roms/ports/eldritch/`.

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

## Save Data

Saves are stored in `/roms/ports/eldritch/userdata/`.

---

## Known Issues

---

## Credits

- **Eldritch** by [Minor Key Games](https://eldritchgame.com/) — released under zlib license
- **OpenPandora port** by [ptitSeb](https://github.com/ptitSeb/Eldritch) (GLES2 + OpenAL)
