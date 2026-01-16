# Makefile wrapper - delega al Makefile principal en build/
# Uso: make [target]
#
# Targets disponibles:
#   make pdf    - Genera PDF de alta calidad (LaTeX)
#   make epub   - Genera EPUB para e-readers
#   make web    - Genera sitio web en docs/ (GitHub Pages)
#   make md     - Genera Markdown limpio/compacto
#   make all    - Genera todo
#   make clean  - Limpia archivos generados

.PHONY: all pdf epub web md clean quick

all:
	@$(MAKE) -C build all

pdf:
	@$(MAKE) -C build pdf

epub:
	@$(MAKE) -C build epub

web:
	@$(MAKE) -C build web

md:
	@$(MAKE) -C build md

quick:
	@$(MAKE) -C build quick

clean:
	@$(MAKE) -C build clean
