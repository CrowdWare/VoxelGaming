Goal:
  Implement a simple, stable kinematic character controller for a voxel world (Minecraft/Hytale feel).
  No rigid-body simulation, no constraints, no stacking.

  World:
  - Static voxel grid
  - Function/API available (or implement stub): `isSolid(ix:Int, iy:Int, iz:Int): Boolean`
  - Block size: 0.60m (60 cm). Units in code: meters.

  Character:
  - Shape: CAPSULE (preferred) OR AABB (choose one and implement it consistently)
  - Provide parameters: radius, height
  - Use a small collision skin/epsilon (e.g. 0.001..0.01m) to avoid sticking/jitter.

  Simulation:
  - Fixed timestep: 60 Hz (dt = 1/60), accumulator loop
  - Semi-implicit Euler integration:
    - velocity += acceleration * dt (incl gravity)
    - desiredDelta = velocity * dt

  Collision:
  - Static collisions against voxel blocks only.
  - Resolve movement axis-separated (X then Y then Z):
    - Move along axis
    - Query overlapping blocks in the swept/expanded AABB region
    - If collision: clamp position to contact and zero velocity component on that axis.

  Grounding:
  - `isGrounded = true` if collision happened while moving downward on Y.
  - Jump only if grounded.

  Step-up:
  - Step height = 0.20m (20 cm = 1/3 block height).
  - If horizontal (X/Z) collision blocks movement, attempt step:
    - Temporarily raise by up to stepHeight and retry the horizontal move
    - If succeeds without penetrating, keep stepped position; otherwise revert.

  Acceptance:
  - Character glides over 20cm steps by default (no manual jump).
  - No jitter at rest on flat ground.
  - No tunneling through thin walls at normal player speeds.