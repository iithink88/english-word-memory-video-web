# 英语单词速记视频生成器

> 输入任意英语单词，自动生成**音形义记忆动画** + **真人配音速记视频**，一键下载 MP4。
> **真正单文件网页**：一个 `.html` 包含全部功能，双击即用；可选的本地代理工具已内嵌，可在设置里一键导出。无需安装任何软件即可基础使用。

> ⚠️ **下载视频重要提示（必读）**：点「下载视频」后浏览器会弹出**屏幕共享窗口**，请务必做到两点，否则视频会**没有声音或没有画面**：
> 1. 选择 **「整个屏幕」**（或当前窗口）进行**录制**；
> 2. 在弹窗底部 **勾选「同时分享系统音频 / 分享声音」**；
> 3. 点「共享 / 分享」后**保持页面不动**，等待录制自动结束，即可得到**有画面、有声音**的 MP4。
> 若没有勾选声音，生成的视频将**只有画面没有声音**；若选错来源，可能录不到画面。

## 功能一览

| 功能 | 说明 |
|---|---|
| **智能拆词** | LLM 将单词拆成音节/词根 + 中文释义 + 联想记忆笔记 |
| **三段式动画** | 开场（单词+音标）→ 展开（音节拆解）→ 收尾（联想笔记），Canvas 逐帧绘制 |
| **真人配音** | 微软 Edge TTS（AriaNeural 英文 + XiaoxiaoNeural 中文），73 个内置词预嵌离线音频 |
| **视频下载** | WebCodecs 直接合成 MP4（内置词）或 屏幕捕获录制（新单词） |
| **IMA 同步** | 可选同步到腾讯 IMA 知识库（需代理） |

## 快速开始（3 步）

### 方式一：基础使用（无需任何 Key）

1. **双击 `英语单词速记视频.html`** 用浏览器打开
2. 在输入框输入单词（如 `happy`、`economy`），点 **「生成」**
3. 点 **「播放」** 看动画听配音 → 点 **「下载视频」** 保存 MP4

> 内置 73 个常用词（aftermath/economy/information 等），这些词有预嵌的微软真人配音，**离线即可用**。

### 方式二：新单词 + 微软真人配音（推荐）

1. 打开 **`英语单词速记视频.html`** → 点右上角 **⚙️ 设置**
2. 在「🎙️ 本地 TTS 代理」区点 **📦 下载本地代理工具**（或直接使用同目录已有的 `启动IMA代理.bat`）
3. 双击导出的 **`启动IMA代理.bat`** 启动本地代理（提供 TTS 服务）
4. 刷新页面，输入任意新单词，点 **「生成」** → **「下载视频」**
5. 视频自动使用微软真人语音合成，**不需要屏幕共享**

### 方式三：配置 LLM 拆词（更智能的拆词结果）

1. 点右上角 **⚙️ 设置**
2. 填入 API Key（支持 DeepSeek / 阿里百炼 DashScope / OpenAI 兼容接口）
3. 点 **「测试连接」** 验证 → 点 **「保存」**
4. 之后输入新单词会调用 LLM 拆词（不配 Key 则用内置规则拆词）

## 文件说明

```
英语单词速记视频生成器_分享版/
├── 英语单词速记视频.html    ← 主程序（真正单文件，双击这个打开即可）
├── ima-proxy-server.js      ← 本地代理服务器（TTS + IMA 转发，已内嵌于 HTML，可一键导出）
├── 启动IMA代理.bat          ← 一键启动代理（可选，同内嵌）
├── README.md                ← 本说明文件
└── SKILL.md                 ← WorkBuddy 技能定义
```

> **真正单文件**：`英语单词速记视频.html` 本身已包含全部功能与代理工具的源码。
> 基础使用（内置 73 词离线配音 + 新单词系统语音录制）完全不需要任何外部文件。
> 想在「设置」里点 **📦 下载本地代理工具** 即可把 `ima-proxy-server.js` 和 `启动IMA代理.bat` 导出到本地，用于微软真人配音 / IMA 同步增强。

