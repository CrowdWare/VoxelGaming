# Deterministic World / Chunk Loading (Audit)

## Status

Implemented: deterministic chunk ordering + optional seed/debug hooks are in place.

Chunk-based loading now sorts chunk coordinates/files consistently across Builder, Server, and Game.

⸻

## Remaining Scope

1. Optional Deterministic Seed (Future-Proof)
	•	Implemented via environment variable
	•	WORLD_SEED (default: 0)
	•	No procedural generation depends on it yet

⸻

2. Explicit Chunk Load Order (Audit)
	•	Chunk files/coords are explicitly sorted by (x, y, z)
	•	No dependence on container iteration or timing

⸻

3. Parity Check
	•	Builder, Server, and Game:
	•	load identical chunk sets
	•	use identical coordinates
	•	follow the same sorted load order
	•	Visual / debug-only differences allowed

⸻

## Optional Debug Support
	•	Debug flag to log:
	•	chunk coordinates
	•	load index (ordinal)
	•	optional seed value
	•	Enabled via CHUNK_DEBUG=1 (or true/yes/on)
	•	Used only for regression testing and bug reports

⸻

## Definition of Done
	•	Reloading the same level produces identical results
	•	Builder, Server, and Game behave identically regarding chunk loading
	•	Deterministic behavior is documented and stable
	•	Seed support is prepared but not yet required
	•	Debug log switch exists for regression/bisecting

⸻

👉 Meaning:
No new functionality needed right now.
This task exists to prevent future nondeterminism when threading, streaming, or procedural content is added.