# Tiny local web server for the CT Parameter Explorer (the app loads its slices with fetch(), so it needs http, not file://).
# Usage:  powershell -ExecutionPolicy Bypass -File serve.ps1            (then open http://localhost:3456/)
param([int]$Port = 3456)
$root = $PSScriptRoot
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$Port/  (Ctrl+C to stop)"
$mimeTypes = @{
  '.html' = 'text/html'
  '.js'   = 'application/javascript'
  '.json' = 'application/json'
  '.css'  = 'text/css'
  '.png'  = 'image/png'
  '.jpg'  = 'image/jpeg'
  '.gz'   = 'application/octet-stream'
}
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $res = $ctx.Response
  $path = $ctx.Request.Url.LocalPath
  if ($path -eq '/') { $path = '/index.html' }
  $file = Join-Path $root $path.TrimStart('/')
  if ((Test-Path $file -PathType Leaf) -and ((Resolve-Path $file).Path.StartsWith($root))) {
    $ext = [System.IO.Path]::GetExtension($file)
    $res.ContentType = if ($mimeTypes[$ext]) { $mimeTypes[$ext] } else { 'application/octet-stream' }
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $res.ContentLength64 = $bytes.Length
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $res.StatusCode = 404
  }
  $res.OutputStream.Close()
}
