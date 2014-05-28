"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Common
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

let g:isgui = 0
if has("gui_running")
    let g:isgui = 1
endif

function! VimSetting()
    "if g:iswindows
    "    return ".vim\\"
    "else
    "    return ".vim/"
    return "./"
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle 插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

if g:iswindows
    set rtp+=$VIMRUNTIME/vimfiles/bundle/Vundle.vim/
    let vundlepath='$VIMRUNTIME/vimfiles/bundle/'
    call vundle#begin(vundlepath)
else
    set rtp+=~/.vim_runtime/bundle/Vundle.vim/
    let vundlepath='~/.vim_runtime/bundle/'
    call vundle#begin(vundlepath)
endif

" 使用Vundle来管理Vundle，这个必须要有。
Plugin 'gmarik/Vundle.vim'

" C/C++ 头文件切换
Plugin 'a.vim'

"相较于Command-T等查找文件的插件，ctrlp.vim最大的好处在于没有依赖，干净利落
Plugin 'kien/ctrlp.vim'

"更快的搜索工具
"Windows 下效率慢
"Plugin 'rking/ag.vim'

"在输入()，""等需要配对的符号时，自动帮你补全剩余半个
"Plugin 'AutoClose'

"目前最好用的代码高亮插件，支持
Plugin 'EasyColour'

"神级插件，Emmet-vim可以让你以一种神奇而无比爽快的感觉写HTML、CSS
Plugin 'mattn/emmet-vim'

"在()、""、甚至HTML标签之间快速跳转；
Plugin 'matchit.zip'

"显示行末的空格；
Plugin 'ShowTrailingWhitespace'

"JS代码格式化插件；
Plugin '_jsbeautify'

"用全新的方式在文档中高效的移动光标，革命性的突破
Plugin 'EasyMotion'

"自动识别文件编码；
Plugin 'mbbill/FencView'

"必不可少，在VIM的编辑窗口树状显示文件目录
Plugin 'scrooloose/nerdtree'

"NERD出品的快速给代码加注释插件，选中，`ctrl+h`即可注释多种语言代码；
Plugin 'scrooloose/nerdcommenter'

"好用的任务栏插件
Plugin 'bling/vim-airline'

"解放生产力的神器，简单配置，就可以按照自己的风格快速输入大段代码。
Plugin 'sirver/ultisnips'

"让代码更加易于纵向排版，以=或,符号对齐
Plugin 'godlygeek/tabular'

"增强源代码浏览
Plugin 'wesleyche/SrcExpl'

"类似缩进指示线
Plugin 'nathanaelkane/vim-indent-guides'

"支持面向对象的 TagList
Plugin 'majutsushi/tagbar'

"用于分割窗口的最大化与还原
"慢，而且与TagHighlight冲突
"Plugin 'ZoomWin'

"支持Tag的代码高亮插件
Plugin 'TagHighlight'

"GIT 集成
Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-git'

"迄今位置最好的自动VIM自动补全插件了吧
"Vundle的这个写法，是直接取该插件在Github上的repo
Plugin 'Valloric/YouCompleteMe'

"语法错误检测
Plugin 'scrooloose/syntastic'

call vundle#end(vundlepath)

filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let g:leaderchar = ","
let mapleader = g:leaderchar
let g:mapleader = g:leaderchar
let maplocalleader = g:leaderchar
let g:maplocalleader = g:leaderchar

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
if g:iswindows
  map <leader>e :e! $VIM/_vimrc<cr>

  " When vimrc is edited, reload it
  autocmd! bufwritepost _vimrc source $VIM/_vimrc

  " Fast refresh helpstags
  map <leader>hh :helptags $VIM/vimfiles/doc<cr>
else
  map <leader>e :e! ~/.vim_runtime/vimrc<cr>

  " When vimrc is edited, reload it
  autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc

  " Fast refresh helpstags
  map <leader>hh :helptags ~/.vim_runtime/doc<cr>
endif

" Jump to the last position when reopaning a file
"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"     au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Set tags
"set tags+=$VIM\tags
"exe "set tags=./" . VimSetting() . "tags"

" Set path
"set path=.,,**

" Set default foldmethod
let g:xml_syntax_folding = 1
set foldmethod=syntax                               " 设置使用语法方式折叠
set foldnestmax=20                                  " 设置最大折叠深度
set foldlevel=20                                    " 默认折叠多少深度

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CScope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    if strlen(VimSetting()) == 2
        exe "noremap <leader>csf :!start cmd /c cscope -Rb -f cscope.out && popd<cr>"
    else
        exe "noremap <leader>csf :!start cmd /v /c pushd " . substitute(VimSetting(), '/', '\\', 'g') . " && cscope -Rb -f cscope.out -s ../ && popd<cr>"
    endif
    "set csprg=/usr/local/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in setting directory
    let dbpath = VimSetting() . 'cscope.out'
    if filereadable(dbpath)
        exe "cs add " . VimSetting() . "cscope.out"
    " else add database pointed to by environment
    "elseif $CSCOPE_DB != ""
    "    cs add $CSCOPE_DB
    endif
    set csverb
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 3 lines to the curors - when moving vertical..
set so=3
set noshowmode
set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase "Case sensitive when searching with upper char

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if g:iswindows
  "set gfn=Bitstream\ Vera\ Sans\ Mono:h10
  "set gfw=Droid\ Sans\ Mono\ for\ Powerline:h11
  "set gfn=PowerlineSymbols:h12
  set gfw=PowerlineSymbols:h11
