# Deterministic World / Chunk Loading (Audit)

## Status

Implemented, except for explicit seed handling.

Chunk-based loading works correctly across Builder, Server, and Game.

⸻

## Remaining Scope

1. Optional Deterministic Seed (Future-Proof)
	•	Introduce a single, explicit world seed
	•	Initially:
	•	hardcoded constant or
	•	level / world metadata
	•	No procedural generation depends on it yet

⸻

2. Explicit Chunk Load Order (Audit)
	•	Verify chunk loading order is:
	•	explicitly defined
	•	not dependent on container iteration or timing
	•	Current behavior is assumed deterministic but should be documented / locked

⸻

3. Parity Check
	•	Builder, Server, and Game:
	•	load identical chunk sets
	•	use identical coordinates
	•	follow the same load order
	•	Visual / debug-only differences allowed

⸻

## Optional Debug Support
	•	Debug flag to log:
	•	chunk coordinates
	•	load index (ordinal)
	•	optional seed value
	•	Used only for regression testing and bug reports

⸻

## Definition of Done
	•	Reloading the same level produces identical results
	•	Builder, Server, and Game behave identically regarding chunk loading
	•	Deterministic behavior is documented and stable
	•	Seed support is prepared but not yet required

⸻

👉 Meaning:
No new functionality needed right now.
This task exists to prevent future nondeterminism when threading, streaming, or procedural content is added.