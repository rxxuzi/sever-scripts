#!/bin/bash

: <<'HEADER'
author: rxxuzi
license: MIT
version: 1.0
description: This script installs OpenJDK 11 and sets up the necessary environment variables.
HEADER

# パスを設定
JAVA_DIR="$HOME/server/java"

# Javaのインストール
echo "Installing OpenJDK 11..."
sudo apt update
sudo apt install -y openjdk-11-jdk
if [ $? -ne 0 ]; then
  echo "Failed to install OpenJDK 11. Exiting..."
  exit 1
fi

# JDKのパスを設定
JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# ディレクトリ作成とシンボリックリンクの作成
mkdir -p "$JAVA_DIR"
ln -s "$JAVA_HOME" "$JAVA_DIR/openjdk-11"

# .bashrcに環境変数を追加
echo "export JAVA_HOME=$JAVA_DIR/openjdk-11" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# インストールの確認
java -version
if [ $? -ne 0 ]; then
  echo "Java installation seems to be unsuccessful. Please check your setup. Exiting..."
  exit 1
fi

echo -e "\e[32mJava has been successfully installed and configured.\e[0m"