## 新单词下载视频的操作提示

新单词（不在 73 个内置词中）下载视频时，浏览器会弹出**屏幕共享窗口**。**无论用哪种方式打开页面，统一按下面操作：**

| 步骤 | 操作 | 说明 |
|---|---|---|
| ① 选来源 | 选 **「整个屏幕」**（推荐）或当前应用窗口 | 不要选「标签页」（本地网页在标签页列表里找不到） |
| ② 勾声音 | 在弹窗底部 **勾选「同时分享系统音频 / 分享声音」** | ⚠️ 不勾则视频**没声音** |
| ③ 开始 | 点 **「共享 / 分享」** | 录制自动开始 |
| ④ 等待 | **保持本页面在最前、不要切换标签页** | 录制会在动画播完约 1 秒后**自动结束** |

| 打开方式 | 结果 |
|---|---|
| **双击 HTML（file://）** | 选「整个屏幕」+ 勾声音 → ✅ 有画面有声（系统语音） |
| **通过代理打开（http://127.0.0.1:...）** | 选「整个屏幕」+ 勾声音 → ✅ 有画面有声 |
| **已启动代理（推荐）** | 不弹窗，直接 WebCodecs 合成 → ✅ 微软真人语音（最佳效果，无需屏幕共享） |

## 内置词列表（73 个，有预嵌真人配音）

aftermath, anticipate, atmosphere, attribute, capacity, category, challenge, commercial, community, compensate, complex, comprehensive, concentrate, concept, conduct, consequence, conserve, constitute, construct, consume, contemporary, context, contrast, controversy, convene, coordinate, corporate, correspond, criterion, dedicate, demonstrate, derive, device, differentiate, dimension, dilemma, domestic, dominate, elaborate, elementary, eliminate, emerge, emphasis, ensure, enterprise, environment, equivalent, establish, evaluate, evidence, exceed, exclude, experiment, explicit, exploit, facilitate, foundation, fundamental, generate, hierarchy, hypothesis, illustrate, implicit, incentive, incorporate, indicate, initial, instance, inevitable, infrastructure, innovate, integral, integrity, intelligent, intense, interact, invest

## 技术架构

- **前端**：纯 HTML/CSS/JS 单文件，无框架依赖
- **动画**：Canvas 2D 三段式逐帧绘制（开场→展开→收尾）
- **TTS 优先级**：预嵌音频 → 代理 TTS（Edge TTS）→ DashScope → 浏览器原生 → 静音兜底
- **视频编码**：WebCodecs（内置词/有代理时）或 MediaRecorder + getDisplayMedia（屏幕捕获）
- **LLM 拆词**：兼容 OpenAI API 格式（DeepSeek / DashScope / 其他）
- **IMA 同步**：通过本地代理转发（解决 CORS）

## 环境要求

- 浏览器：Chrome 90+ / Edge 90+ / 360 安全浏览器（需要支持 WebCodecs / getDisplayMedia）
- Node.js：仅启动代理时需要（bat 已内嵌路径）
- Python + edge_tts：仅代理 TTS 需要（bat 自动调用）
- **无需安装任何东西**即可基础使用（内置词 + 系统语音）

## 注意事项

1. **首次使用**：建议先用内置词（如 `aftermath`、`economy`）测试完整流程
2. **屏幕共享录制时**：不要切换标签页，否则录到的画面会中断
3. **API Key 安全**：所有 Key 仅保存在浏览器 localStorage 中，不会上传到任何服务器
4. **离线使用**：内置 73 个词完全离线可用（预嵌音频在 HTML 中）；新单词需要网络（LLM / TTS）

## 许可证

MIT License — 自由使用、修改、分享。

---
*由 WorkBuddy english-word-memory-video 技能移植优化*
