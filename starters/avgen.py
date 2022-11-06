#!/usr/bin/env python3
import sys
import os
import subprocess
from pathlib import Path
import shutil


CWD = Path(__file__).parent
CONFIG = CWD / "config"

if sys.platform == 'Darwin':
    PYTHON_PATH = Path("/opt/local/bin")
elif sys.platform == 'linux':
    PYTHON_PATH = Path("/usr/bin")
else:
    raise NotImplementedError

VENV_NAME = ".venv"

# ACTIVATE_SCRIPT = '.activate.sh'
# DEACTIVATE_SCRIPT = '.deactivate.sh'
# REQUIREMENTS_SCRIPT = 'requirements.txt'
# VSCODE_CONFIG = CWD.parent / 'config' / 'default'

DOTENV = CONFIG / "env.python"
DIRENVRC = CONFIG / "direnv.python"
VSCODE = CONFIG / "vscode.python.json"

GIT = CWD / "git"
GIT_IGNORE = GIT / ".gitignore"

DOCKER = CWD / "docker"
DOCKER_IGNORE = DOCKER / ".dockerignore"
DOCKER_DOCKERFILE = DOCKER / "Dockerfile"
DOCKER_COMPOSE = DOCKER / "compose.yaml"

PY_REQUIREMENTS = CWD / "python" / "requirements.txt"
PY_SETUP = CWD / "python" / "setup.py"
PY_INIT = CWD / "python" / "__init__.py"
PY_MAIN = CWD / "python" / "__init__.py"

README = CWD / "docs" / "README.md"

PYTHON_LAST = "3.10"
INSTALLED_VERSION = [
    # '3.11',
    PYTHON_LAST,
    "3.9",
    "3.8",
    "3.7",
    "3.6",
]

match len(sys.argv):
    case 2:
        version = PYTHON_LAST
    case 3 if sys.argv[-1] in INSTALLED_VERSION:
        version = sys.argv[-1]
    case _:
        raise SystemExit("Usage: {} <venv-name> [<python-version>]".format(sys.argv[0]))

env = Path(sys.argv[0])
path = Path(sys.argv[1])
interpreter = PYTHON_PATH / f"python{version}"


def get_content(path):
    with os.scandir(path) as dir_content:
        return {f.name for f in dir_content}


if __name__ == "__main__":
    print(f'{env=}')
    print(f'{path=}')
    print(f'{interpreter=}')
    current = get_content(path)

    # if 'src' not in current:
    #     os.makedirs(path / 'src')

    # src = get_content(path /'src')
    # if 'setup.py' not in current:
    #     shutil.copy(PY_SETUP, path / 'setup.py')

    # if '__main__.py' not in src:
    #     shutil.copy(PY_MAIN, path / 'src' / '__main__.py')

    # if '__init__.py' not in src:
    #     shutil.copy(PY_INIT, path / 'src' / '__init__.py')

    if ".vscode" not in current:
        os.mkdir(path / ".vscode")
        shutil.copy(VSCODE, path / ".vscode" / "settings.json")

    # if '.dockerignore' not in current:
    #     shutil.copy(DOCKER_IGNORE, path / '.dockerignore')

    # if 'Dockerfile' not in current:
    #     shutil.copy(DOCKER_DOCKERFILE, path / 'Dockerfile')

    # if 'compose.yaml' not in current:
    #     shutil.copy(DOCKER_COMPOSE, path / 'compose.yaml')

    if VENV_NAME not in current:
        subprocess.run([interpreter, "-m", "virtualenv", path / VENV_NAME])

    if "requirements.txt" not in current:
        shutil.copy(PY_REQUIREMENTS, path / "requirements.txt")

    subprocess.run(
        [
            path / VENV_NAME / "bin" / "python",
            "-m",
            "pip",
            "install",
            "--upgrade",
            "pip",
        ]
    )
    subprocess.run(
        [path / VENV_NAME / "bin" / "pip", "install", "-r", "requirements.txt"]
    )
    sys.stdout.write("y\n")

    if ".env" not in current:
        shutil.copy(DOTENV, path / ".env")

    if ".envrc" not in current:
        shutil.copy(DIRENVRC, path / ".envrc")

    subprocess.run(["direnv", "grant", path / ".envrc"])

    if ".gitignore" not in current:
        shutil.copy(GIT_IGNORE, path / ".gitignore")

    if ".git" not in current:
        subprocess.run(["git", "-C", path, "init"])
        subprocess.run(["git", "-C", path, "add", "."])
        subprocess.run(["git", "-C", path, "commit", "-m", "first commit"])

    # if "scripts" not in current:
    #     os.makedirs(path / "scripts")
    # current = get_content(path / "scripts")
    # if "re-fresh.sh" not in current:
    #     shutil.copy(DOTENV)
