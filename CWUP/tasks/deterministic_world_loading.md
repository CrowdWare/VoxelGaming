# Deterministic World / Chunk Loading

## Goal
Ensure that world and chunk loading is **deterministic and reproducible** across
Builder, Game, and Server.

This allows:
- predictable testing
- reproducible bugs
- comparable performance measurements
- identical results across machines and platforms

---

## Scope

### 1. Deterministic Seed
- World loading must be driven by a fixed seed
- Seed can be:
  - hardcoded (initially)
  - provided via config or CLI later

---

### 2. Deterministic Chunk Order
- Chunks must be loaded in a **defined and stable order**
- No dependency on:
  - thread timing
  - hash-map iteration order
  - platform-specific behavior

Examples:
- spiral from player start
- axis-aligned expanding square
- fixed sorted list

---

### 3. Consistent Coordinates
- Chunk indices and world coordinates must be:
  - stable
  - integer-based
  - platform-independent

No floating-point derived chunk addressing.

---

### 4. Builder / Game Parity
- Builder and Game must load:
  - the same chunks
  - in the same order
  - with the same seed
- Only visual/debug features may differ

---

## Debug / Validation
- Optional debug output:
  - current seed
  - chunk load order
  - chunk coordinates
- Useful for regression testing and bug reports

---

## Definition of Done
- Same seed → same chunks → same order
- Reloading the same level produces identical results
- Builder and Game behave identically regarding world loading
- No nondeterministic behavior remains in chunk generation/loading  


## Known Limitation / Current Issue
- The server is currently unable to load a dungeon with a size of **34 × 34** blocks.
- When attempting to load such a dungeon, the server logs:
  INFO  RaidServer - Serving chunk (0,0,0) with 0 blocks
- This indicates that chunk data is not correctly generated or transferred for larger dungeon sizes.
  