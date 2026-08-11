---
name: english-word-memory-video
version: "2.0"
description: 输入英语单词，自动生成音形义记忆动画+真人配音速记视频，一键下载MP4。纯前端单HTML，双击即用。
author: 京灵智创
license: MIT
tags: [英语, 单词, 视频, TTS, 教育, 记忆, Canvas, WebCodecs]
trigger:
  - "英语单词视频"
  - "单词速记"
  - "word memory video"
  - "english word video"
---

# 英语单词速记视频生成器 v2.0

输入任意英语单词 → LLM 智能拆词 + Canvas 三段式动画 + 微软真人配音 → 一键下载 MP4 速记视频。

## 使用方式

### 触发条件
用户要求生成英语单词的速记视频/动画/记忆卡片时使用本技能。

### 文件结构
```
english-word-memory-video/
├── 英语单词速记视频.html    # 主程序（单文件 HTML，双击即用）
├── ima-proxy-server.js      # Node.js 代理（TTS + IMA 转发）
├── 启动IMA代理.bat          # 一键启动代理
└── README.md                # 用户使用指南
```

### 核心流程
1. **双击 `英语单词速记视频.html`** 打开
2. 输入单词 → 点「生成」→ LLM 拆词（或内置规则）
3. 点「播放」预览动画+配音 → 点「下载视频」保存 MP4

### TTS 优先级链
1. **预嵌音频**（73 个内置词，零网络）→ 2. **代理 TTS**（Edge TTS via Node）→ 3. **Edge TTS 直连**（可能被拦截）→ 4. **DashScope**（需 Key）→ 5. **浏览器原生**（speechSynthesis）

### 新单词视频录制策略
- 有代理：WebCodecs 直接合成（最佳，无需屏幕共享）
- 无代理：getDisplayMedia 屏幕捕获（需用户选标签页/窗口 + 勾选音频）
- 检测打开方式智能引导（file:// 选标签页 / localhost 选窗口或整个屏幕）

## 技术要点

### 敏感信息处理
- `defaultConfig()` 中所有 API Key / IMA 凭证必须为空字符串
- 分发前必须 grep 确认无残留 Key：`sk-`、`ima_client_id`、`ima_api_key`
- 用户首次使用在设置面板自行填入

### 浏览器兼容性
- Chrome 90+ / Edge 90+（需要 WebCodecs API）
- getDisplayMedia 需要 HTTPS 或 localhost/file://（CORS 限制）
- 360 安全浏览器：localhost 页面不在标签页列表中 → 引导选「整个屏幕」

### 已知坑与解决方案
1. **录屏只抓到一帧**：Chrome 节流被捕获标签页的 rAF → 用 setInterval 强制重绘
2. **await 在非 async 函数**：playAnim 加了 await 但忘了声明 async → 整个 JS 崩溃
3. **hasEmbedded 误判**：检查对象存在 vs 检查当前词有数据 → 必须查具体 key
4. **双 resolve Promise**：ttsBrowserNative finish 里调两次 resolve → PCM 数据丢失
5. **Edge TTS 超时**：被 360 拦截 wss → 从 30s 缩到 8s 快速失败

### 内置词库（73 个预嵌配音词）
aftermath, anticipate, atmosphere, attribute, capacity, category, challenge, commercial, community, compensate, complex, comprehensive, concentrate, concept, conduct, consequence, conserve, constitute, construct, consume, contemporary, context, contrast, controversy, convene, coordinate, corporate, correspond, criterion, dedicate, demonstrate, derive, device, differentiate, dimension, dilemma, domestic, dominate, elaborate, elementary, eliminate, emerge, emphasis, ensure, enterprise, environment, equivalent, establish, evaluate, evidence, exceed, exclude, experiment, explicit, exploit, facilitate, foundation, fundamental, generate, hierarchy, hypothesis, illustrate, implicit, incentive, incorporate, indicate, initial, instance, inevitable, infrastructure, innovate, integral, integrity, intelligent, intense, interact, invest

## 依赖
- 运行时：零依赖（纯浏览器）
- 可选代理：Node.js + Python edge_tts（启动IMA代理.bat 自动管理）
- 可选 LLM：DeepSeek / DashScope / OpenAI 兼容 API
