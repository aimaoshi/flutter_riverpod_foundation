# flutter_riverpod_foundation

Keemple Flutter foundation: Riverpod for state, GoRouter for navigation,
`AppBootstrap` for startup wiring, typed storage, Dio networking, i18n, and a
bottom-navigation app shell.

## Using the project skill with Codex

This repository ships a Codex skill that teaches the agent this project's
conventions — architecture layout, app shell and routing, feature structure,
i18n, and storage rules.

- Location: `.agents/skills/flutter_riverpod_foundation/SKILL.md`
- No configuration required: Codex discovers repository skills automatically,
  as long as you launch it inside this repository.
- Invoke it explicitly with `$flutter_riverpod_foundation`, or let Codex select
  it from the skill description when you add foundation layers or features.
- If it does not appear in the skill list, restart Codex so it re-scans the repo.

Skills in `.agents/skills/` are repository-scoped: they only apply while your
working directory is inside this repository. To share a skill across projects,
package it as a plugin instead.

## Getting started

```bash
flutter pub get
flutter run
```
