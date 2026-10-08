# flutter_riverpod_foundation

Keemple Flutter foundation: Riverpod for state, GoRouter for navigation,
`AppBootstrap` for startup wiring, typed storage, Dio networking, i18n, and a
bottom-navigation app shell.

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
```

Then restart the Codex desktop app and install `flutter-riverpod-foundation`
from the Plugins Directory.

The plugin ID is `flutter-riverpod-foundation`; the skill name keeps underscores:
`flutter_riverpod_foundation`.

The plugin root is `.agents/`, so the skills keep a single source of truth —
everything under `.agents/skills/` serves both in-place discovery and plugin
packaging, with no second copy to maintain. The marketplace catalog lives at
`.agents/plugins/marketplace.json`.

## Getting started

```bash
flutter pub get
flutter run
```
