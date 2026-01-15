# Handbook for Synthi 100

Edición digital del manual **"Handbook for Synthi 100"** del antiguo Gabinete de Música Electroacústica de Cuenca, España.

Este proyecto forma parte del trabajo de investigación del grupo **Fuzzy Gab** de la Universidad de Castilla-La Mancha.

## Sobre el Synthi 100

El Synthi 100 es un sintetizador analógico modular de EMS (Electronic Music Studios), con secuenciador digital, matriz de patcheo de 7.200 puntos y 12 osciladores.

## Estructura del proyecto

```
content/           # Archivos Markdown (fuente principal)
  ├── metadata.yaml
  ├── 00-notas-edicion.md
  ├── 01-foreword.md
  ├── 02-section-1.md
  └── 03-section-2.md
templates/         # Plantilla LaTeX para Pandoc
filters/           # Filtros Lua para Pandoc
Figures/           # Imágenes y figuras escaneadas
TeX_files/         # Archivos LaTeX originales (legacy)
```

## Requisitos

- [Pandoc](https://pandoc.org/) (≥ 2.0)
- Distribución LaTeX (TeX Live, MiKTeX, etc.)
- Make (opcional)

## Compilación

### Con el script:

```bash
./build.sh
```

### Con Make:

```bash
make pdf      # Genera handbook.pdf
make quick    # PDF sin filtros (más rápido)
make html     # Genera handbook.html
make clean    # Limpia archivos auxiliares
```

### Manualmente:

```bash
pandoc content/metadata.yaml content/*.md \
    --template=templates/handbook.latex \
    --lua-filter=filters/divs.lua \
    --pdf-engine=pdflatex \
    --top-level-division=chapter \
    -o handbook.pdf
```

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

