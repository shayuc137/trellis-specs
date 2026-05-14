# Reference Analysis — 参考项目能力分析

> 从优秀开源项目中提炼可借鉴的设计模式和实现方案。取其精华去其糟粕。

## 使用方式

- **调研阶段**：research subagent 调研某个能力域时，发现写入对应域文件
- **brainstorm 阶段**：讨论设计决策时参考对应域的分析，了解各项目怎么做的
- **实现阶段**：implement subagent 通过 jsonl 注入获得相关域的参考
- **完成阶段**：Phase 3.3 检查本次 task 是否有新的参考发现需要追加

## 域文件索引

<!-- Fill in your project's capability domains -->
| 域 | 文件 | 覆盖内容 | 注入时机 |
|----|------|---------|---------|
| _example_ | [example.md](./example.md) | _description_ | _when to inject_ |

## 参考项目概览

<!-- Fill in your reference projects -->
| 项目 | 定位 | reference 路径 | 主要参考价值 |
|------|------|---------------|------------|
| _example_ | _positioning_ | `reference/example` | _key value_ |

## 维护规则

1. 每个域文件记录：各项目在该域的**优点和缺点** → 我们的**借鉴方案** → **实现参考**（file:line）
2. 新 task 的调研发现按域追加到对应文件，不是覆盖
3. 依赖库的详细能力清单在 `spec/deps/`，这里只放概要和借鉴点
4. 控制每个域文件在 200 行以内，超出则拆分子域
