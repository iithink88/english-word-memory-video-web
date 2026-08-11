/* ============================================================
 * ima-proxy-server.js — 英语单词速记 本地代理服务器
 * 复用「语文智能体」已验证的代理转发逻辑（零依赖，仅 Node 内置模块）
 *
 * 作用：
 *   1. 以 HTTP 方式提供本目录的 HTML（浏览器对 localhost 绕过系统代理，
 *      因此不受 360 劫持影响，可正常访问）
 *   2. /proxy/ima/*  ->  转发到 https://ima.qq.com/*（带 IMA 凭证头）
 *   3. /tts          ->  调用本地 Python edge_tts，为新单词生成微软真人配音
 *   4. /health       ->  { proxy: true }，供网页检测代理是否存在
 *
 * 用法：node ima-proxy-server.js [port]   （默认 8137）
 * ============================================================ */

const http = require("http");
const https = require("https");
const fs = require("fs");
const path = require("path");
const { exec, execSync } = require("child_process");

const PORT = parseInt(process.argv[2] || "8137", 10);
const APP_DIR = __dirname;
const INDEX_FILE = "英语单词速记视频.html"; // 默认打开的单文件版（找不到时自动选目录里的 .html）

/* 自动定位要打开的 HTML：优先 INDEX_FILE，否则取目录中第一个 .html */
function getIndexFile(){
  if(fs.existsSync(path.join(APP_DIR, INDEX_FILE))) return INDEX_FILE;
  try{
    const hs = fs.readdirSync(APP_DIR).filter(f => f.toLowerCase().endsWith(".html"));
    if(hs.length) return hs[0];
  }catch(e){}
  return INDEX_FILE;
}

/* 自动探测可用的 Python（需已安装 edge_tts）：依次尝试若干候选 */
function findPython(){
  const cands = [
    process.env.PYTHON_EXE,
    "C:\\Program Files\\Python311\\python.exe",
    "C:\\Program Files\\Python310\\python.exe",
    "C:\\Users\\lenovo\\.workbuddy\\binaries\\python\\versions\\3.13.12\\python.exe",
    "python", "python3"
  ].filter(Boolean);
  for(const c of cands){
    try{
      execSync(`"${c}" -c "import edge_tts" 2>nul`, {stdio:["ignore","ignore","ignore"], timeout:8000});
      return c;
    }catch(e){ /* 该候选不可用，试下一个 */ }
  }
  return null;
}

const MIME = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".js": "application/javascript; charset=utf-8",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
  ".ico": "image/x-icon",
  ".mp4": "video/mp4",
  ".webm": "video/webm",
  ".mp3": "audio/mpeg",
  ".wav": "audio/wav",
  ".woff": "font/woff",
  ".woff2": "font/woff2",
  ".ttf": "font/ttf",
};

function serveStatic(filePath, res) {
  // 浏览器发来的路径可能是 URL 编码的（中文文件名），需解码
  let decoded;
  try { decoded = decodeURIComponent(filePath); } catch (e) { decoded = filePath; }
  let rel = decoded === "/" ? "/" + getIndexFile() : decoded;
  const fullPath = path.join(APP_DIR, rel);
  // 防目录穿越
  if (!fullPath.startsWith(APP_DIR)) {
    res.writeHead(403, { "Content-Type": "text/plain; charset=utf-8" });
    res.end("Forbidden");
    return;
  }
  const ext = path.extname(fullPath).toLowerCase();
  fs.readFile(fullPath, (err, data) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain; charset=utf-8" });
      res.end("Not Found: " + filePath);
      return;
    }
    res.writeHead(200, {
      "Content-Type": MIME[ext] || "application/octet-stream",
      "Cache-Control": "no-cache",
      "Access-Control-Allow-Origin": "*",
    });
    res.end(data);
  });
}

function proxyRequest(targetHost, targetPath, reqHeaders, reqBody, res) {
  const tlsOpts = {
    hostname: targetHost,
    port: 443,
    path: targetPath,
    method: "POST",
    headers: {
      ...reqHeaders,
      host: targetHost,
      "Content-Type": "application/json; charset=utf-8",
      "Content-Length": Buffer.byteLength(reqBody),
    },
  };
  const proxyReq = https.request(tlsOpts, (proxyRes) => {
    const chunks = [];
    proxyRes.on("data", (chunk) => chunks.push(chunk));
    proxyRes.on("end", () => {
      const body = Buffer.concat(chunks);
      res.writeHead(proxyRes.statusCode, {
        "Content-Type": proxyRes.headers["content-type"] || "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "*",
      });
      res.end(body);
    });
  });
  proxyReq.on("error", (err) => {
    console.error("[PROXY ERROR]", err.message);
    res.writeHead(502, { "Content-Type": "application/json; charset=utf-8" });
    res.end(JSON.stringify({ error: "Proxy error: " + err.message }));
  });
  proxyReq.setTimeout(60000, () => {
    proxyReq.destroy(new Error("Gateway timeout (60s)"));
  });
  proxyReq.write(reqBody);
  proxyReq.end();
}

