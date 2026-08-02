# touhou-revealjs

A custom Quarto revealjs format: TsangerJinKai + Maple Mono typography, cream/navy palette, dotted-grid slide language, corner control buttons, practice timer, per-page PDF print footer, and a Lucide icon loader. This directory is the canonical copy; slide projects vendor it.

## Install into a slide project

Copy this folder into the project's `_extensions/` directory:

```bash
mkdir -p _extensions
cp -R ~/Documents/GitHub/personal/quarto-ext/touhou _extensions/
```

Then in `_quarto.yml` (or a document's front matter):

```yaml
format: touhou-revealjs
```

To override or extend options, use the block form; user config merges over the extension defaults:

```yaml
format:
  touhou-revealjs:
    footer: "My footer"
    include-in-header:
      - resources/_header.html
```

## Nested deck projects (workshop-style repos)

Quarto only searches for `_extensions` inside each project. If a repo hosts several decks as separate nested Quarto projects (like the `talks/2026-agentic-workshop` layout), keep one copy at `slides/_extensions/touhou/` and symlink it into each deck:

```bash
ln -s ../_extensions slides/<deck>/_extensions
```

## What's inside

- `_extension.yml`: all shared revealjs format options; asset paths resolve relative to this directory
- `touhou.scss`: the theme (fonts load from CDNs, so it is self-contained)
- `lucide.html`: Lucide icons CDN loader, re-runs `createIcons()` on slide change
- `practice-timer.html`: auto-wires `.practice-timer` elements (play/pause/reset pill + scrubber)
- `control-buttons.html`: collapsible corner deck controls (home, menu, fullscreen)
- `print-footer.html`: per-page footer for PDF export

Keep project-specific content (author, footer text, execute defaults) in the project, not here.

## Updating

Edit here first, then re-copy into projects that should pick up the change. Vendored copies are snapshots; nothing syncs automatically. If a project diverges on purpose (a variation), rename its extension folder (e.g. `_extensions/touhou-dark/`) and adjust `contributes.formats` accordingly so formats don't collide.

## Caveat

Changes to format options in `_extension.yml` are baked into each deck's `.quarto/idx` cache. If an option edit doesn't take effect, force a clean render: `rm -rf .quarto _site && quarto render`.
