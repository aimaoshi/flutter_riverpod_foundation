# flutter_riverpod_foundation

Flutter Riverpod Foundation: Riverpod for state, GoRouter for navigation,
`AppBootstrap` for startup wiring, typed storage, Dio networking, i18n, and a
bottom-navigation app shell.
---
name: dart-build-cli-app
description: 用于Dart/Flutter软件开发工程师，构建Dart命令行CLI应用。包含架构模式、入口结构、退出码、流路由、子进程创建；支持使用package:args做参数解析、CommandRunner、配置pubspec.yaml可执行文件、编译原生CLI二进制程序。适用于开发命令行工具、控制台工具、脚本开发。不用于Flutter UI组件、Web应用、独立HTTP后端服务开发。
compatibility: Claude Code
tags: dart, cli, flutter, commandline, developer-tool
---
# dart-build-cli-app
## 概述
本Skill面向软件开发工程师，指导AI完成Dart CLI命令行项目的搭建、代码编写、参数解析、子进程调用与二进制编译。

## 触发条件
当用户提出下面任意需求时，启用本Skill：
- 需要新建Dart命令行应用
- 编写Dart CLI工具、控制台脚本
- 使用`package:args`、CommandRunner做命令参数解析
- 配置pubspec.yaml，编译Dart原生可执行二进制文件
- Dart代码处理exit code、子进程spawn、stdout/stderr流处理

## 禁止场景
本Skill**不适用**于：
- Flutter UI界面组件开发
- Web前端应用
- Dart独立HTTP后端服务


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
