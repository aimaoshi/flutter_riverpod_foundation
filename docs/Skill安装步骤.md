# 安装 flutter_riverpod_foundation Skill 步骤（小白版）

这份文档讲的是**怎么把 `flutter_riverpod_foundation` 这个 skill 装进 AI Agent**，
不是装 Flutter 项目。装好之后，Codex 写这个项目的代码时就会自动按 Keemple 基础框架的
规范来（Riverpod 状态、GoRouter 路由、feature-first 目录、i18n 全语言补齐等）。

来源仓库（公开）：`https://github.com/aimaoshi/flutter_riverpod_foundation`

`SKILL.md` 就是一个纯文本的规范文档，安装 = 把它放到 Agent 会去读的目录。
仓库里其实放了两份内容一模一样的副本：

| 仓库里的路径 | 给谁用 |
| --- | --- |
| `.codex/skills/flutter_riverpod_foundation/SKILL.md` | Codex |
| `.agents/skills/flutter_riverpod_foundation/SKILL.md` | 其他 Agent（Claude Code 等） |

四种装法，作用范围不同，按需要选一种（也可以同时装）：

| 装法 | 放哪里 | 生效范围 | 适合 |
| --- | --- | --- | --- |
| **方式一：插件市场**（推荐） | Codex 插件缓存 | 所有项目 | 自己的电脑，一次装好 |
| 方式二：个人级 skill | `~/.codex/skills/flutter-riverpod-foundation/SKILL.md` | 所有项目 | 不想装插件 |
| 方式三：项目级 skill | `<项目>/.codex/skills/flutter_riverpod_foundation/SKILL.md` | 只在这个项目 | 团队共享、随代码走 |
| 方式四：通用目录 | `~/.agents/skills/...` | 其他 Agent | Claude Code 等 |

**共同前提**：能访问 github.com；装插件方式需要 Codex 桌面端 / CLI。
另外，**skill 在「会话开始时」加载，装完要新开一个对话才会生效**——这是最容易踩的坑。

---

## 方式一：用 codex CLI 安装（推荐，最快）

在**任意目录**执行即可，不用先 cd 到项目里。三条命令：

```bash
# 第 1 步：把这个 Git 仓库注册成一个「插件市场」（marketplace）
codex plugin marketplace add aimaoshi/flutter_riverpod_foundation --ref main

# 第 2 步：从市场里安装插件（格式是 插件名@市场名）
codex plugin add flutter-riverpod-foundation@flutter-riverpod-foundation

# 第 3 步：确认状态
codex plugin list
```

> `codex plugin marketplace add owner/repo --ref main` 这种写法就是 CLI 自带示例里的形式；
> `<SOURCE>` 支持本地路径、`owner/repo[@ref]`、HTTPS / SSH Git 地址四种。

### 第 1 步：添加 marketplace

```bash
codex plugin marketplace add aimaoshi/flutter_riverpod_foundation --ref main
```

**✅ 成功的样子**

```bash
codex plugin marketplace list
```

能看到一行 `flutter-riverpod-foundation` 以及它的本地快照目录
（例如 `/Users/isurpass/.codex/.tmp/marketplaces/flutter-riverpod-foundation`）；
`~/.codex/config.toml` 里也会多出 `[marketplaces.flutter-riverpod-foundation]` 这一段：

```toml
[marketplaces.flutter-riverpod-foundation]
source_type = "git"
source = "https://github.com/aimaoshi/flutter_riverpod_foundation.git"
ref = "main"
```

**❌ 失败的样子和怎么办**

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| 提示拉取失败 / 超时 | 访问不了 GitHub | 检查网络或代理，先用浏览器打开仓库地址确认能访问 |
| `codex: command not found` | 没装 Codex CLI | 装 Codex 桌面端（自带 CLI），或改用方式二 / 方式三 |
| 列表里没有这一项 | 仓库名或 ref 写错 | 必须是 `aimaoshi/flutter_riverpod_foundation`，ref 是 `main` |

### 第 2 步：安装并启用插件

```bash
codex plugin add flutter-riverpod-foundation@flutter-riverpod-foundation
```

不想写 `@市场名` 也可以写成 `codex plugin add flutter-riverpod-foundation -m flutter-riverpod-foundation`。

**✅ 成功的样子**

`codex plugin list` 里对应的那一行显示 **installed, enabled**：

```text
Marketplace `flutter-riverpod-foundation`
PLUGIN                                                   STATUS              VERSION  PATH
flutter-riverpod-foundation@flutter-riverpod-foundation  installed, enabled  0.1.0    ~/.codex/.tmp/marketplaces/flutter-riverpod-foundation/.agents
```

磁盘上也能找到 skill 本体：

```bash
ls ~/.codex/plugins/cache/flutter-riverpod-foundation/*/*/skills/flutter_riverpod_foundation/SKILL.md
```

