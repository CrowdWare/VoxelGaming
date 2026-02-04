# Third Person Controller (Based on Player / Character Controller)

## Goal
Introduce a **ThirdPersonController** that is based on the existing
`CharacterController` / `PlayerController` implementation.

The goal is to support third-person gameplay (camera following a character)
without duplicating movement or physics logic.

---

## Scope

### 1. Controller Reuse
- ThirdPersonController must reuse:
  - movement logic
  - physics
  - gravity
  - collision handling
- No separate physics or movement implementation is allowed.

The existing controller remains the single source of truth.

---

### 2. Camera Behavior
- Camera follows the player character from a third-person perspective
- Camera position is derived from:
  - character position
  - orientation
  - configurable offset (distance / height)

Camera logic must be clearly separated from movement logic.

---

### 3. Collision Handling
- Character collision remains unchanged
- Camera collision may be handled separately:
  - optional camera collision against world
  - optional clipping prevention
- Camera collision behavior must not affect character physics

---

### 4. Input Mapping
- Movement input continues to drive the character controller
- Mouse / right stick rotates the character and/or camera
- No gameplay logic is embedded in camera code

---

### 5. Builder Compatibility
- ThirdPersonController must be usable in:
  - Game
  - Builder (optional, for preview / testing)
- Switching between first-person and third-person controllers must be possible
  without reloading the level
- Switching is done by rolling the mouse wheel, which also controls the camera distance

---

### 6. Camera Spring / Arm (Minimal)
- Implement a minimal spring-arm style camera:
  - smooth follow (damped movement) for camera position
  - smooth zoom when changing camera distance via mouse wheel
- Optional but recommended:
  - retract camera distance when colliding with world (prevent clipping)
  
---

## Definition of Done
- ThirdPersonController uses existing controller for all movement and physics
- Camera follows character smoothly in third-person view
- No duplicated movement or collision code exists
- Controller can be enabled or disabled at runtime
- First-person and third-person modes can coexist in the codebase