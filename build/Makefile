# Makefile para generar PDF del Handbook of Synthi 100
# Uso: make pdf (desde build/) o make -C build pdf (desde raíz)

CONTENT_DIR = ../content
TEMPLATE = templates/handbook.latex
FILTER = filters/divs.lua
OUTPUT_DIR = ../output
OUTPUT = $(OUTPUT_DIR)/handbook.pdf

# Ordenar archivos por nombre (prefijo numérico)
SOURCES = $(sort $(wildcard $(CONTENT_DIR)/*.md))
METADATA = $(CONTENT_DIR)/metadata.yaml

.PHONY: pdf clean

pdf: $(OUTPUT)

$(OUTPUT): $(SOURCES) $(METADATA) $(TEMPLATE) $(FILTER) | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $@
	@echo "✓ Generado: $@"

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Vista previa rápida sin filtros (más rápido)
quick: | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--resource-path=$(CONTENT_DIR) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $(OUTPUT)

# Generar HTML (para pruebas)
html: | $(OUTPUT_DIR)
	pandoc $(METADATA) $(SOURCES) \
		--lua-filter=$(FILTER) \
		--resource-path=$(CONTENT_DIR) \
		--standalone \
		-o $(OUTPUT_DIR)/handbook.html

clean:
	rm -f $(OUTPUT_DIR)/handbook.pdf $(OUTPUT_DIR)/handbook.html *.aux *.log *.out *.toc *.lof
