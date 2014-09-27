myvimconf
=========

(g)Vim configure files for me.


#安装说明

##Windows
先去 http://ctags.sourceforge.net 下载 ctags.exe 丢 gVim.exe 的目录
去 GVIM 目录下打开命令行提示符，执行以下命令（需安装 git）
  git clone https://github.com/kendling/myvimconf.git
  cd myvimconf
  move * ..
  cd ..
  rd myvimconf
  git submodule update --init
  
  下载 clang.dll 和 YouCompleteMe 编译好的 dll 到 vimfiles/bundle/YouCompleteMe/Python 目录

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
  ./install.sh --clang-complete
