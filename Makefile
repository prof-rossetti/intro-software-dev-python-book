

preview:
	quarto preview docs/

render:
	quarto render docs/

pdf:
	quarto render docs/ --to pdf

docx:
	quarto render docs/ --to docx

open:
	open docs/_build/index.html

open-pdf:
	open docs/_build/Intro-to-Python-Programming.pdf

clean:
	rm -rf docs/_build
	rm -rf docs/.quarto

build:
	$(MAKE) render
	$(MAKE) open

render-fresh:
	$(MAKE) clean
	$(MAKE) render

render-fresh-pdf:
	$(MAKE) clean
	$(MAKE) pdf

render-fresh-docx:
	$(MAKE) clean
	$(MAKE) docx
