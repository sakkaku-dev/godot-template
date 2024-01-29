# Continuous Integration

## Workflows

- `release` - release game on a version tag (e.g v1.0.0)

  - Builds: Windows, Linux, Website, Android, Mac (not tested)
  - Platforms
    - Github Releases
    - Itch.io, if it does not contain `-rc` in the tag
      - The game needs to be created before with the same game name
      - `BUTLER_API_KEY` and `ITCHIO_USER` env key needs to be set

- `test` - run GUT test files inside the project on the master branch
