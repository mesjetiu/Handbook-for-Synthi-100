# Handbook for Synthi 100

Edición digital del manual **"Handbook for Synthi 100"** del antiguo Gabinete de Música Electroacústica de Cuenca, España.

Este proyecto forma parte del trabajo de investigación del grupo **Fuzzy Gab** de la Universidad de Castilla-La Mancha.

## Sobre el Synthi 100

El Synthi 100 es un sintetizador analógico modular de EMS (Electronic Music Studios), con secuenciador digital, matriz de patcheo de 7.200 puntos y 12 osciladores.

## Estructura del proyecto

```
content/              # Proyecto Markdown autocontenido (fuente única)
  ├── metadata.yaml   # Metadatos del documento
  ├── Figures/        # Imágenes y figuras escaneadas
  ├── 00-notas-edicion.md
  ├── 01-foreword.md
  ├── 02-section-1.md
  └── 03-section-2.md

build/                # Sistema de compilación
  ├── Makefile        # Makefile principal
  ├── build.sh        # Script alternativo
  ├── templates/      # Plantillas (LaTeX, CSS)
  └── filters/        # Filtros Lua para Pandoc

docs/                 # Versión web (GitHub Pages) - versionado
  └── index.html

output/               # Artefactos generados (ignorado por git)
  ├── handbook.pdf
  └── handbook-full.md

reference/            # Material de referencia
  └── Handbook for Synthi 100 (Cuenca).pdf

_legacy/              # Archivos LaTeX antiguos (solo consulta)
```

## Requisitos

- [Pandoc](https://pandoc.org/) (≥ 2.0)
- Distribución LaTeX (TeX Live, MiKTeX, etc.)
- Make (opcional)

## Compilación

### Targets disponibles:

| Comando | Output | Descripción |
|---------|--------|-------------|
| `make pdf` | `output/handbook.pdf` | PDF alta calidad (LaTeX) |
| `make web` | `docs/index.html` | Sitio web (GitHub Pages) |
| `make md` | `output/handbook-full.md` | Markdown limpio/compacto |
| `make all` | Todo | Genera los tres formatos |
| `make clean` | — | Limpia archivos generados |

### Ejemplos:

```bash
make pdf      # Solo PDF
make web      # Solo web (para GitHub Pages)
make md       # Solo Markdown compacto
make all      # Todo
```

### Con el script (solo PDF):

```bash
cd build && ./build.sh
```

## GitHub Pages

La versión web se genera en `docs/` y está versionada. Para activar GitHub Pages:

1. Ve a Settings → Pages en tu repositorio
2. Source: "Deploy from a branch"
3. Branch: `main`, folder: `/docs`
4. El sitio estará en `https://usuario.github.io/Handbook-for-Synthi-100/`

## Formato

Los archivos fuente están en **Markdown** (en `content/`) y se convierten a PDF mediante Pandoc con una plantilla LaTeX personalizada.

### Convenciones de formato:

- Capítulos: `# Título {.unnumbered}`
- Advertencias: `::: warning` ... `:::`
- Notas: `::: note` ... `:::`
- Comando LaTeX directo: `\LaTeX{}`, `\today`, etc.

## Licencia

Este trabajo es una transcripción con fines de investigación y educación. Consultar los documentos originales para un análisis exhaustivo.

---

*Carlos Arturo Guerra Parra — Investigador en Fuzzy Gab*

