# Maven documentation (Zensical)

Static docs for Maven, built with [Zensical](https://zensical.org/).

## Setup

1. Python 3.14+ (or match your environment).
2. Node (optional, needed for markdown linting configured as pre-commit hook)
3. Create a virtualenv and install Zensical:

For Linux/Mac:

```sh
python3 -m venv .venv
source .venv/bin/activate
pip install zensical pre-commit
pre-commit install
```

For Windows CMD:

```sh
python -m venv .venv
.venv/bin/activate.bat
pip install zensical pre-commit
pre-commit install
```

You can deactivate the virtualenv with:

For Linux/Mac:

```sh
deactivate
```

For Windows:

```sh
deactivate.bat
```

## Run locally

### Zensical

```sh
source .venv/bin/activate
zensical serve
```

Open the URL Zensical prints (usually `http://localhost:8000/`).

### Trigger Pre-Commit Hook manually

If you want to run the pre-commit hook manually for all changed file, call

```sh
pre-commit run
```

If you want to run the pre-commit hook manually for all files in the repository, call:

```sh
pre-commit run --all-files
```

## GitHub Pages

In the repo **Settings → Pages**, set the source to **Deploy from a branch** and choose **`gh-pages`** (root). The workflow publishes production to the site root and PR previews to `pr/<number>/`.
