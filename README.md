# VoxelGaming

VoxelGaming is the **central documentation hub and landing page**
for a system-driven voxel gaming ecosystem.

All source code lives in **separate repositories** and is **referenced here**.
This repository focuses on **architecture, concepts, workflows, and process**.

The public website is hosted via **GitHub Pages** and lives in the `docs/` folder.

---

## Project Scope

VoxelGaming explores how **small, interdisciplinary setups**
can build **deep, long-living game systems** without AAA pipelines.

Focus areas:
- voxel-based world building
- instanced group content (dungeons / raids)
- creator-driven workflows
- architecture-first design
- sustainability over spectacle

---

## RaidSimulator (Game Prototype)

**RaidSimulator** is a **playable game prototype**
used to validate the VoxelGaming technology stack and workflows.

It is **not the final game**, but a **reference implementation**
to test real-world constraints.

### What RaidSimulator Focuses On

- 🎮 **Instanced group content**
  - Controlled encounters
  - Learnable mechanics
  - Reproducible challenges
  - Progression without open-world chaos

- 🏗️ **RaidBuilder integration**
  - Players can become dungeon creators
  - Early content validation through real usage
  - Scales content without content factories

- 👥 **Creator dev access**
  - Creators can test their dungeons in real rendering
  - Validate scale, lighting, flow, and performance
  - Design is verified inside the actual system

- 🌍 **Hybrid world design**
  - Open world for exploration and atmosphere
  - Instanced spaces for group play and progression
  - Inspired by WoW, Hytale, and classic raid design

- 🧱 **Abstract / low-poly visual direction**
  - Clear readability
  - Creator-friendly aesthetics
  - Long-term sustainability
  - No cinematic debt

- 🚫 **No cinematics, no celebrity marketing**
  - No cutscene dependency
  - No influencer-driven hype
  - The system is the product

> **VoxelGaming defines the system.  
RaidSimulator proves it.**

---

## Core Projects (References)

- **RaidBuilder (C++ / Vulkan)**  
  Editor application built on top of `VoxelEngine`, `SMLUI`, and `SMLParser`.  
  Used to create and test instanced dungeons and raid content.

- **RaidBuilderGodot (Legacy)**  
  Godot 4 based editor used as a reference during the Vulkan/C++ porting phase.

- **VoxelEngine**  
  Vulkan-based renderer and voxel core responsible for rendering,
  chunk management, and low-level performance.

- **SMLUI**  
  Bridge layer between **SML (Simple Markup Language)** and **ImGui**,
  used for declarative UI definitions.

- **SMLParser**  
  Lightweight C++11 **SAX-style parser** for SML,
  optimized for streaming and low-overhead parsing.

---

## Repository Links

- RaidBuilder (Vulkan):  
  https://github.com/CrowdWare/RaidBuilderVulkan.git

- VoxelEngine:  
  https://github.com/CrowdWare/VoxelEngine.git

- SMLUI:  
  https://github.com/CrowdWare/SMLUI.git

- SMLParser:  
  https://github.com/CrowdWare/SMLParser.git

---

## Development Process

VoxelGaming and RaidSimulator follow **CWUP – CrowdWare Unified Process**.

CWUP is a **user-centered, architecture-aware development process**
designed for creator-driven and long-living systems.

Key ideas:
- users submit and rate feature requests
- creators validate systems by building content
- architecture and decisions remain explicit
- iteration and publishing happen continuously

📄 See: [`CWUP/README.md`](CWUP/README.md)

---

## GitHub Pages

The project website lives in `docs/` and is published via **GitHub Pages**.

It contains:
- conceptual documentation
- architecture notes
- design decisions
- process descriptions
- CWUP material

---

## Philosophy (Short Version)

> **We build systems, not spectacles.  
We design for players and creators, not viewers.  
We optimize for clarity, longevity, and real use.**