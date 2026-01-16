# Makefile wrapper - delega al Makefile principal en build/
# Uso: make pdf, make clean, make html, make quick

.PHONY: pdf clean html quick

pdf:
	@$(MAKE) -C build pdf

quick:
	@$(MAKE) -C build quick

html:
	@$(MAKE) -C build html

clean:
	@$(MAKE) -C build clean