**❌ 失败的样子和怎么办**

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| 提示找不到插件 | 市场快照里还没有这个插件 | 先做第 1 步；再 `codex plugin marketplace upgrade flutter-riverpod-foundation` 刷新 |
| 缓存目录是空的 | 插件没真正下载下来 | 删掉 `~/.codex/plugins/cache/flutter-riverpod-foundation` 后重新安装 |
| 状态显示 not installed | 上一步没成功 | 重新执行 `codex plugin add ...` |

> 不想用命令行也行：Codex 桌面端 → 设置 → 插件（Marketplace）→ 添加
> `https://github.com/aimaoshi/flutter_riverpod_foundation.git` → 在列表里点安装；
> 等价于手改 `~/.codex/config.toml` 里的 `[marketplaces.*]` 和 `[plugins.*]` 两段。

### 第 3 步：新开一个会话验证

**怎么做**：完全关掉当前对话，新建一个 chat，然后问一句：

> 你现在有哪些 skill？flutter_riverpod_foundation 里写了什么规范？

**✅ 成功的样子**：它能说出「Riverpod / GoRouter / feature-first 目录 / 底部导航骨架 /
i18n 必须补全所有语言」这类内容，写这个项目的代码时也会主动按规范来。

**❌ 失败的样子和怎么办**

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| 它说没有这个 skill | 还在旧会话里 | 重开会话；skill 在会话启动时加载 |
| 换会话还是不行 | 路径 / 配置不对 | 执行文末「怎么确认装好了」的三步检查 |

---

## 方式二：只装成个人级 skill（不装插件）

**怎么做**（三选一，效果一样）

```bash
# 2A. 两条命令搞定
mkdir -p ~/.codex/skills/flutter-riverpod-foundation
curl -fsSL https://raw.githubusercontent.com/aimaoshi/flutter_riverpod_foundation/main/.codex/skills/flutter_riverpod_foundation/SKILL.md \
  -o ~/.codex/skills/flutter-riverpod-foundation/SKILL.md
```

```bash
# 2B. 用官方安装脚本（网络受限时需要提权运行）
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo aimaoshi/flutter_riverpod_foundation \
  --path .codex/skills/flutter_riverpod_foundation \
  --name flutter-riverpod-foundation
```

```text
# 2C. 最省事：直接让 Codex 帮你装
「用 skill-installer 从 github 仓库 aimaoshi/flutter_riverpod_foundation 安装 flutter_riverpod_foundation skill」
```

**注意**：2B 的脚本默认装到 `$CODEX_HOME/skills`（也就是 `~/.codex/skills`），
而且**目标目录已存在时会直接中止**。如果之前装过，先删掉旧目录再执行，或者加
`--dest` / `--name` 换个位置装。

**✅ 成功的样子**

```bash
head -3 ~/.codex/skills/flutter-riverpod-foundation/SKILL.md
```

输出是 `---` / `name: flutter-riverpod-foundation` / `description: ...`（YAML 头 + 正文）。

**❌ 失败的样子和怎么办**

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| `curl` 下载到一堆 HTML / 提示 404 | 路径拼错 | Codex 用 `.codex/skills/...`，其他 Agent 用 `.agents/skills/...`，别搞混 |
| 提示 `Destination already exists` | 目录已存在 | 先 `rm -rf ~/.codex/skills/flutter-riverpod-foundation`，或加 `--name` 换名 |
| 文件有了但 Agent 不认 | 目录/文件命名不对，或没重开会话 | 文件名必须恰好是 `SKILL.md`（大写、无后缀）；目录名用技能名即可（`flutter-riverpod-foundation` 或 `flutter_riverpod_foundation` 都能识别，本机两种都在用）；然后重开会话 |
| 用 `python3` 提示网络错误 | 沙箱/防火墙拦截 | 让 Codex 用提权方式执行，或直接照 2C 让 Codex 代装 |

---

## 方式三：装成项目级 skill（团队共享，随代码走）

**怎么做**

```bash
mkdir -p ~/Desktop/Demo/.codex/skills/flutter_riverpod_foundation
cp ~/.codex/skills/flutter-riverpod-foundation/SKILL.md \
   ~/Desktop/Demo/.codex/skills/flutter_riverpod_foundation/SKILL.md
```

（本文档所在的 Demo 项目已经装好了这一份。）

**✅ 成功的样子**：项目里存在 `.codex/skills/flutter_riverpod_foundation/SKILL.md`；
在**这个项目目录**下新开会话，AI 会按框架规范写代码；`git status` 能看到这个文件，提交后同事拉下去自动拥有同样的规范。

**❌ 失败的样子和怎么办**

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| 放进去不生效 | 放错目录 | 必须是「项目根目录」下的 `.codex/skills/<技能名>/SKILL.md`，不要放进 `lib/` 或项目上一级 |
| 同事那边没有 | 忘了提交 | 这个文件要一起 commit / push |
| 项目级和全局同时存在，规则打架 | 两份 SKILL.md 内容不同 | 以项目级为准，更新时两边一起改 |

