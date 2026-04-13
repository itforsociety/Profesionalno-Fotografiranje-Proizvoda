param(
  [string]$OutDir = "assets/images",
  [string]$Model = "sdxl"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
}

$images = @(
  @{ File = "hero-cosmetics.jpg"; Prompt = "ultra realistic commercial packshot, premium skincare bottle and box, centered composition, neutral seamless studio backdrop, clean softbox lighting, physically accurate shadows, high detail glass reflections, 85mm product lens look, not illustration, not painting, no text, no logo, no watermark"; Seed = 71011 },
  @{ File = "gallery-watch.jpg"; Prompt = "ultra realistic studio product photo of luxury wristwatch, polished steel bracelet, acrylic stand, controlled rim lighting, dark gradient backdrop, macro sharpness, true-to-life materials, not illustration, not painting, no text, no watermark"; Seed = 72021 },
  @{ File = "gallery-headphones.jpg"; Prompt = "ultra realistic ecommerce packshot of modern over-ear wireless headphones, isolated on white seamless background, balanced soft studio light, realistic shadow below product, crisp edges, not illustration, not painting, no text, no watermark"; Seed = 73031 },
  @{ File = "gallery-skincare.jpg"; Prompt = "ultra realistic beauty product photography, three cosmetic pump bottles on stone pedestal, clean minimal set design, soft diffused studio light, premium campaign quality, natural reflections, not illustration, not painting, no text, no watermark"; Seed = 74041 },
  @{ File = "gallery-coffee.jpg"; Prompt = "ultra realistic product photo of specialty coffee bag with cup and beans, premium packaging focus, warm studio light, clean tabletop styling, high detail texture, not illustration, not painting, no text, no watermark"; Seed = 75051 }
)

$fallbackModels = @($Model, "sdxl", "flux", "turbo") | Select-Object -Unique

foreach ($img in $images) {
  $target = Join-Path $OutDir $img.File
  $saved = $false

  foreach ($candidateModel in $fallbackModels) {
    for ($attempt = 0; $attempt -lt 2; $attempt++) {
      $seed = $img.Seed + ($attempt * 13)
      $uPrompt = [uri]::EscapeDataString($img.Prompt)
      $url = "https://image.pollinations.ai/prompt/$uPrompt?model=$candidateModel&width=1400&height=1400&seed=$seed&nologo=true"

      try {
        Invoke-WebRequest -Uri $url -Headers @{ "Accept" = "image/jpeg" } -OutFile $target
        $size = (Get-Item $target).Length
        if ($size -gt 60000) {
          Write-Host "Saved $($img.File) with model=$candidateModel seed=$seed size=$size"
          $saved = $true
          break
        }
      } catch {
        Write-Host "Retrying $($img.File) model=$candidateModel seed=$seed"
      }
    }

    if ($saved) {
      break
    }
  }

  if (-not $saved) {
    throw "Failed to generate image: $($img.File)"
  }
}

Write-Host "AI image generation complete."
Get-ChildItem $OutDir | Select-Object Name, Length
