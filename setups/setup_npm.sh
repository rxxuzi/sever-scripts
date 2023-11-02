#!/bin/bash

: <<'HEADER'
author: rxxuzi
license: MIT
version: 1.0
description: This script installs Node.js and NPM, and sets up the necessary environment variables.
HEADER

# パスを設定
NODE_DIR="$HOME/server/node"
NPM_DIR="$HOME/server/npm"

# Node.jsとNPMのインストール
echo "Installing Node.js and NPM..."
sudo apt update
sudo apt install -y nodejs npm
if [ $? -ne 0 ]; then
  echo "Failed to install Node.js and NPM. Exiting..."
  exit 1
fi

# インストールされたNode.jsとNPMのバイナリへのパスを取得
INSTALLED_NODE_PATH=$(which node)
INSTALLED_NPM_PATH=$(which npm)
if [ -z "$INSTALLED_NODE_PATH" ] || [ -z "$INSTALLED_NPM_PATH" ]; then
  echo "Node.js or NPM installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

# ディレクトリ作成とシンボリックリンクの作成
mkdir -p "$NODE_DIR" "$NPM_DIR"
ln -s "$INSTALLED_NODE_PATH" "$NODE_DIR/node"
ln -s "$INSTALLED_NPM_PATH" "$NPM_DIR/npm"

# .bashrcに環境変数を追加
echo "export PATH=$NODE_DIR:$NPM_DIR:\$PATH" >> ~/.bashrc

# インストールの確認
node --version
npm --version
if [ $? -ne 0 ]; then
  echo "Node.js or NPM installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

echo -e "\e[32mNode.js and NPM have been successfully installed and configured.\e[0m"
