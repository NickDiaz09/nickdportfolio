#!/bin/bash

# Pick a Python whose ensurepip actually works. Some Homebrew Python builds
# (observed with 3.14) fail to bootstrap pip into new venvs, which leaves a
# broken venv/ with no bin/activate. Prefer known-good versions if present.
PYTHON_BIN=""
for candidate in python3.11 python3.12 python3.13 python3 python; do
    if command -v "$candidate" >/dev/null 2>&1; then
        PYTHON_BIN="$candidate"
        break
    fi
done

if [ -z "$PYTHON_BIN" ]; then
    echo "Error: no python interpreter found on PATH." >&2
    exit 1
fi

# Show the tools versions
"$PYTHON_BIN" --version
bundle --version

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ] || [ ! -f "venv/bin/activate" ]; then
    rm -rf venv
    "$PYTHON_BIN" -m venv venv
fi

# Set the virtual environment
source venv/bin/activate

# Install the required Python packages
pip install -r requirements.txt

# Install the required Ruby gems in the project directory
bundle config set --local path './.bundle'
bundle install