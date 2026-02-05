# Tile Collision

At the moment the Spawn Tile has no collision.
To be able to flag other tiles also to not have collision we are now using the property collision.
This property defaults to true.

```qml
Tile {
    key: "S"
    name: "Spawn"
    icon: "res://assets/textures/raid_spawn.png"
    texture: "res://assets/textures/raid_spawn.png"
    model: "../build/blocks_cache/block.glb"
    material: texture
    collision: false
}
```

This property shall also be saved in dungeon.sml.