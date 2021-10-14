#!/bin/bash

LN_ORIG="$HOME/dotfiles/emacs-files/emacs.d"

if [ "$1" = "shift-emacs.d" ]; then
    echo "shifting ~/.emacs.d to $(pwd)/emacs.d "
    rm -f "$HOME/.emacs.d"
    ln -s "$(pwd)/emacs.d" "$HOME/.emacs.d"
fi

if [ "$1" = "return-emacs.d" ]; then
    echo "returning ~/.emacs.d to original location"
    rm -f "$HOME/.emacs.d"
    ln -s "$LN_ORIG" "$HOME/.emacs.d"
fi