function handlePreflight(res) {
  res.writeHead(204, {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Headers": "*",
    "Access-Control-Max-Age": "86400",
  });
  res.end();
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://localhost:${PORT}`);
  if (req.method === "OPTIONS") return handlePreflight(res);

  // IMA 代理
  if (url.pathname.startsWith("/proxy/ima")) {
    const chunks = [];
    req.on("data", (c) => chunks.push(c));
    req.on("end", () => {
      const body = Buffer.concat(chunks);
      const apiPath = url.pathname.replace("/proxy/ima", "") || "/openapi/wiki/v1/search_knowledge_base";
      proxyRequest(
        "ima.qq.com",
        apiPath,
        {
          "ima-openapi-clientid": req.headers["ima-openapi-clientid"] || "",
          "ima-openapi-apikey": req.headers["ima-openapi-apikey"] || "",
        },
        body,
        res
      );
    });
    return;
  }

  // TTS 实时生成（用本地 Python edge_tts，为新单词提供真人配音）
  if (url.pathname === "/tts") {
    const text = url.searchParams.get("text") || "";
    const voice = url.searchParams.get("voice") || "zh-CN-XiaoxiaoNeural";
    if (!text) {
      res.writeHead(400, { "Content-Type": "application/json" });
      res.end(JSON.stringify({ error: "missing text param" }));
      return;
    }
    const PYTHON = findPython();
    if (!PYTHON) {
      res.writeHead(500, { "Content-Type": "application/json" });
      res.end(JSON.stringify({ error: "未找到可用的 Python（需安装 edge_tts：pip install edge_tts）" }));
      return;
    }
    const tmpMp3 = path.join(APP_DIR, "_tmp_tts_" + Date.now() + ".mp3");
    console.log(`[TTS] 生成: ${text.substring(0,30)}... voice=${voice}`);
    // 写临时 Python 脚本（避免 Windows 命令行中文编码/引号问题）
    const scriptContent = [
      "import asyncio, edge_tts",
      "async def main():",
      "    c = await edge_tts.Communicate(" + JSON.stringify(text) + ", " + JSON.stringify(voice) + ")",
      "    await c.save(" + JSON.stringify(tmpMp3) + ")",
      "asyncio.run(main())",
    ].join("\n");
    const tmpScript = path.join(APP_DIR, "_tmp_tts_" + Date.now() + ".py");
    fs.writeFileSync(tmpScript, scriptContent, "utf-8");
    const child = exec(`"${PYTHON}" -u "${tmpScript}"`, { timeout: 60000 }, (err, stdout, stderr) => {
      // 清理临时脚本
      try { fs.unlinkSync(tmpScript); } catch(e) {}
      if (err || !fs.existsSync(tmpMp3)) {
        console.error("[TTS FAIL]", err?.message || stderr);
        res.writeHead(500, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ error: "TTS generation failed: " + (err?.message || stderr) }));
        return;
      }
      const audioData = fs.readFileSync(tmpMp3);
      fs.unlinkSync(tmpMp3); // 清理临时文件
      res.writeHead(200, {
        "Content-Type": "audio/mpeg",
        "Access-Control-Allow-Origin": "*",
        "Cache-Control": "no-cache",
      });
      res.end(audioData);
      console.log(`[TTS OK] ${audioData.length} bytes`);
    });
    return;
  }

  // 健康检查
  if (url.pathname === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok", proxy: true }));
    return;
  }

  // 默认：静态文件服务
  serveStatic(url.pathname, res);
});

let attempts = 0;
function startServer(port) {
  server.once("error", (err) => {
    if (err.code === "EADDRINUSE" && attempts < 10) {
      attempts++;
      console.log(`[提示] 端口 ${port} 被占用，尝试端口 ${port + 1} ...`);
      startServer(port + 1);
    } else {
      console.error("[错误] 服务器启动失败:", err.message);
      process.exit(1);
    }
  });
  server.listen(port, "127.0.0.1", () => {
    const url = `http://127.0.0.1:${port}`;
    console.log("========================================");
    console.log("  英语单词速记 · 本地代理已启动");
    console.log("  " + url);
    console.log("  按 Ctrl+C 停止");
    console.log("========================================");
    const target = url + "/" + encodeURIComponent(getIndexFile());
    const cmd =
      process.platform === "win32" ? `start "" "${target}"`
      : process.platform === "darwin" ? `open "${target}"`
      : `xdg-open "${target}"`;
    exec(cmd, (err) => {
      if (err) console.log("(请手动打开浏览器访问 " + target + ")");
    });
  });
}
startServer(PORT);