---

## 方式四：装给其他 Agent（Claude Code 等）

**怎么做**

仓库里的 `.agents/` 就是通用副本：`.agents/plugin.json`、`.agents/plugins/marketplace.json`、
`.agents/skills/flutter_riverpod_foundation/SKILL.md`。
把它拷到对应 Agent 的 skills 目录即可，比如本机通用的位置是 `~/.agents/skills/`：

```bash
mkdir -p ~/.agents/skills/flutter_riverpod_foundation
cp <仓库>/.agents/skills/flutter_riverpod_foundation/SKILL.md \
   ~/.agents/skills/flutter_riverpod_foundation/SKILL.md
```

如果你用 ArkCLI，也可以直接执行 `arkcli connect`，把 skill 安装/同步到本机检测到的所有 Agent。

**✅ 成功的样子**：对应 Agent 新开会话后，能复述 Keemple 框架的规范。
**❌ 失败的样子和怎么办**：报「不认识这个 skill」→ 确认拷进了该 Agent 实际读取的目录（不同 Agent 目录不同），并重启该 Agent。

---

## 怎么确认装好了（三层验证）

| 层次 | 命令 / 动作 | 通过的样子 |
| --- | --- | --- |
| 文件层 | `ls ~/.codex/skills/flutter-riverpod-foundation/SKILL.md` | 文件存在 |
| 配置层（插件方式） | `grep -A3 "marketplaces.flutter" ~/.codex/config.toml` | 能看到 source 指向 GitHub 仓库 |
| 使用层 | **新开一个会话**，问「你现在有哪些 skill？」 | 它答得上来，并会主动按规范写代码 |

三层都过了才算真的装好；只过了前两层、第三层不行，基本都是「没重开会话」。

---

## 更新与卸载

| 需求 | 做法 |
| --- | --- |
| 更新（插件方式） | `codex plugin marketplace upgrade flutter-riverpod-foundation` 重新拉取仓库快照；作者发了新版本后再执行一次 `codex plugin add flutter-riverpod-foundation@flutter-riverpod-foundation` |
| 更新（其他方式） | 重新执行安装命令（先删旧目录） |
| 卸载（个人级） | `rm -rf ~/.codex/skills/flutter-riverpod-foundation` |
| 卸载（项目级） | 删掉项目里的 `.codex/skills/flutter_riverpod_foundation/` |
| 卸载（插件方式） | `codex plugin remove flutter-riverpod-foundation@flutter-riverpod-foundation`，再 `codex plugin marketplace remove flutter-riverpod-foundation`（等价于删掉 `~/.codex/config.toml` 里对应的两个配置块） |

---

## 常见问题速查

| 现象 | 原因 | 一句话处理 |
| --- | --- | --- |
| 装完 AI 还是不按规范写 | 没重开会话 | 新开一个 chat |
| `curl` 拿到 404 / HTML | 路径写错 | Codex 用 `.codex/...`，其他 Agent 用 `.agents/...` |
| 脚本提示目录已存在 | 之前装过 | 先删旧目录，或用 `--dest` / `--name` |
| 市场里搜不到这个插件 | marketplace 没加成功 | 检查 config.toml 里 source 与 ref |
| 项目里生效、换个项目就不生效 | 装的是项目级 | 想要全局生效就走方式一或方式二 |
| 换了电脑要重来 | skill 不跟着账号同步 | 在新机器重做一次方式一，或把 `~/.codex/skills/` 拷过去 |

---

## 本机现状（2026-10-08 实测）

这台机器三种安装都已经存在，可以直接对照：

| 安装形式 | 位置 | 状态 |
| --- | --- | --- |
| 插件市场 | `codex plugin marketplace list` 里有 `flutter-riverpod-foundation`，快照在 `~/.codex/.tmp/marketplaces/flutter-riverpod-foundation`；config.toml 里是 `[marketplaces.flutter-riverpod-foundation]`（source 指向 GitHub，ref=main） | 已添加 |
| 插件 | `codex plugin list` 里 `flutter-riverpod-foundation@flutter-riverpod-foundation` 显示 `installed, enabled`，版本 `0.1.0` | 已启用 |
| 插件缓存 | `~/.codex/plugins/cache/flutter-riverpod-foundation/flutter-riverpod-foundation/0.1.0/skills/flutter_riverpod_foundation/SKILL.md` | 已下载 |
| 个人级 skill | `~/.codex/skills/flutter-riverpod-foundation/SKILL.md` | 已存在 |
| 项目级 skill | `/Users/isurpass/Desktop/Demo/.codex/skills/flutter_riverpod_foundation/SKILL.md` | 本次已随项目复制 |
