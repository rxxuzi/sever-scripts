#!/bin/bash

: <<'HEADER'
author: rxxuzi
license: MIT
version: 1.0
description: This script installs GCC and sets up the necessary environment variables.
HEADER

# パスを設定
GCC_DIR="$HOME/server/gcc"

# GCCのインストール
echo "Installing GCC..."
sudo apt update
sudo apt install -y gcc
if [ $? -ne 0 ]; then
  echo "Failed to install GCC. Exiting..."
  exit 1
fi

# インストールされたGCCのバイナリへのパスを取得
INSTALLED_GCC_PATH=$(which gcc)
if [ -z "$INSTALLED_GCC_PATH" ]; then
  echo "GCC installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

# ディレクトリ作成とシンボリックリンクの作成
mkdir -p "$GCC_DIR"
ln -s "$INSTALLED_GCC_PATH" "$GCC_DIR/gcc"

# .bashrcに環境変数を追加
echo "export PATH=$GCC_DIR:\$PATH" >> ~/.bashrc

# インストールの確認
gcc --version
if [ $? -ne 0 ]; then
  echo "GCC installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

echo -e "\e[32mGCC has been successfully installed and configured.\e[0m"
