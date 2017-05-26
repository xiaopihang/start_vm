#!/bin/sh
# Standalone installer for Unixs

# Installation directory
BUNDLE_DIR=~/.vim/bundle
VIMRC_PATH=~/.vimrc
VIMRC_BAK_PATH=~/.vimrc_$(date '+%Y%m%d')
VIMRC_GIT_PATH=https://raw.githubusercontent.com/xiaopihang/vimsetting/master/vim_setting

INSTALL_DIR="$BUNDLE_DIR/neobundle.vim"
if [ -e "$INSTALL_DIR" ]; then
  echo "$INSTALL_DIR already exists!"
  exit;
else
  echo $INSTALL_DIR
fi

# check git command
if type git > /dev/null 2>&1; then
  : # You have git command. No Problem.
else
  echo 'Please install git or update your path to include the git executable!'
  exit 1
fi

# make bundle dir and fetch neobundle
echo "Begin fetching NeoBundle..."
if ! [ -e "$INSTALL_DIR" ]; then
  mkdir -p "$BUNDLE_DIR"
  git clone https://github.com/Shougo/neobundle.vim "$INSTALL_DIR"
fi

echo "Done."

# gccインストール
if [ type gcc > /dev/null 2>&1 ]; then
	# you can make. No Problem.
else
	yum -y install gcc
fi

if [ -e $VIMRC_PATH ]; then
-   mv $VIMRC_PATH $VIMRC_BAK_PATH
-   echo "${VIMRC_PATH} changed to ${VIMRC_BAK_PATH}"
fi

# copy vimrc to your local
curl ${VIMRC_GIT_PATH} > $VIMRC_PATH | vim "+NeoBundleInstall"

echo "Complete setup NeoBundle!"
