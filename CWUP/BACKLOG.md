# Backlog

## Functional Requirements

### Platform Support
- The software must run on **Windows**, **macOS**, and **Linux**.
- Feature parity across platforms (no platform-exclusive gameplay features).
- Platform-specific integrations (if any) must degrade gracefully on other systems.

### Server Execution Model
- In **SinglePlayer / SingleServerMode**, the server **must run on the player’s computer**.
- In SinglePlayer mode, the server **should run on a single CPU core**.
- The server must not require a dedicated or remote machine for SinglePlayer gameplay.
- The same server binary/codebase is used for SinglePlayer and Guild Server modes.

## Non-Functional Requirements

### Performance
- Stable frame pacing; avoid stutter (consistent frame times).
- Scalable quality settings (low/medium/high) and resolution scaling.
- Predictable CPU/GPU budgets per frame; batch heavy work off the main thread.

### Determinism & Reproducibility
- Server-authoritative simulation (also in SingleServerMode).
- Repeatable combat outcomes for debugging and training.
- Fixed or well-defined tick rates; simulation decoupled from render FPS.

### Stability & Fault Tolerance
- No hard crashes on malformed scripts or content.
- Graceful failure with clear error logs and safe fallbacks.
- Clean shutdown on SIGTERM; always flush saves.

### Security (Self-Hosted / Guild Servers)
- Validate all client inputs server-side.
- Rate limiting for spammy actions (abilities, RPCs, join/leave).
- Scripts execute server-side only; no remote code execution.
- Clear separation between admin and player privileges.

### Maintainability
- KISS: one scripting system for bots, bosses, doors, traps, switches.
- Minimal special cases; behavior defined by scripts.
- Versioned protocol and save formats with explicit migrations.

### Observability
- Structured logs (timestamp, level, subsystem, entity id).
- Lightweight debug overlays for demo/training (DPS/Threat, CC timers).
- Simple server status output (uptime, players, tick time).

### Configurability
- All runtime settings via config files.
- Optional hot-reload for scripts/configs in local mode.
- Explicit Non-Goals documented to manage expectations.

### Portability
- Fully playable offline (SingleServerMode).
- Guild server runs on common Linux VPS distributions.
- Reproducible builds with pinned toolchains where possible.

### Data & Persistence
- Atomic save writes (write temp → fsync → rename).
- Manual and automated backup support with clear rotation strategy.
- Deterministic serialization order for world and state data.

### Usability (Player & Admin)
- Clear in-game feedback for core rules (engage range, resets, CC breaks).
- Companion control limited to turn and XZ movement for predictability.
- Simple server lifecycle: build → deploy → run as service.

### Compatibility & Upgrades
- Clear client/server version compatibility checks.
- Backward compatibility where feasible; explicit breaking changes.
- Changelogs focus on behavior and system-level changes.

## Use Cases

## Tasks
- [x] tasks/player_startpoint.md
- [x] tasks/physics_character_controller.md
- [x] tasks/shared_block_rendering.md
- [ ] tasks/builder_startpoint.md
- [ ] tasks/builder_character_controller.md
- [ ] tasks/deterministic_world_loading.md
- [ ] tasks/animation_clip_library.md
- [ ] tasks/third_person_controller.md

  