# Makefile para generar PDF del Handbook of Synthi 100
# Uso: make pdf

CONTENT_DIR = content
TEMPLATE = templates/handbook.latex
FILTER = filters/divs.lua
OUTPUT = handbook.pdf

# Ordenar archivos por nombre (prefijo numérico)
SOURCES = $(sort $(wildcard $(CONTENT_DIR)/*.md))
METADATA = $(CONTENT_DIR)/metadata.yaml

.PHONY: pdf clean

pdf: $(OUTPUT)

$(OUTPUT): $(SOURCES) $(METADATA) $(TEMPLATE) $(FILTER)
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--lua-filter=$(FILTER) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $@
	@echo "✓ Generado: $@"

# Vista previa rápida sin filtros (más rápido)
quick:
	pandoc $(METADATA) $(SOURCES) \
		--template=$(TEMPLATE) \
		--pdf-engine=pdflatex \
		--top-level-division=chapter \
		-o $(OUTPUT)

# Generar HTML (para pruebas)
html:
	pandoc $(METADATA) $(SOURCES) \
		--lua-filter=$(FILTER) \
		--standalone \
		-o handbook.html

clean:
	rm -f $(OUTPUT) handbook.html *.aux *.log *.out *.toc *.lof
