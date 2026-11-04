# GVHMR 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md
# 更新日期：2026-11-04
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/zju3dv/GVHMR.git
Set-Location GVHMR
pip install -r requirements.txt
pip install -e .
python -c "import gvhmr; print(gvhmr.__file__)"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/zju3dv/GVHMR/blob/main/docs/INSTALL.md'
