# Godot Template

Custom template for godot games for godot 4

use branch `godot-3.x` for godot 3, but it might not be up-to-date with the latest features

## Setup

After creating the repository with this template do the following:

- Run `scripts/init-template.sh <GAME_NAME>`
- Edit `.github/workflows/release.yml` on which platforms you want to release
- If releasing on android
  - Run `scripts/android-keystore.sh <GAME_NAME>`

## Features

- [Continuous Integration](./.github/FEATURES.md)
- [Internationalization](./addons/i18n/README.md)
- [Input System](./addons/input-system/README.md)
- [Save System](./addons/save-system/README.md)
- [Menu System](./addons/menu-system/README.md)
- [Scene Manager](./addons/scene-manager/README.md)
- [Debug](./addons/debug/README.md)
