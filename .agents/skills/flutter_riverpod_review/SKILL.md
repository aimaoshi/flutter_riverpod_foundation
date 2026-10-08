---
name: flutter_riverpod_review
description: 本仓库（Keemple Flutter Foundation）的代码审查清单：分层边界、Riverpod 用法、GoRouter 骨架、九语言 i18n、Dio 网络与日志脱敏、存储、资源、部件性能、测试与静态分析。用于 review diff / PR、合并前自检，或核对改动是否符合本仓库约定；只用于审查已有改动，不用于编写新功能。
---

# Keemple Flutter Foundation 代码审查清单

审查本仓库的改动时逐条核对。约定以 `flutter_riverpod_foundation` 技能和当前代码为准，
本清单只解决「怎么判断这次改动合不合规」。

先看 diff 落在哪一层，再决定用下面哪几节。

## 1. 分层与目录

- [ ] 改动落在正确的层：页面在 `features/`，跨层契约在 `domain/`，DTO 与数据源在 `data/`，基础设施在 `core/`，可复用 UI 与 i18n 在 `shared/`
- [ ] `core/` 里没有出现页面、功能控制器或业务模型
- [ ] widget 没有直接消费 `Map<String, Object?>` 这类原始服务端结构，DTO 转换留在 `data/remote` 或 repository
- [ ] 只被单个 feature 使用的模型留在该 feature 内，没有为它提前建 `domain/`
- [ ] 新 feature 从 `features/<feature>/<feature>_page.dart` + `<feature>_provider.dart` 起步，状态没有塞进页面
- [ ] `data/local/` 尚未建立；一旦需要特征级本地数据库，是新增而非把数据硬塞进 `AppStorage`

## 2. Riverpod

- [ ] 状态通过 Provider 暴露，页面用 `ref.watch` 或 `ConsumerWidget` 读取，没有绕过 Provider 自行构造
- [ ] 依赖经 `ref` 注入，Notifier 内部没有直接 `Dio()` 或 `SharedPreferences.getInstance()`
- [ ] 副作用走 `ref.listen` 或显式事件方法，`build()` 里没有触发写操作
- [ ] 异步状态用 `AsyncValue`（`when` / `maybeWhen`）表达加载、成功、错误，没有用 `isLoading` + `isError` 布尔组合
- [ ] 生命周期匹配：页面级临时状态用 `autoDispose`，全局单例保持不销毁，没有无谓的 `keepAlive`
- [ ] Provider 返回不可变对象（`@immutable` + `const` 构造），没有把可变集合直接交给 UI
- [ ] 除测试外没有手动 `ProviderContainer()`
- [ ] 没有跨 feature 直接 import 另一个 feature 的 provider；需要共享时提升到 `domain/` 或 `shared/`

## 3. 路由与应用骨架

- [ ] 路由只在 `lib/app/router/app_router.dart` 定义，路径取自 `AppRoutes` 常量，没有散落的字符串字面量
- [ ] 一级页面挂在 `StatefulShellRoute.indexedStack` 的 branch 内，顺序与底部导航一致
- [ ] 新增或重排 Tab 时，branch 列表、`MainShellPage` 的 destinations、i18n 标签在同一次改动内对齐
- [ ] Tab 切换仍走 `navigationShell.goBranch(index, initialLocation: index == currentIndex)`
- [ ] 壳外页面（如 `/network-test`）以 push 方式盖在 tab bar 之上，没有被塞进 branch
- [ ] 应用仍落在主界面，没有被改成停在测试页或空白页
- [ ] `SplashPage` 只做交接，没有夹带业务初始化

## 4. 国际化（9 个语言文件）

语言文件为 `locale_en / fr / he / ja / pl / vi / zh / zh_HK / zh_TW`，共 9 个。

- [ ] 每个新增可见文案在 `LocaleKeys` 里有条目，key 名为 snake_case，值为 `keemple_txt_` 前缀
- [ ] 同一个 key 在**全部 9 个语言文件**里都有值——缺翻译不会被任何工具发现
- [ ] 页面通过 `context.tr(LocaleKeys.xxx)` 取文案，没有硬编码字符串
- [ ] 没有用字符串拼接组装句子，占位符走参数化消息
- [ ] 语言选项列表属于 i18n 配置，没有写进页面或 bootstrap
- [ ] 新增语言时同步登记到 locale 列表与 `LocaleController`
- [ ] 改动布局时检查了 RTL 语言（`he`）的镜像表现

## 5. 网络层与日志

通行链路：`Widget → Notifier → Repository → RemoteDataSource → ApiClient → Dio`

- [ ] 调用链没有跳层：widget 不直接调 `ApiClient`，repository 不自行创建 `Dio`
- [ ] `ApiClient` 仍通过 `dioProvider` 取得 Dio，没有创建全局实例
- [ ] 旧接口用 `postForm`（`application/x-www-form-urlencoded`），只有明确的 JSON 契约才用 `postJson`
- [ ] 返回体经 `ApiResponse` 解析，同时兼容 `{resultCode, data}` 信封与根级结果对象
- [ ] 网络异常被转换成 `ApiException`，UI 拿到的是可展示文案，而不是原始异常字符串
- [ ] 每个完成的请求只打印一帧日志，格式为「请求url / 参数 / 返回结果」
- [ ] 日志中 `password`、`logincookie` 与 token 类字段已脱敏
- [ ] `network_config.dart` 只保留占位地址，没有提交真实服务域名
- [ ] 没有硬编码、持久化或打印测试凭证、cookie、token

