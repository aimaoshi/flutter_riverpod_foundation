# flutter_riverpod_foundation

Keemple Flutter foundation: Riverpod for state, GoRouter for navigation,
`AppBootstrap` for startup wiring, typed storage, Dio networking, i18n, and a
bottom-navigation app shell.

## Using the project skills with Codex

This repository ships two Codex skills under `.agents/skills/`:

- `flutter_riverpod_foundation` — how to build here: architecture layout, app
  shell and routing, feature structure, i18n, and storage rules. Used when
  adding foundation layers or features.
- `flutter_riverpod_review` — how to review here: a per-layer checklist covering
  layering, Riverpod usage, routing, the nine locale files, networking and log
  redaction, assets, widget performance, tests, and static analysis. Used when
  reviewing a diff or PR.

No configuration is required: Codex discovers repository skills automatically,
as long as you launch it inside this repository. Invoke one explicitly with
`$flutter_riverpod_foundation` or `$flutter_riverpod_review`, or let Codex pick
it from the skill description. If they do not appear in the skill list, restart
Codex so it re-scans the repo.

Skills in `.agents/skills/` are repository-scoped: they only apply while your
working directory is inside this repository.

### Install it as a plugin

For people who do not work inside this repository, both skills are also
packaged as a plugin:

```bash
codex plugin marketplace add aimaoshi/flutter_riverpod_foundation
```

Then restart the Codex desktop app and install `flutter_riverpod_foundation`
from the Plugins Directory.

The plugin root is `.agents/`, so the skills keep a single source of truth —
everything under `.agents/skills/` serves both in-place discovery and plugin
packaging, with no second copy to maintain. The marketplace catalog lives at
`.agents/plugins/marketplace.json`.

## Getting started

```bash
flutter pub get
flutter run
```
