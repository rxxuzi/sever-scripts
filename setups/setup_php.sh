#!/bin/bash

: <<'HEADER'
author: rxxuzi
license: MIT
version: 1.0
description: This script installs PHP and sets up the necessary environment variables.
HEADER

# パスを設定
PHP_DIR="$HOME/server/php"

# PHPのインストール
echo "Installing PHP..."
sudo apt update
sudo apt install -y php
if [ $? -ne 0 ]; then
  echo "Failed to install PHP. Exiting..."
  exit 1
fi

# インストールされたPHPのバイナリへのパスを取得
INSTALLED_PHP_PATH=$(which php)
if [ -z "$INSTALLED_PHP_PATH" ]; then
  echo "PHP installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

# ディレクトリ作成とシンボリックリンクの作成
mkdir -p "$PHP_DIR"
ln -s "$INSTALLED_PHP_PATH" "$PHP_DIR/php"

# .bashrcに環境変数を追加
echo "export PATH=$PHP_DIR:\$PATH" >> ~/.bashrc

# インストールの確認
php -v
if [ $? -ne 0 ]; then
  echo "PHP installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

echo -e "\e[32mPHP has been successfully installed and configured.\e[0m"

