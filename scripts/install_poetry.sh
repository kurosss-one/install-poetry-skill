#!/usr/bin/env bash
set -e

if command -v poetry &> /dev/null; then
    echo "Poetry already installed:"
    poetry --version
    exit 0
fi

echo "Installing Poetry..."
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"

if command -v poetry &> /dev/null; then
    echo "Poetry installed successfully!"
    poetry --version
fi