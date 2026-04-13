param(
  [string]$OutDir = "assets/images"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
}

$images = @(
  @{ File = "hero-cosmetics.jpg"; Prompt = "luxury skincare product photography on warm neutral set, softbox lighting, high-end commercial studio, ultra detailed"; Seed = 1101 },
  @{ File = "gallery-watch.jpg"; Prompt = "premium wrist watch product photo in studio, dramatic side lighting, commercial style, high detail"; Seed = 2202 },
  @{ File = "gallery-headphones.jpg"; Prompt = "wireless headphones product photography with clean background, modern commercial ad style, high detail"; Seed = 3303 },
  @{ File = "gallery-skincare.jpg"; Prompt = "minimal skincare bottles arranged on stone props, editorial product photography, commercial quality"; Seed = 4404 },
  @{ File = "gallery-coffee.jpg"; Prompt = "specialty coffee bag and beans product photograph, warm cinematic lighting, ecommerce commercial shot"; Seed = 5505 }
)

foreach ($img in $images) {
  $uPrompt = [uri]::EscapeDataString($img.Prompt)
  $url = "https://image.pollinations.ai/prompt/$uPrompt?model=flux&width=1400&height=1400&seed=$($img.Seed)&nologo=true"
  $target = Join-Path $OutDir $img.File
  Invoke-WebRequest -Uri $url -Headers @{ "Accept" = "image/jpeg" } -OutFile $target
}

Write-Host "AI image generation complete."
Get-ChildItem $OutDir | Select-Object Name, Length
