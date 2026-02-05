# Chunk-aware Save for dungeon.sml and fixed server dungeon folder

## Context

Before implementing deterministic_world_loading we need a reliable SaveAs pipeline that can store a dungeon either as a single file or as chunk files, depending on dungeon size.

We already have an existing dungeon.sml format that can be loaded and saved as one file.

The server must now load a dungeon from a fixed folder defined inside run_server.sh.
The server is currently still started via gradle run, which is not desired.

⸻

## Goals
	1.	Load an existing dungeon.sml (current format).
	2.	Save it via SaveAs into a user-selected directory.
	3.	Store the dungeon either as a single file or as chunk files, depending on size.
	4.	Start the server with a fixed dungeon folder configured in run_server.sh.
	5.	Replace gradle run with a direct java startup.

⸻

## SaveAs user flow
	1.	User opens an existing dungeon.sml.
	2.	User selects Save As.
	3.	A folder picker opens (directory selection), example target: Documents/Dungeons/Sample
	4.	After selection, the app saves to that directory: Documents/DungeonsSample/dungeon.sml and optionally chunk files: Documents/Dungeons/Sample/dungeon_x_y_z.sml

⸻

## Dungeon storage rules

Single file mode

If the dungeon does not need chunking:
	•	Maximum dungeon size is 32 x 32 blocks.
	•	Save everything into:
dungeon.sml
	•	The content is stored exactly like the current existing format.

Chunked mode

If the dungeon is larger than 32 x 32 blocks:
	•	Save only the following into dungeon.sml:
	•	Tile definitions
	•	ChunkSize
	•	Required global metadata
	•	Save chunk contents as separate files:
dungeon_x_y_z.sml
	•	Chunk file naming must be deterministic and stable:
x, y, z are chunk coordinates.

⸻

## Server startup changes

Fixed dungeon folder in run_server.sh

The dungeon folder is defined inside run_server.sh, not passed as a command line argument.

run_server.sh responsibilities:
	•	Define the dungeon folder internally, for example:
	•	DUNGEON_FOLDER=Documents/Dungeons/Sample
	•	Start the server with this folder.
	•	The Java main method reads the dungeon folder from:
	•	an argument provided by the script, or
	•	an environment variable set by the script.

(The mechanism is free, but the folder name is not user-provided at runtime.)

⸻

## Replace gradle run with java

Current state:
	•	run_server.sh uses gradle run.

Required change:
	•	Build the server once using Gradle.
	•	Start the server using java directly:
	•	java -jar server.jar
	•	or java -cp … MainClass

run_server.sh must:
	•	Not invoke gradle run nor gradle build.
	•	Only start the already-built server.
	•	Provide the dungeon folder to the server startup logic.

⸻

## Acceptance criteria
	1.	Existing dungeon.sml files still load correctly.
	2.	SaveAs writes into the selected directory.
	3.	dungeon.sml is always written.
	4.	For non-chunked dungeons:
	•	Only dungeon.sml exists.
	•	Content matches the previous format.
	5.	For chunked dungeons:
	•	dungeon.sml contains only tiles, ChunkSize, and metadata.
	•	dungeon_x_y_z.sml files exist and reconstruct the dungeon.
	6.	run_server.sh defines the dungeon folder internally.
	7.	The server loads the dungeon from that folder.
	8.	run_server.sh does not use gradle run.

⸻

## Notes for follow-up tasks
	•	Server-side chunk streaming
	•	Deterministic world loading
	•	Chunk-wise loading in RaidBuilder