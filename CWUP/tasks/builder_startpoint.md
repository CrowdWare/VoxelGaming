# Implement player start point

## Flow:
  - On app start, load level data from dungeons.sml.
  - The level contains a special tile marker "S" indicating the player start position.

##  Behavior:
  - Find exactly one tile with id "S".
  - Store its world position as player spawn position.
  - Replace the "S" tile with an empty/ground tile (so it is not rendered or collidable).
  - Spawn the player at the computed position.

##  Constraints:
  - "S" is only used as a spawn marker, not a real game tile.