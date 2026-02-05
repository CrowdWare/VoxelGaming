# Shared Animation Clip Library (Humanoid / Mixamo)

## Goal
Create a **shared animation clip library** for all humanoid characters
using the same skeleton/rig.

Animation clips must be:
- reusable
- decoupled from specific characters
- usable by player characters and companions alike

No custom animation DSL or scripting language is required.

---

## Assumptions
- All humanoid characters use the **same rig**
- Animations are sourced from **Mixamo**
- Animation data is stored in **glTF (.glb)** files
- No retargeting is required

---

## Scope

### 1. Animation Asset Structure
Define a stable convention for animation assets:
Assets/animations/
      ├─ idle.glb
      ├─ walk.glb
      ├─ run.glb
      ├─ attack.glb
      ├─ jump.glb

Each file:
- contains animation data
- may include the skeleton
- does not depend on a specific mesh

---

### 2. Animation Loading
- Game and Builder load animation clips from the shared library
- Clips can be assigned to:
  - player characters
  - companions
  - NPCs

---

### 3. Reuse Across Characters
- Any humanoid character can use any clip from the library
- No duplication of animation data per character
- Character-specific behavior is handled in code, not in animation assets

---

### 4. Runtime Behavior
- Animation selection is driven by code/state (idle, moving, attacking, etc.)
- Animation assets are treated as pure data
- The functionality shall be stored in VoxelEngine

---

## Definition of Done
- Animation clips are stored once and reused
- Player and companion characters share the same clips
- No retargeting or per-character animation exports are required
- Animations can be swapped or extended without rebuilding code