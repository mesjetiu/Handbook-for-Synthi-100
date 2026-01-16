# Makefile para generar outputs del Handbook of Synthi 100
# Uso: make [target] desde raíz o desde build/
#
# Targets:
#   make pdf    - Genera PDF de alta calidad (LaTeX)
#   make web    - Genera sitio web en docs/ (GitHub Pages)
#   make md     - Genera Markdown limpio/compacto
#   make all    - Genera todo
#   make clean  - Limpia archivos generados

CONTENT_DIR = ../content
DOCS_DIR = ../docs
OUTPUT_DIR = ../output
TEMPLATE = templates/handbook.latex
FILTER = filters/divs.lua
CSS = templates/web.css

# Ordenar archivos por nombre (prefijo numérico)
SOURCES = $(sort $(wildcard $(CONTENT_DIR)/*.md))
METADATA = $(CONTENT_DIR)/metadata.yaml

.PHONY: all pdf web md clean

all: pdf web md

# ============================================
# PDF - Alta calidad con LaTeX
# ============================================
pdf: $(OUTPUT_DIR)/handbook.pdf

$(OUTPUT_DIR)/handbook.pdf: $(SOURCES) $(METADATA) $(TEMPLATE) $(FILTER) | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $@
	@echo "✓ PDF generado: $@"

# ============================================
# WEB - HTML para GitHub Pages (en docs/)
# ============================================
web: $(DOCS_DIR)/index.html

$(DOCS_DIR)/index.html: $(SOURCES) $(METADATA) $(CSS) | $(DOCS_DIR) $(DOCS_DIR)/Figures
	pandoc $(METADATA) $(SOURCES) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--standalone \
		--toc \
		--toc-depth=2 \
		--css=web.css \
		--metadata title="Handbook for Synthi 100" \
		-o $@
	@cp $(CSS) $(DOCS_DIR)/
	@echo "✓ Web generada: $@"

$(DOCS_DIR):
	mkdir -p $(DOCS_DIR)

$(DOCS_DIR)/Figures: $(CONTENT_DIR)/Figures
	@mkdir -p $(DOCS_DIR)/Figures
	@cp -r $(CONTENT_DIR)/Figures/* $(DOCS_DIR)/Figures/
	@echo "✓ Figuras copiadas a docs/"

# ============================================
# MD - Markdown limpio/compacto
# ============================================
md: $(OUTPUT_DIR)/handbook-full.md

$(OUTPUT_DIR)/handbook-full.md: $(SOURCES) $(METADATA) | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--resource-path=$(CONTENT_DIR) \
		--to=gfm \
		--wrap=none \
		--strip-comments \
		-o $@
	@echo "✓ Markdown generado: $@"

# ============================================
# Utilidades
# ============================================
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Vista previa rápida sin filtros (más rápido)
quick: | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--resource-path=$(CONTENT_DIR) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $(OUTPUT_DIR)/handbook.pdf

clean:
	rm -f $(OUTPUT_DIR)/handbook.pdf $(OUTPUT_DIR)/handbook.html $(OUTPUT_DIR)/handbook-full.md
	rm -rf $(DOCS_DIR)
	@echo "✓ Limpiado"
