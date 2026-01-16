# Handbook for Synthi 100

Edición digital del manual **"Handbook for Synthi 100"** del antiguo Gabinete de Música Electroacústica de Cuenca, España.

Este proyecto forma parte del trabajo de investigación del grupo **Fuzzy Gab** de la Universidad de Castilla-La Mancha.

## Sobre el Synthi 100

El Synthi 100 es un sintetizador analógico modular de EMS (Electronic Music Studios), con secuenciador digital, matriz de patcheo de 7.200 puntos y 12 osciladores.

## Estructura del proyecto

```
content/              # Proyecto Markdown autocontenido
  ├── metadata.yaml   # Metadatos del documento
  ├── Figures/        # Imágenes y figuras escaneadas
  ├── 00-notas-edicion.md
  ├── 01-foreword.md
  ├── 02-section-1.md
  └── 03-section-2.md

build/                # Sistema de compilación
  ├── Makefile        # Makefile principal
  ├── build.sh        # Script alternativo
  ├── templates/      # Plantilla LaTeX para Pandoc
  └── filters/        # Filtros Lua para Pandoc

output/               # Artefactos generados (ignorado por git)
  └── handbook.pdf

reference/            # Material de referencia
  └── Handbook for Synthi 100 (Cuenca).pdf

_legacy/              # Archivos LaTeX antiguos (solo consulta)
```

## Requisitos

- [Pandoc](https://pandoc.org/) (≥ 2.0)
- Distribución LaTeX (TeX Live, MiKTeX, etc.)
- Make (opcional)

## Compilación

El PDF se genera en `output/handbook.pdf`.

### Con Make (desde la raíz):

```bash
make pdf      # Genera output/handbook.pdf
make quick    # PDF sin filtros (más rápido)
make html     # Genera output/handbook.html
make clean    # Limpia archivos generados
```

### Con el script:

```bash
cd build && ./build.sh
```

### Manualmente:

```bash
cd build
pandoc ../content/metadata.yaml ../content/*.md \
    --template=templates/handbook.latex \
    --lua-filter=filters/divs.lua \
    --resource-path=../content \
    --pdf-engine=pdflatex \
    --top-level-division=chapter \
    -o ../output/handbook.pdf
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

