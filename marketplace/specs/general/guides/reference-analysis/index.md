# Reference Analysis — 参考项目能力分析

> 从优秀开源项目中提炼可借鉴的设计模式和实现方案。取其精华去其糟粕。

## 使用方式

- **调研阶段**：research subagent 调研某个能力域时，发现写入对应域文件
- **brainstorm 阶段**：讨论设计决策时参考对应域的分析，了解各项目怎么做的、我们当前是什么状态
- **实现阶段**：implement subagent 通过 jsonl 注入获得相关域的参考
- **完成阶段**：Phase 3.3 更新"当前状态"反映新实现的能力，追加新的参考发现

## 域文件索引

<!-- Fill in your project's capability domains -->
| 域 | 文件 | 覆盖内容 | 注入时机 |
|----|------|---------|---------|
| _example_ | [example.md](./example.md) | _description_ | _when to inject_ |

## 项目概览

<!-- Add your own project as the first row -->
| 项目 | 定位 | 路径 | 说明 |
|------|------|------|------|
| **YOUR_PROJECT** | _your positioning_ | `src/` | 每个域文件的"当前状态"记录实现进度 |
| _reference-project_ | _positioning_ | `reference/example` | _key value_ |

## 域文件结构

每个域文件统一四个章节：

```
## 当前状态（YOUR_PROJECT）      ← 我们有什么、什么阶段
## 参考项目分析                   ← 各项目在该域的优点和缺点
## 借鉴方案                      ← 已实现 + 待实现
## 实现参考                      ← file:line 指向具体代码
```

## 维护规则

1. **调研阶段**更新"参考项目分析"和"实现参考"
2. **Phase 3.3**更新"当前状态"和"借鉴方案"（task 完成后同步新实现的能力）
3. 新 task 的调研发现按域追加，不覆盖已有内容
4. 依赖库的详细能力清单在 `spec/deps/`，这里只放概要和借鉴点
5. 控制每个域文件在 200 行以内，超出则拆分子域
