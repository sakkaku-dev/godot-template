# Godot Template

Custom template for godot games

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
- [Debug](./addons/debug/README.md)
