# Shared Block / Tile Rendering Between Builder and Game

## Goal
Ensure that **Builder and Game render the same block and tile models**
using the same data and rendering logic.

Currently:
- Builder renders the correct models
- Game falls back to generic StoneBlocks

This task removes that discrepancy.

---

## Problem Statement
Builder and Game use different code paths or data sources for block rendering.

As a result:
- Visual representation differs between Builder and Game
- Level appearance in Builder does not match actual gameplay
- Visual validation during level building is unreliable

---

## Scope

### 1. Single Source of Truth for Block Definitions
- Block / tile definitions must be shared
- Model, mesh, material, and visual properties are defined once
- Builder and Game must load the same definitions

No duplicated block registries or hardcoded fallbacks.

---

### 2. Shared Block Rendering Pipeline
- Builder and Game use the same block-to-mesh resolution logic
- Same lookup rules:
  - block ID / type
  - model path
  - material parameters

Differences between Builder and Game may exist only in:
- debug overlays
- selection highlighting
- editor-specific visuals

---

### 3. Remove Game Fallback Rendering
- Game must no longer replace unknown blocks with StoneBlocks
- Missing or invalid block definitions should:
  - log a clear error
  - optionally render a debug placeholder

Silent fallback rendering is not allowed.

---

### 4. Builder ↔ Game Visual Parity
- A level built in Builder must look visually identical in Game
- No block-specific visual differences between the two applications

---

## Definition of Done
- Builder and Game render the same blocks with the same models
- No StoneBlock fallback is used for valid blocks
- Visual appearance matches across both applications
- Block rendering logic exists only once and is reused