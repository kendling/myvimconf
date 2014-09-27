myvimconf
=========

(g)Vim configure files for me.


#安装说明

##Windows

#安装 vim 配置文件

先去 http://ctags.sourceforge.net 下载 ctags.exe 丢 gVim.exe 的目录

去 GVIM 目录下打开命令行提示符，执行以下命令（需安装 git）

  git clone https://github.com/kendling/myvimconf.git

  cd myvimconf

  move * ..

  cd ..

  rd myvimconf

  git submodule update --init
  
  下载 clang.dll 和 YouCompleteMe 编译好的 dll 到 vimfiles/bundle/YouCompleteMe/Python 目录

#配置字体

  打开 vimfiles/font/ 并双击 PowerlineSymbols.otf 文件。

  按提示安装字体

##Linux

  cd ~

  mkdir .vim

  cd .vim

  git clone https://github.com/kendling/myvimconf.git

  cd myvimconf

  ls -A | xargs mv --target-directory=..

  cd ..

  rmdir myvimconf

  git submodule update --init

  cd vimfiles/bundle/YouCompleteMe/

  ./install.sh --clang-completer

#配置字体

  cd ~/.vim/vimfiles/font

  mkdir -p ~/.config/fontconfig/conf.d/

  cp PowerlineSymbols.otf ~/.fonts/

  fc-cache -vf ~/.fonts/

  cp 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
