# Godot Template

Custom template for godot games for godot 4

use branch `godot-3.x` for godot 3, but it might not be up-to-date with the latest features

## Setup

After creating the repository with this template do the following:

- Run `scripts/init-template.sh <GAME_NAME>`
- If releasing on android
  - Run `scripts/android-keystore.sh <GAME_NAME>`

## Publish

Run the script `./scripts/publish.sh` to build and release on different platforms.
Update the `CHANNELS` variable to your supported platforms.
Dependencies needed are listed at the top of the file

- github: `./scripts/publish.sh v1.0.0`
- itch: `./scripts/publish.sh v1.0.0 itch <ITCH_USER>`
- steam: `./scripts/publish.sh v1.0.0 steam <STEAM_USER>`
  - needs to be configured inside the `.vdf` files