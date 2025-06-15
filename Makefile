
build:
	quarto render docs/
	open docs/_build/index.html

preview:
	quarto preview docs/

render:
	quarto render docs/

pdf:
	quarto render docs/ --to pdf

open:
	open docs/_build/index.html

open-pdf:
	open docs/_build/Intro-to-Python-Programming.pdf

clean:
	rm -rf docs/_build
	rm -rf docs/.quarto

render-fresh:
	$(MAKE) clean
	quarto render docs/

render-fresh-pdf:
	$(MAKE) clean
	quarto render docs/ --to pdf
