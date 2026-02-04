# RaidBuilder character controller

## Goal

Builder uses the same CharacterController implementation as RaidSimulator, so level building can be tested with real physics.

## Scope / Changes
	1.	Reuse controller

	•	Builder instantiates and updates VoxelEngine::CharacterController (same codepath as RaidSimulator).
	•	Builder camera/player movement uses controller position/orientation (no separate movement logic).

	2.	New controller options

	•	Add canToggleGravityMode: bool
	•	Builder sets true
	•	RaidSimulator sets false (or default false)
	•	Add canToggleCollision: bool
	•	Builder sets true

	3.	Behavior

	•	Gravity mode toggle (e.g. G or existing key): switches between
	•	gravity on: normal walking controller
	•	gravity off: fly mode
	•	In fly mode:
	•	Q/E changes vertical velocity/height (up/down)
	•	Collision toggle (noclip):
	•	when collision disabled, controller ignores world collision queries
	•	specifically: in non-gravity fly mode, movement should pass through blocks if collision is off

## Acceptance Criteria (Definition of Done)
	•	Builder: walking matches RaidSimulator controller feel (gravity, ground, slopes/steps if supported).
	•	Fly mode: Q/E moves up/down smoothly.
	•	Collision toggle works:
	•	collision ON: camera/controller cannot enter blocks
	•	collision OFF: camera/controller can pass through blocks (noclip), especially in fly mode
	•	No code duplication: Builder does not have its own movement/physics implementation besides feeding input into controller.