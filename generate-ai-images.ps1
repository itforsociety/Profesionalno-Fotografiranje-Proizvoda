param(
  [string]$OutDir = "assets/images",
  [string]$Model = "flux"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
}

$images = @(
  @{ File = "hero-cosmetics.jpg"; Prompt = "photorealistic commercial product photo, premium skincare bottle with box, centered on matte beige seamless backdrop, pro studio softbox lighting, 85mm lens, f/11, crisp edges, natural reflections, ecommerce hero shot, no people, no hands, no text, no watermark"; Seed = 12011 },
  @{ File = "gallery-watch.jpg"; Prompt = "photorealistic studio product photography of a luxury wristwatch on acrylic stand, black to gray gradient background, controlled rim light, high contrast metal reflections, 100mm macro lens, f/13, sharp focus, no text, no logo overlay, no watermark"; Seed = 22021 },
  @{ File = "gallery-headphones.jpg"; Prompt = "photorealistic product photo of modern over-ear wireless headphones, isolated on clean white seamless backdrop, soft shadow under product, catalog style lighting, 70mm lens, f/10, ultra sharp, no people, no text, no watermark"; Seed = 33031 },
  @{ File = "gallery-skincare.jpg"; Prompt = "photorealistic beauty product photography, three skincare pump bottles arranged symmetrically on light stone pedestal, soft natural studio light, neutral background, high-end cosmetic campaign look, 90mm lens, no text, no watermark"; Seed = 44041 },
  @{ File = "gallery-coffee.jpg"; Prompt = "photorealistic product photo of specialty coffee bag and cup on textured surface, warm studio lighting, clean composition, premium packaging focus, 85mm lens, f/8, commercial ecommerce style, no people, no text, no watermark"; Seed = 55051 }
)

foreach ($img in $images) {
  $uPrompt = [uri]::EscapeDataString($img.Prompt)
  $url = "https://image.pollinations.ai/prompt/$uPrompt?model=$Model&width=1400&height=1400&seed=$($img.Seed)&nologo=true"
  $target = Join-Path $OutDir $img.File
  Invoke-WebRequest -Uri $url -Headers @{ "Accept" = "image/jpeg" } -OutFile $target
}

Write-Host "AI image generation complete."
Get-ChildItem $OutDir | Select-Object Name, Length