elseif g:islinux
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if g:isgui
  if g:iswindows
    set columns=121
    set lines=999
    ":autocmd VimEnter * winpos 0 0	" -20 for hidden windows title bar
    :autocmd VimEnter * simalt ~x	" simule Alt+<SPACE> x
  endif
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
  set t_Co=256
  set background=dark
  "colorscheme peaksea
  colorscheme bandit
else
  colorscheme zellner
  set background=dark
endif
set nonu "No line number

set ambiwidth=double
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,ucs-2,chinese,latin1
set termencoding=chinese

set langmenu=zh_cn
try
  lang chinese_china
catch
endtry

if version >= 603
  set helplang=cn
endif

" 解决菜单乱码
"let $LANG = 'zh_CN.UTF-8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set ffs=dos,unix,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
    if g:iswindows
      set undodir=$Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
"set tw=500
set tw=80
set cc=+1

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

" XML file not wrap
autocmd FileType xml setl nowrap
autocmd FileType xml setl shiftwidth=2
autocmd FileType xml setl tabstop=2

set formatoptions-=l
set formatoptions+=t
set cin
"set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l0,gs,hs,ps,ts,+s,c3,C0,(1s,us,\U0,w0,m0,j0,)20,*30
set	cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,/0,(0,us,U0,w0,W0,m0,M0,j0,)20,*30,#0


""""""""""""""""""""""""""""""
" => Insert mode related
""""""""""""""""""""""""""""""
" Bash like keys for the insert mode
imap <C-K> <Up>
imap <C-J> <Down>
imap <c-h> <Left>
imap <c-l> <Right>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
"cno $h e ~/
"cno $d e ~/Desktop/
"cno $j e ./
"cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
"cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>
cnoremap <C-H>		<Left>
cnoremap <C-L>		<Right>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ %{HasPaste()}\ POS:\ %l/%L:%c%V

"function! CurDir()
"    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
"    return curdir
"endfunction
"
"function! HasPaste()
"    if &paste
"        return '!PASTE!'
"    else
"        return ''
"    endif
"endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
"map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
if g:islinux
  let Grep_Skip_Dirs = 'RCS CVS SCCS .svn .git generated'
  set grepprg=/bin/grep\ -nH
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Switch the paste mode
map <leader>pp :setlocal paste!<cr>

" Goto parent directory
map <leader>bb :cd ..<cr>

" 排序头文件并去除重复行
nnoremap <leader>sh <c-v>}k:sort iu /^\s*\(virtual\s\+\\|const\s\+\\|:\\|,\\|.*\)\S*\s\+/<cr>
vnoremap <leader>sh <c-v>:sort iu /^\s*\(virtual\s\+\\|const\s\+\\|:\\|,\\|.*\)\S*\s\+/<cr>
nnoremap <leader>tb :%s/\s\+$//<cr>:nohl<cr>                    " 清除行尾空格

" Fast clipboard access
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>P "*P


""""""""""""""""""""""""""""""
" Tagbar (ctags)
""""""""""""""""""""""""""""""
"let g:tagbar_autoshowtag = 1
if g:iswindows
  let g:tagbar_systemenc = 'cp936'
endif


""""""""""""""""""""""""""""""
" Easy colour setting
""""""""""""""""""""""""""""""
if !exists('g:TagHighlightSettings')
    let g:TagHighlightSettings = {}
endif
let b:TagHighlightSettings = 1
"let g:plugin_development_mode = 1
"let g:TagHighlightSettings['TagFileName'] = VimSetting() . 'tags'
let g:TagHighlightSettings['TagFileName'] = 'tags'
let g:TagHighlightSettings['CtagsExecutable'] = 'ctags'
"let g:TagHighlightSettings['SourceDir'] = '../'
let g:TagHighlightSettings['TagFileDirectory'] = VimSetting()
let g:TagHighlightSettings['TypesFileDirectory'] = VimSetting()

""""""""""""""""""""""""""""""
" FencView setting
""""""""""""""""""""""""""""""
" 自动检测文件编码
let g:fencview_autodetect = 1


""""""""""""""""""""""""""""""
" Airline setting
""""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
"let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#empty_message = 'Branch'
"let g:airline#extensions#syntastic#enabled = 1


""""""""""""""""""""""""""""""
" NERDTree setting
""""""""""""""""""""""""""""""
nmap <F2> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""
" Tagbar setting
""""""""""""""""""""""""""""""
if g:isgui
  autocmd VimEnter * nested :TagbarOpen
endif


""""""""""""""""""""""""""""""
"Indent Guides设置
""""""""""""""""""""""""""""""
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1


""""""""""""""""""""""""""""""
" YouCompleteMe setting
""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0


""""""""""""""""""""""""""""""
" A.vim setting
""""""""""""""""""""""""""""""
" Switch C++ header/source file
let g:alternateNoDefaultAlternate = 1
map <leader>a :A<CR>
map <leader>as :AS<CR>
map <leader>av :AV<CR>

