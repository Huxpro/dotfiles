# Personal Principles (Huxpro)

## Engineering Principles — Learned from mistakes, to be refined over time

### 1. 说不清解决什么问题的改动，就不该做
- 来源：vue-lynx 迁移时，把 `path.resolve(__dirname, '../..')` 改成 `require.resolve('vue-lynx/package.json')`，理由是"对齐上游更 robust"。实际上原代码没有 bug，改动反而引入了新 bug（pnpm 不为 workspace 根包创建自引用 symlink）。
- 教训：如果不能指出一个**具体的、可复现的问题**，就不要改。"更 robust"、"更标准"不是理由。

### 2. 不要机械搬运上游模式，先验证前提条件
- 来源：同上。lynx-stack 用 `require.resolve('@lynx-js/vue-main-thread/package.json')` 是因为那是独立包、有 symlink。vue-lynx 是单包架构、根包没有 symlink。前提不同，模式不适用。
- 教训：每次搬运模式时，问"这个模式依赖什么前提？我的环境满足吗？"

### 3. 看到报错不能凭直觉归类为 "pre-existing"
- 来源：迁移验证时 `examples/basic` build 报错（css-extract-webpack-plugin CJS/ESM 冲突），我假设是"已有问题"没追查。实际上就是迁移引入的 bug。
- 教训：对任何报错，先 `git stash` 回到改动前确认是否也报错，再判断是否 pre-existing。

### 4. 编译通过 ≠ 能用，必须端到端验证
- 来源：`pnpm build` + `pnpm test` 全绿，但 example build 失败。单元测试不走 plugin 打包产物的运行时路径。
- 教训：迁移/重构类改动，验证清单必须包含"从用户视角走完整链路"（build example、npm pack、实际运行）。
