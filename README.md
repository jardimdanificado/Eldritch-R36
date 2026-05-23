# Eldritch R36S

### 1. Build the Docker Image
```bash
make docker-image
```

### 2. Compile the Game
```bash
make build
```
This command will mount your local directory into the Docker container, run CMake, and cross-compile the binary to `build-r36s/Projects/Eld/Eld`.

### 3. Package the Release
```bash
make package
```
This compiles the code and automatically copies the binary and the launch scripts into a `release/` folder.

## Installation on the R36S

1. Run `make package`.
2. Grab your original Eldritch game data files (the `.cpk` files and the audio folders).
3. Place the game data files inside `release/eldritch/eldritch/Data/` (or whatever structure your assets require).
4. Copy the entire contents of `release/` (the `eldritch` folder and the `Eldritch.sh` script) into the `/roms/ports/` partition of your R36S SD Card.
5. Launch the game from the Ports menu!

## Controls & Save Data

- Save files and configurations (`prefs.cfg`, `userdata`) are properly isolated to the port's installation directory thanks to `PORTMASTER_HOME` integration.
- The game automatically forces a `640x480` rendering resolution to match the physical screen of the R36S.

