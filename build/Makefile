# Makefile para generar outputs del Handbook of Synthi 100
# Uso: make [target] desde raíz o desde build/
#
# Targets:
#   make pdf    - Genera PDF de alta calidad (LaTeX)
#   make epub   - Genera EPUB para e-readers
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

.PHONY: all pdf epub web md clean

all: pdf epub web md

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
# EPUB - Para e-readers
# ============================================
epub: $(OUTPUT_DIR)/handbook.epub

$(OUTPUT_DIR)/handbook.epub: $(SOURCES) $(METADATA) $(CSS) | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--toc \
		--toc-depth=2 \
		--css=$(CSS) \
		--epub-cover-image=$(CONTENT_DIR)/Figures/cover.png \
		-o $@ 2>/dev/null || \
	pandoc $(METADATA) $(SOURCES) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--toc \
		--toc-depth=2 \
		--css=$(CSS) \
		-o $@
	@echo "✓ EPUB generado: $@"

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
# MD - Markdown limpio/compacto (autocontenido)
# ============================================
MD_DIR = $(OUTPUT_DIR)/handbook-md

md: $(MD_DIR)/handbook.md

# Genera MD autocontenido con imágenes
$(MD_DIR)/handbook.md: $(SOURCES) $(METADATA) | $(MD_DIR) $(MD_DIR)/Figures
	@printf '%s\n\n' "# Handbook of Synthi 100" > $@
	@printf '%s\n\n' "**EMS (Electronic Music Studios)**" >> $@
	@printf '%s\n\n' "---" >> $@
	@printf '%s\n\n' "## Table of Contents" >> $@
	@for f in $(SOURCES); do \
		grep -E '^#{1,2} ' "$$f" 2>/dev/null; \
	done | sed 's/ *{[^}]*}$$//' | while read -r line; do \
		if echo "$$line" | grep -q '^# '; then \
			title=$$(echo "$$line" | sed 's/^# //'); \
			anchor=$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[–—]/-/g; s/[,:]//g'); \
			echo "- [$$title](#$$anchor)"; \
		elif echo "$$line" | grep -q '^## '; then \
			title=$$(echo "$$line" | sed 's/^## //'); \
			anchor=$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[–—]/-/g; s/[,:]//g'); \
			echo "  - [$$title](#$$anchor)"; \
		fi; \
	done >> $@
	@printf '\n%s\n\n' "---" >> $@
	@pandoc $(METADATA) $(SOURCES) \
		--resource-path=$(CONTENT_DIR) \
		--to=gfm \
		--wrap=none \
		--strip-comments \
		>> $@
	@echo "✓ Markdown generado: $@"

$(MD_DIR):
	mkdir -p $(MD_DIR)

$(MD_DIR)/Figures: $(CONTENT_DIR)/Figures
	@mkdir -p $(MD_DIR)/Figures
	@cp -r $(CONTENT_DIR)/Figures/* $(MD_DIR)/Figures/ 2>/dev/null || true
	@echo "✓ Figuras copiadas a $(MD_DIR)/Figures/"

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
	rm -f $(OUTPUT_DIR)/handbook.pdf $(OUTPUT_DIR)/handbook.epub $(OUTPUT_DIR)/handbook.html
	rm -rf $(OUTPUT_DIR)/handbook-md
	rm -rf $(DOCS_DIR)
	@echo "✓ Limpiado"
