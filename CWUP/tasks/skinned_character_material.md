## Title
Introduce `material: skinned` for character tiles using Blender-exported `.gltf` as the single source of truth

## Context
So far, `material: texture` is used exclusively for **voxel / block tiles** rendered as simple textured quads.

Characters (NPCs, enemies) require a separate render path:
- skinned meshes
- skeleton-driven animation
- textures/materials from glTF
- `.gltf` assets exported by Blender (JSON + external `.bin` + external images)

---

## Decision / Contract (IMPORTANT)
### Single Source of Truth
For `material: skinned`, the **`.gltf` file is the only source of truth** for:
- binary buffers (`buffers[].uri` → typically the `.bin` file)
- textures (`images[].uri`)
- materials (baseColor/normal/spec/etc mapping, as far as we support it)


### Path Resolution Rule
All referenced URIs in the `.gltf` (buffers + images) must be resolved:
- **relative to the directory of the `.gltf` file**

Example folder layout (recommended):
```
Assets/characters/
  paladin.gltf
  paladin.bin
  Paladin_diffuse.png
  Paladin_normal.png
  Paladin_specular.png
```

---

## Tile Definition (Character Example)

```sml
Tile {
    key: "E"
    name: "Enemy"
    icon: "res://assets/textures/raid_enemy.png"

    model: "Assets/characters/Paladin/paladin.gltf#Paladin_J_Nordstrom_Helmet#Paladin_J_Nordstrom"
    animation: "Assets/animations/idle.glb"

    material: skinned
}
```

Notes:
- `#...` selects multiple nodes/meshes (existing convention).
- `animation` may be a separate file (e.g. `.glb`) and must bind by joint/node name.

---

## Scope

### 1) Tile Parsing
- Add support for `material: skinned`
- When `material == skinned`:
  - ignore block-only fields such as `texture`
  - require `model`
  - `animation` is optional

### 2) glTF Loader (External `.bin` + External Images)
Support standard `.gltf` loading as exported by Blender:

#### Buffers (`.bin`)
- Parse `buffers[]`
- For each buffer with `uri`:
  - resolve path relative to the `.gltf` directory
  - load bytes into memory

#### BufferViews / Accessors
- Support `bufferViews`:
  - `byteOffset`
  - `byteLength`
  - `byteStride` (if present)
- Accessors must correctly map into loaded buffer memory

#### Images (Textures)
- Support `images[i].uri` (external PNG/JPG etc.)
- Resolve image paths relative to the `.gltf` directory

### 3) Rendering (Skinned Path)
- Route `material: skinned` tiles through the skinned-mesh render path
- Support GPU skinning for skinned primitives:
  - mesh provides `JOINTS_0` and `WEIGHTS_0`
  - glTF provides `skins[].joints` and `inverseBindMatrices`
- Diffuse/baseColor should render correctly; other maps may be ignored initially

### 4) Animation
- Bind animation channels to the runtime skeleton by joint/node name
- Advance animation time per frame
- Apply sampled pose to the skinning palette

---

## Debug / Validation (Required)
- On model load, log:
  - `.gltf` path
  - resolved buffer uris + byte sizes
  - resolved image uris
  - skeleton joint count (if skinned)
- Fail loudly (error + clear message) if:
  - a referenced buffer/image file cannot be loaded
- For animation binding, log:
  - channels bound count
  - missing/unmatched joint/node names (if any)

---

## Definition of Done
- Blocks still render correctly using `material: texture`
- Characters render using `material: skinned` without duplicating `.bin` or texture paths in tiles
- `.gltf` + external `.bin` + external images load correctly (paths resolved relative to `.gltf`)
- Paladin character renders and can play an idle animation (when provided and compatible)
- No silent failures; actionable logs exist for missing files or binding mismatches
