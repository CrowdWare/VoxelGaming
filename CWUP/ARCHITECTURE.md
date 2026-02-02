# Architecture
For the RaidBuilder we are using Vulkan directly using C/C++ and for the UI we are using ImGUI declared using SMLUI. 

# Server
The server part will run using ktor and a kotlin service.
Here we already tested with SMS as a scripting language and we also have a SML parser fot kotlin.


The client will start the game and initialise the asset.
The server read the SML for world and for dungeons.
The levels will then be streamed to the client in optimised binyry format.
The client then parses the data and creates the level, world, dungeon based on this data. 

The will pull at least one chunks of 32 * 32 * 32 blocks, for where the user stands.
Additionally we will also load 3 chunks around him. We are loading chunks from below only from above.
Whene  the character walk the next chunks will be loaded and older/far awy chunks will be freed.
So that there is always the same amout of chunks are active.