#! /bin/bash

BUILD_DIR="$HOME/src/emacs-build"

if [ -f "/usr/bin/dnf" ]; then
    sudo dnf -y builddep emacs
    sudo dnf -y install git autogen
elif [ -f "/usr/bin/zypper" ]; then
    sudo zypper --non-interactive source-install -d emacs
    sudo zypper --non-interactive install git autogen
fi
    if ! [ -d ~/src ]; then
        mkdir ~/src
    fi
    git clone https://git.savannah.gnu.org/git/emacs.git $BUILD_DIR
    GO_BACK_DIR=`pwd`
    cd $BUILD_DIR
    ./autogen.sh
    ./configure
    make -j `nproc`
    #make install -j `nproc`
    cd $GO_BACK_DIR

