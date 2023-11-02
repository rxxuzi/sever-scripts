#!/bin/bash

: <<'HEADER'
author: rxxuzi
license: MIT
version: 1.0
description: This script installs Git and sets up the necessary environment variables.
HEADER

# パスを設定
GIT_DIR="$HOME/server/git"

# Gitのインストール
echo "Installing Git..."
sudo apt update
sudo apt install -y git
if [ $? -ne 0 ]; then
  echo "Failed to install Git. Exiting..."
  exit 1
fi

# インストールされたGitのバイナリへのパスを取得
INSTALLED_GIT_PATH=$(which git)
if [ -z "$INSTALLED_GIT_PATH" ]; then
  echo "Git installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

# ディレクトリ作成とシンボリックリンクの作成
mkdir -p "$GIT_DIR"
ln -s "$INSTALLED_GIT_PATH" "$GIT_DIR/git"

# .bashrcに環境変数を追加
echo "export PATH=$GIT_DIR:\$PATH" >> ~/.bashrc

# インストールの確認
git --version
if [ $? -ne 0 ]; then
  echo "Git installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

echo -e "\e[32mGit has been successfully installed and configured.\e[0m"
