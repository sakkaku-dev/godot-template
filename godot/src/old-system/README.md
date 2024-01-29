# Base system

1. [Base](#base) - generic nodes that did not yet for any groups
1. [Input](#input)
1. [Menu](#menu)
1. [Save](#save)

## Base

## Input

- `PlayerInput`: input for a single player
- `DeviceSwitcher`: add as child to a player input to switch between controller and keyboard

## Menu

TODO

## Save

- `CacheManager`: save data for all `Persist` groups within the scene. Scene names has to be unique
- `SaveManager`: saves data to a file, accessed by a slot number
- `CacheProperies`: define properties to be saved by `CacheManager` for a node
