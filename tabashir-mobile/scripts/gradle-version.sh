#!/bin/bash

# Android adapter for version-manager.sh

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION_MANAGER="$SCRIPTS_DIR/version-manager.sh"

case "$1" in
    generate)
        shift
        "$VERSION_MANAGER" "$@"
        ;;
    *)
        echo "Usage: $0 generate {patch}"
        exit 1
esac
