@echo off
chcp 65001 >nul
REM ============================================================
REM  启动IMA代理.bat —— 英语单词速记 本地代理（IMA 同步 / 新单词微软配音用）
REM  双击即可：启动 Node 代理服务器 + 自动打开浏览器本页面
REM  原理：浏览器对 localhost 绕过系统代理，故不受 360 劫持影响
REM  依赖：需已安装 Node.js（https://nodejs.org）；TTS 还需 pip install edge_tts
REM ============================================================
set "SCRIPT=%~dp0ima-proxy-server.js"

if not exist "%SCRIPT%" (
  echo [错误] 未找到 %SCRIPT%
  echo 请确认 ima-proxy-server.js 与本 bat 在同一目录。
  pause
  exit /b 1
)

REM 优先用 PATH 中的 node，其次用 WorkBuddy 托管 node，最后提示安装
set "NODE="
where node >nul 2>nul && set "NODE=node.exe"
if not defined NODE (
  if exist "C:\Users\lenovo\.workbuddy\binaries\node\versions\22.22.2\node.exe" (
    set "NODE=C:\Users\lenovo\.workbuddy\binaries\node\versions\22.22.2\node.exe"
  )
)
if not defined NODE (
  echo [错误] 未检测到 Node.js。请先安装 Node.js (https://nodejs.org) 后再运行本工具。
  pause
  exit /b 1
)

echo 正在启动本地代理服务器（需 Node.js）...
echo.
"%NODE%" "%SCRIPT%" 8137
echo.
echo 服务器已停止。按任意键退出...
pause >nul
