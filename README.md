# GVHMR 一键部署指南

> 第三方部署指南 · 非 GVHMR 官方仓库。官方项目：[zju3dv/GVHMR](https://github.com/zju3dv/GVHMR)
> 内容来自官方文档（2026-11-04）。项目迭代快，请以[官方文档](https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 研究型项目：需要 Python 3.10 与 PyTorch，训练用了 2×4090，实际推理也建议 NVIDIA GPU。SMPL / SMPL-X 权重必须自行注册申请，预训练权重在 Google Drive。许可证禁止商用，修改后必须开源。没有网页界面。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/gvhmr-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会克隆仓库、建好 Python 依赖并验证模块可导入，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## GVHMR 是什么？

GVHMR 是开源的用重力-视角坐标从单目视频恢复世界坐标系下的人体动作（协议：非商用学术许可（禁止商用），<img src="https://img.shields.io/github/stars/zju3dv/GVHMR?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

从单目视频恢复世界坐标系下的人体动作：先估计相机运动，再用重力-视角坐标预测全局轨迹，输出 SMPL-X 参数与可渲染的动作序列。

- SIGGRAPH Asia 2024 论文实现
- 单目视频即可恢复世界坐标动作
- 默认用 SimpleVO，比 DPVO 快
- 支持整目录批量推理
- 提供 HuggingFace 与 Colab 演示
- 2252 stars

（来源：[官方仓库](https://github.com/zju3dv/GVHMR)）

## 优缺点

| 优点 | 说明 |
|---|---|
| SIGGRAPH Asia 2024 成果，方法新 | — |
| 单目就能拿世界坐标轨迹 | — |
| 默认 SimpleVO | 比 DPVO 快 |
| 支持批量目录推理 | — |
| 有在线 demo 可先试效果 | — |
| 2252 stars | — |

| 需要注意 | 说明 |
|---|---|
| 禁止商用 | — |
| 权重需自行注册下载 | — |
| 依赖较重 | 装环境费时 |
| 推理建议 NVIDIA GPU | — |
| 没有图形界面 | — |
| 对输入视频质量敏感 | — |

> 以上基于官方文档与社区反馈整理（2026-11-04），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/zju3dv/GVHMR.git
cd GVHMR
pip install -r requirements.txt
pip install -e .
python -c "import gvhmr; print(gvhmr.__file__)"
```

部署步骤来源：[https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md](https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md)

## 验证状态

| 场景 | 状态 |
|---|---|
| INSTALL 确认依赖、权重目录结构与 demo 命令 | 已核对 2026-11-04 |
| LICENSE 确认为非商用学术许可 | 已核对 2026-11-04 |
| 未实测环境安装、权重下载与推理 | 说明 2026-11-04 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-04 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-04 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不带 MCP；本仓库的 MCP server 提供环境安装、权重放置与 demo 命令说明。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-04）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\gvhmr-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 跑 demo

```bash
python tools/demo/demo.py --video=docs/example_video/tennis.mp4 -s
```

`-s` 表示跳过视觉里程计，适合固定机位；移动机位去掉 `-s`。整目录推理：

```bash
python tools/demo/demo_folder.py -f inputs/demo/folder_in -d outputs/demo/folder_out -s
```

## 权重放置

```text
inputs/checkpoints/
├── body_models/smplx/SMPLX_{GENDER}.npz
├── body_models/smpl/SMPL_{GENDER}.pkl
├── gvhmr/gvhmr_siga24_release.ckpt
├── hmr2/epoch=10-step=25000.ckpt
├── vitpose/vitpose-h-multi-coco.pth
└── yolo/yolov8x.pt
```

SMPL 与 SMPL-X 需在官网注册后下载，其余权重在官方 Google Drive 链接里。

## 注意

- 许可证只允许教育、研究与非营利用途
- 基于本项目的修改必须开源
- 没有权重时 demo 会直接退出
- 移动机位不跳 VO，显存占用更高
- Apple Silicon 上需要自行处理 CUDA 依赖

## 常见坑

- 缺权重报错：按 INSTALL 的目录结构放齐 5 组文件
- SMPL 下载失败：需先在官网注册账号并同意许可
- torch 版本冲突：按 requirements 指定版本新建环境
- CUDA 不可用：确认驱动与 torch 的 CUDA 版本匹配
- 显存不足：改用 `-s` 或降低分辨率
- 输出抖动：固定机位务必加 `-s`
- pip install -e . 失败：确认 Python 3.10，且先装 requirements

## 免责声明

本仓库为第三方指南，与 GVHMR 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-04），项目迭代快，请以[官方文档](https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
