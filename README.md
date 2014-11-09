dotfiles
========

neobundle入れる

    mkdir -p ~.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    
コピー用シェル

    #!/bin/sh
    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/colors ~/.vim
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

vim用のsoralizedカラースキーマの設定をしておく。
下記フォルダに色設定ファイルをコピー。

    ~/.vim/colors
    
