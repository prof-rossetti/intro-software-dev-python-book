
# Quarto Docs

## Prerequisites

### Quarto

We need to install Quarto onto your local machine. You can [download](https://quarto.org/docs/get-started/), or [install via homebrew](https://formulae.brew.sh/cask/quarto) (if you like that kind of thing):

```sh
brew install --cask quarto
```

If you use VS Code, you can also consider installing the [Quarto Extension](https://marketplace.visualstudio.com/items?itemName=quarto.quarto).

### Setup

Fork the repo. Clone your copy of the repo onto your computer and navigate to it from the command line.

Setup virtual environment:

```sh
#conda create -n quarto-env python=3.10
#conda activate quarto-env
```

Install package dependencies:

```sh
#pip install -r requirements.txt
#pip install -r docs/requirements.txt
```

## Initialization

FYI the following command was used to initialize the quarto config:

```sh
#quarto create book
```

In the docs/_quarto.yml file, the output directory was changed from _book to _build to standardize across projects, enabling the usage of common workflow files and makefile.

## Building


Previewing the site (runs like a local webserver):

```sh
quarto preview docs/
```


Rendering the site (writes local HTML files to the "docs/_build" directory, which is ignored from version control):

```sh
quarto render docs/ --verbose
```


## GitHub Actions Workflows

### Website Publishing

We are using the ["quarto-pages.yml" workflow configuration file](/.github/workflows/quarto-pages.yml) to deploy the site to GitHub Pages when new commits are pushed to the main branch.

In order for this to work, you first need to configure your GitHub Pages repo settings to publish via GitHub Actions.