## 6. 启动与存储

- [ ] `AppBootstrap` 只初始化启动依赖并提供 Provider override，没有承载功能选项、API 调用或可变用户数据
- [ ] `AppStorage` 只用于小设置与开关
- [ ] 设备、业务集合等数据没有塞进 `AppStorage`
- [ ] 读写存储的行为有对应测试（参考 `test/core/storage/app_storage_test.dart`）

## 7. 资源与样式

- [ ] 图片放在 `assets/images/`，并在 `pubspec.yaml` 里按目录注册
- [ ] 代码通过 `lib/assets.dart` 的常量引用资源，没有内联路径字符串
- [ ] 颜色、文字样式、间距取自 `shared/ui/style/` 的设计令牌，没有硬编码色值与魔法数字
- [ ] 大图已缩放，原始大图没有被打包
- [ ] 布局使用 `context.layout`，没有引入全局 context 单例；legacy 兼容方法保持可用

## 8. 部件与性能

- [ ] `build()` 没有膨胀到难以阅读；可复用的私有 `_buildXxx()` 已提取为独立部件类
- [ ] 能加 `const` 的构造器都加了
- [ ] 列表 / 网格项有 `ValueKey` 或 `ObjectKey`，重排时能保留状态；`build()` 里没有生成 `UniqueKey`
- [ ] `build()` 中没有网络请求、文件 I/O、`Future.then`、订阅创建或大集合排序过滤
- [ ] 局部状态变化没有在根部件级别触发重建
- [ ] `await` 之后使用 `context` 前检查了 `mounted` / `context.mounted`
- [ ] 长列表使用 `ListView.builder`，网络图片走 `cached_network_image` 并设置合理解码尺寸
- [ ] 未实现的页签使用 `FeaturePlaceholder` 配 i18n 文案，而不是手写空状态

## 9. 测试

- [ ] 新增的解析、存储、状态或 UI 行为有对应测试，落在 `test/` 的对应目录下
- [ ] 状态转换被覆盖：加载 → 成功、加载 → 错误、重试
- [ ] 外部依赖（Dio、SharedPreferences）已替换为 fake / mock，测试不依赖真实网络
- [ ] widget 测试用 `pump` / `pumpAndSettle` 正确处理异步，没有依赖时序碰运气
- [ ] 断言针对可观察行为，而非实现细节
- [ ] 测试之间没有共享的可变状态
- [ ] `flutter test` 通过

## 10. 格式与静态分析

- [ ] `dart format` 只作用于本次改动的 Dart 文件，没有整仓重排产生噪音 diff
- [ ] `flutter analyze` 没有新增 error；新增的 info / warning 有说明
- [ ] 使用 `// ignore:` 抑制规则时写了理由
- [ ] `analysis_options.yaml` 仍为 `flutter_lints` 默认集；放宽或收紧 lint 属于需要单独说明的决策
- [ ] 生成文件（`.g.dart` / `.freezed.dart`）与源码同步，或已被正确忽略

## 11. 安全

- [ ] 仓库中没有真实密钥、token、cookie 或账号密码
- [ ] 敏感数据既没有进日志，也没有明文进 `AppStorage`
- [ ] 深链与路由参数在用于导航前经过校验
- [ ] 新增权限在 `AndroidManifest.xml` 与 `Info.plist` 两侧同步处理

## 12. 本仓库快速对照

| 关注点 | 本仓库的写法 | 常见违规 |
| --- | --- | --- |
| 状态 | `flutter_riverpod` 的 Provider / Notifier | 引入 GetX、静态服务定位器 |
| 导航 | `go_router` + `StatefulShellRoute` + `AppRoutes` | 到处 `Navigator.push`、硬编码路径 |
| 启动 | `AppBootstrap` 只做启动依赖与 override | 把业务初始化塞进 bootstrap |
| 存储 | `AppStorage`（小设置与开关） | 用 AppStorage 存业务集合 |
| 网络 | `ApiClient` ← `dioProvider` ← Dio | 自建 Dio、跳过 repository |
| 请求格式 | 旧接口 `postForm`，JSON 用 `postJson` | 旧接口误用 JSON |
| 文案 | `LocaleKeys` + 9 个 locale 文件 + `context.tr` | 页面硬编码、漏翻译 |
| 资源 | `assets/images/` + `lib/assets.dart` 常量 | 内联路径、打包大图 |
| 布局 | `context.layout` | 全局 context 单例 |
| 上下文 | `BuildContext` 只活在 build 与回调里 | 存进单例或静态字段 |

## 13. 输出审查结论的要求

- [ ] 每条问题都能指到具体文件与行，并说明它违反了上面哪一条
- [ ] 区分「违反本仓库约定」与「个人偏好」，后者不作为问题提出
- [ ] 按严重度排序：崩溃或凭据泄漏 > 破坏分层、路由、网络约定 > 一致性与可读性
- [ ] 没有新引入的可测试缺陷时，直接说明「未发现阻断项」，不为凑数编问题
