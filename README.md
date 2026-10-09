# flutter_riverpod_foundation

Flutter Riverpod Foundation: Riverpod for state, GoRouter for navigation,
`AppBootstrap` for startup wiring, typed storage, Dio networking, i18n, and a
bottom-navigation app shell.

---
name: flutter_riverpod_foundation
description: For software developers, build the foundational skeleton of Flutter projects. Integrate Riverpod state management, GoRouter routing, AppBootstrap startup workflow, typed local storage, Dio network layer, i18n internationalization, and bottom navigation AppShell. This skill builds layered architecture, infrastructure layers and business module scaffolding, and does not handle fine-grained UI components or page visual implementation.
compatibility: Claude Code
tags: flutter, riverpod, gorouter, dart, state-management, architecture
---
# flutter_riverpod_foundation
## Overview
This Skill targets software developers, guiding AI to build the basic framework for Flutter projects.
It includes Riverpod state management, GoRouter routing, AppBootstrap startup assembly, typed storage, Dio network layer, i18n internationalization, and bottom navigation AppShell, to generate layered project architecture and basic scaffolding.

## Trigger Conditions
Enable this Skill when the user requests any of the following:
- Create a new Flutter project and build standardized layered architecture
- Integrate global Riverpod state management into a Flutter project
- Configure GoRouter routing and bottom navigation AppShell skeleton
- Build Dio network layer, typed local storage and i18n internationalization infrastructure
- Add new business feature modules following unified project architecture specifications

## Applicable Scenarios
This Skill applies to:
- Building cross-platform commercial Flutter projects for Android and iOS
- Implementing i18n internationalization within Flutter applications

## Excluded Scenarios
This Skill is NOT applicable for:
- Fine-grained UI visuals, widget components and page animation details
- Standalone web frontend application development
- Independent Dart HTTP backend service development

> Note: This Skill only generates project infrastructure, architectural skeleton and base-layer code. Page UI details and component styling are to be implemented by developers afterwards.

## Using the project skills with Codex
This repository ships one Codex skill under `.agents/skills/`:
- `flutter_riverpod_foundation` — how to build here: architecture layout, app
  shell and routing, feature structure, i18n, and storage rules. Used when
  adding foundation layers or features.

No configuration is required: Codex discovers repository skills automatically,
as long as you launch it inside this repository. Invoke one explicitly with
`$flutter_riverpod_foundation`, or let Codex pick it from the skill description.
If it does not appear in the skill list, restart Codex so it re-scans the repo.

Skills in `.agents/skills/` are repository-scoped: they only apply while your
working directory is inside this repository.

### Install it as a plugin
For people who do not work inside this repository, the skill is also packaged
as a plugin:
```bash
codex plugin marketplace add aimaoshi/flutter_riverpod_foundation
