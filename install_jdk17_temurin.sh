#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo not found. Please run this script with sufficient privileges."
  exit 1
fi

echo "Installing Eclipse Temurin JDK 17 (Ubuntu/Pop!_OS)..."
sudo apt-get update
sudo apt-get install -y wget gnupg

sudo mkdir -p /etc/apt/keyrings
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg

echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt-get update
sudo apt-get install -y temurin-17-jdk

JAVA_HOME_PATH=$(dirname "$(dirname "$(readlink -f "$(which javac)")")")
echo ""
echo "Temurin JDK 17 installed. Detected JAVA_HOME: ${JAVA_HOME_PATH}"
echo "To set JAVA_HOME for your shell, run:"
echo "  export JAVA_HOME=\"${JAVA_HOME_PATH}\""
echo "  export PATH=\"\$JAVA_HOME/bin:\$PATH\""