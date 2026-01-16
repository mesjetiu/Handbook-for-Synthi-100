#!/bin/bash
# Script para generar el PDF del Handbook for Synthi 100

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CONTENT_DIR="../content"
TEMPLATE="templates/handbook.latex"
FILTER="filters/divs.lua"
OUTPUT_DIR="../output"
OUTPUT="$OUTPUT_DIR/handbook.pdf"

# Crear directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Obtener archivos .md ordenados por nombre
SOURCES=$(find "$CONTENT_DIR" -name "*.md" ! -name "metadata.yaml" | sort)
METADATA="$CONTENT_DIR/metadata.yaml"

echo "Generando $OUTPUT..."

pandoc "$METADATA" $SOURCES \
    --template="$TEMPLATE" \
    --lua-filter="$FILTER" \
    --resource-path="$CONTENT_DIR" \
    --pdf-engine=pdflatex \
    --top-level-division=chapter \
    -o "$OUTPUT"

echo "✓ Generado: $OUTPUT"
