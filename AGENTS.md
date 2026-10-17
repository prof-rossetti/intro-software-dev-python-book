# AGENTS.md

## Repository Overview

This repository contains the source code for the interactive online book **"Intro to Python: Programming and Applications"** by Michael J. Rossetti.
The book is built with **Quarto** and automatically deployed to GitHub Pages via GitHub Actions.

## Directory Structure

- `docs/`: The Quarto book project root.
  - `_quarto.yml`: Main Quarto book configuration file specifying project type, book metadata, sidebar navigation/chapters, formatting options, and plugins.
  - `_build/`: Build output directory (HTML, assets). Ignored in git.
  - `requirements.txt`: Python package dependencies for rendering and running notebook/code computations.
  - `index.qmd`: Home/welcome page of the book.
  - `why-python.qmd`: Introductory chapter on why learn Python.
  - `about-author.qmd`: Author information.
  - `notes/`: Main instructional chapters organized by topic:
    - `dev-tools/`: Google Colab, package management with pip, etc.
    - `python-lang/`: Basics, datatypes, control flow, file operations.
    - `data-processing/`: Looping, mapping, filtering, comprehensions, sorting.
    - `dataviz/`: Charting with Plotly (trendlines, candlesticks).
    - `fetching-data/`: HTTP, JSON, CSV, XML, web scraping, automated browsing.
    - `api-integrations/`: Third-party APIs (AlphaVantage, Spotify, Resend, Google Drive, Google Sheets, YouTube).
    - `python-modules/`: Built-in modules (math, random, statistics, datetime, os).
  - `exercises/`: Student exercises and project assignments.
  - `images/`: Static image assets (screenshots, diagrams, banners).
  - `includes/`: HTML fragments included in headers (analytics, scripts).
  - `styles/`: Custom CSS (`my-style.css`).
- `.github/workflows/deploy.yml`: GitHub Actions workflow that automatically renders the book with Quarto and publishes `docs/_build` to GitHub Pages upon pushing to `main`.
- `Makefile`: Convenience aliases for Quarto commands.

## Common Operations & Commands

### Running Locally

To preview the book locally with live reload (dev server defaults to port 3243):
```sh
quarto preview docs/
# or
make preview
```

To render the full book to HTML in `docs/_build`:
```sh
quarto render docs/
# or
make render
```

To render to HTML only (matches CI):
```sh
quarto render docs/ --to html
```

To render to PDF:
```sh
quarto render docs/ --to pdf
# or
make pdf
```

To clean previous build artifacts:
```sh
make clean
```

To perform a clean rebuild:
```sh
make render-fresh
```

### Python Environment & Dependency Management

The local build uses a dedicated Anaconda environment named `quarto-env` (Python 3.11):
```sh
conda activate quarto-env
# or specify the interpreter directly:
# QUARTO_PYTHON=/opt/anaconda3/envs/quarto-env/bin/python quarto render docs/ --to html
```

Dependencies required for rendering and notebooks must be managed in `docs/requirements.txt`:
```sh
pip install -r docs/requirements.txt
```

> **Shared Conda Environment Note:**
> The `quarto-env` conda environment is shared across several online book repositories under `~/projects/prof-rossetti/` (including the *Applied Data Science* book and *Predictive Modeling* book).
> Be mindful when upgrading or modifying dependencies so as not to unintentionally disrupt packages required by other books sharing this environment.

> **Package Installation Rule:**
> If you need to install any new Python package or dependency, ALWAYS add it to `docs/requirements.txt` first, and then install using `pip install -r docs/requirements.txt`. Do NOT run ad-hoc `pip install <package>` commands directly. This ensures the environment remains reproducible and matches GitHub Actions CI.

## Chapter Authoring Guidelines

### File Types
Chapters can be either:
- **Quarto Markdown (`.qmd`)**: Used for text-heavy chapters, overviews, or tutorials. Code blocks can be run via `{python}` with cache options configured in YAML frontmatter (`execute: { cache: true }`).
- **Jupyter Notebooks (`.ipynb`)**: Used for interactive tutorials and API integrations. Pre-executed cell outputs are preserved and rendered by Quarto into HTML.

### Heading Structure
1. Every chapter MUST begin with a level-1 heading (`# Title`). Quarto uses this H1 as the chapter's official title.
2. Major sections inside the chapter should use level-2 headings (`## Section Title`).
3. Subsections should use level-3 headings (`### Subsection Title`).

### Registering Chapters in `docs/_quarto.yml`
Whenever a new chapter is created:
1. Place the chapter file in the appropriate directory under `docs/notes/` or `docs/exercises/`.
2. Add the chapter to `docs/_quarto.yml` under `book.chapters` (or `book.appendices`):
   ```yaml
   - href: notes/api-integrations/resend.ipynb
     text: 'Sending Email via "Resend"'
   ```
3. Ensure the order matches the curriculum flow.

### Notebook (`.ipynb`) Standards
- Target environment: Designed to run seamlessly in **Google Colab**.
- Use `%%capture` on pip install cells (e.g. `!pip install resend`) to keep rendering clean.
- For secret credentials (API keys), use Google Colab secrets:
  ```python
  from google.colab import userdata
  MY_API_KEY = userdata.get("MY_API_KEY")
  ```
- Never hardcode private API keys, tokens, or personal passwords in source files or notebook outputs.
- Provide a link or badge to open the notebook in Google Colab when appropriate.

## Deployment & CI/CD

- Pushes to the `main` branch automatically trigger `.github/workflows/deploy.yml`.
- The workflow:
  1. Sets up Python 3.11.
  2. Installs dependencies from `docs/requirements.txt`.
  3. Sets up Quarto with tinytex.
  4. Runs `quarto render docs/ --to html`.
  5. Publishes `docs/_build` to GitHub Pages.
- Verify that any new packages needed by notebooks or book code are added to `docs/requirements.txt`.
