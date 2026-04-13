# Product Photography - Multilingual Static Site

This project is a free, static GitHub Pages website for a Product Photography service in:
- English
- Croatian
- Spanish
- German

## Live structure
- /en/
- /hr/
- /es/
- /de/

## Local preview
Open any of the following files in a browser:
- index.html
- en/index.html
- hr/index.html
- es/index.html
- de/index.html

## Regenerate AI images
PowerShell command:

```powershell
./generate-ai-images.ps1
```

Images are written to:
- assets/images/

## Deploy for free on GitHub Pages
1. Create a GitHub repo and push this folder to branch main.
2. In GitHub repo settings, open Pages and set Source to GitHub Actions.
3. The workflow in .github/workflows/deploy-pages.yml deploys automatically on every push to main.

## Important SEO placeholders to replace
In each language page, replace:
- https://YOUR_GITHUB_USERNAME.github.io/ProductPhotography/

With your real GitHub username and repo path.
