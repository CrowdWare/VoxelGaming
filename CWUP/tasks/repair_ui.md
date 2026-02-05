# Graceful handling of unknown properties and values in UI.sml

Context

After adding new or not yet supported entries to UI.sml, the application may fail to render the UI completely.

Current behavior:
	•	Unknown properties, values, or attributes in UI.sml cause the UI creation to abort.
	•	As a result, no UI is shown at all.

This blocks incremental development and experimentation in UI.sml.

Goal

Unknown or unsupported entries in UI.sml must not break UI rendering.

The UI must always be rendered, even if parts of the SML are not yet implemented.

Desired behavior
	•	If an unknown entry, property, or value is encountered in UI.sml:
	•	Print a warning to the console.
	•	Continue parsing and rendering the UI.
	•	The UI rendering process must be lenient by default, not strict.

Tasks

Detect unknown UI.sml entries
	•	During parsing or model construction, detect:
	•	Unknown element types
	•	Unknown properties
	•	Unknown enum values
	•	Unknown identifiers or references

Prevent UI abort on unknown entries
	•	Remove or guard logic that:
	•	Throws exceptions
	•	Aborts parsing
	•	Aborts UI construction
	•	Ensure parsing and rendering always continue.

Console warnings instead of failures
	•	For each unknown entry:
	•	Print a clear, single warning to the console.
	•	Include enough context to locate the issue (element name, property name).
	•	Avoid repeated warnings for the same issue where possible.

Safe fallback behavior

Define deterministic fallback behavior, for example:
	•	Unknown properties are ignored.
	•	Unknown enum values fall back to a default or undefined state.
	•	Unknown UI elements are skipped, but their children may still be parsed if applicable.

Acceptance criteria
	1.	UI is rendered even if UI.sml contains unknown or unsupported entries.
	2.	No crash or missing UI occurs due to unknown SML content.
	3.	Warnings are printed to the console instead of throwing errors.
	4.	Known entries continue to work unchanged.
	5.	Unknown entries do not affect unrelated UI parts.

Notes

This task is required to support incremental and exploratory UI development.

Strict validation can be added later as an optional mode, but default behavior must remain lenient.