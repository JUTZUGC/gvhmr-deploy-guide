#!/usr/bin/env bash
set -euo pipefail
# GVHMR 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md
# 更新日期：2026-11-04
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/zju3dv/GVHMR.git
cd GVHMR
pip install -r requirements.txt
pip install -e .
python -c "import gvhmr; print(gvhmr.__file__)"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md"
