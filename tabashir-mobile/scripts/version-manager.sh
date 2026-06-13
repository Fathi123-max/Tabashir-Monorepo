#!/bin/bash

# Simple version manager for Git-based projects
# Stores version in version.properties

VERSION_FILE="version.properties"

if [ ! -f "$VERSION_FILE" ]; then
    echo "version.code=1" > "$VERSION_FILE"
    echo "version.name=1.0.0" >> "$VERSION_FILE"
fi

get_latest() {
    source "$VERSION_FILE"
    echo "Current Version: $version.name ($version.code)"
}

increment_patch() {
    source "$VERSION_FILE"
    IFS='.' read -ra ADDR <<< "$version.name"
    major=${ADDR[0]}
    minor=${ADDR[1]}
    patch=${ADDR[2]}
    
    new_patch=$((patch + 1))
    new_version="$major.$minor.$new_patch"
    new_code=$((version.code + 1))
    
    echo "version.code=$new_code" > "$VERSION_FILE"
    echo "version.name=$new_version" >> "$VERSION_FILE"
    echo "Updated to: $new_version ($new_code)"
}

case "$1" in
    latest)
        get_latest
        ;;
    patch)
        increment_patch
        ;;
    *)
        echo "Usage: $0 {latest|patch}"
        exit 1
esac
