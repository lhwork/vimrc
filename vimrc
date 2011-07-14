
" vimrc (configuration file for vim only)
" author: Li Huan     <lhwork@hotmail.com>

" ==========================================================================================
" 全局配置  
" ==========================================================================================
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible                "关掉兼容模式
syntax on                       " 语法高亮
set mouse=a                     " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)
set history=1000                " remember more commands and search history
set wildmenu                    " 增强模式中的命令行自动完成操作
set helplang=cn                 " 中文帮助
set showcmd                     " 显示命令
set whichwrap+=<,>,h,l          " 退格键和方向键可以换行
set magic
set autoread                    " 当文件在外部被修改时，自动重新读取
set viminfo+=!                  " 保存全局变量
set iskeyword+=_,$,@,%,#,-      " 带有如下符号的单词不要被换行分割
set linespace=0                 " 字符间插入的像素行数目
set selection=exclusive
set selectmode=mouse,key                                     

filetype plugin on              " 载入文件类型插件
filetype indent on              " 为特定文件类型载入相关缩进文件

set nolist
set listchars=tab:\ \ ,extends:>,precedes:<

let s:PlugWinSize = 25          " 插件窗口的宽度，如TagList,NERD_tree等，自己设置

" 为leader快捷键 {{{
let mapleader = ","  
let g:mapleader = ","
" }}} 

" 设置快速保存和退出 {{{ 
nmap <leader>s :w!<cr>       " 快速保存为,s  
nmap <leader>w :wq!<cr>      " 快速退出（保存）为,w                     
nmap <leader>q :q!<cr>       " 快速退出（不保存）为,q
nmap <C-Z> :shell<cr>        " ^z快速进入shell

" }}}

" 缩写  {{{
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab imail LiHuan <lhwork@hotmail.com>
iab igmail lihuan1976@gmail.com
iab iname Li Huan
" }}}

" ==========================================================================================

" Vim 界面  {{{
set ruler                       " 设置标尺
set cmdheight=2                 " 设置命令行的高度  
set number                      " 显示行号
set backspace=indent,eol,start  " 使回格键（backspace）正常处理indent, eol, start等
set showmatch                   " 高亮显示匹配的括号
set showmode                    " always show what mode we're currently editing in
set confirm                     " 在处理未保存或只读文件的时候，弹出确认
set scrolloff=4                 " 光标移动到buffer的顶部和底部时保持3行距离
set virtualedit=all             " allow the cursor to go in to "invalid" places
set ignorecase                  "搜索忽略大小写
set smartcase                   " ignore case if search pattern is all lowercase,
set hlsearch                    "搜索逐字符高亮
set incsearch                   " show search matches as you type
set gdefault                    "行内替换
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" }}}

" 状态栏设置 {{{
set laststatus=2                " 开启状态栏 
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

function! CurDir()  
    let curdir = substitute(getcwd(), $HOME, "~", "g")  
    return curdir  
endfunction 

set statusline=
set statusline+=%f "path to the file in the buffer, relative to current directory
set statusline+=\ %h%1*%m%r%w%0* " flag
set statusline+=\ [%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=\ CWD:%r%{CurDir()}%h
set statusline+=\ Line:%l/%L
"}}}

" 文字处理  {{{
set tabstop=4                   " 1个tab，4个空格
set softtabstop=4               " 统一缩进为4
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab                   " 用空格代替制表符
set smarttab                    " 在行和段开始处使用制表符
set linebreak                   " 整词换行
set undolevels=100              " 撤销
" }}}

" 缩进  {{{
set autoindent                  " 自动缩进
set copyindent                  " copy the previous indentation on autoindenting
set nowrap                      " 不自动换行
" }}}

" 编码设置 {{{
set encoding=utf8               " 设置编码
set termencoding=utf-8
set fileencodings=utf-8,GB2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1      " 设置文件编码
"}}}

" 字体和颜色  {{{
syntax enable                               " 开启语法
if has('gui_running')
	colorscheme eclipse 	                " 配色方案
    set lines=40
    set columns=100
    set cursorline                          " 高亮显示当前行
    if has("gui_mac") || has("gui_macvim")
        set guifont=Monaco:h14              " 设置字体
    endif    
endif
" }}}

" 文件和备份  {{{
set nobackup                    " 禁止生成临时文件
set noswapfile                  " 关闭交换文件
" }}}

" 折叠 {{{
set foldenable " turn on folding 
set foldmethod=indent " make folding indent sensitive 
set foldlevel=100 " don't autofold anything (but I can still fold manually) 
set foldopen -=search " don't open folds when you search into them 
set foldopen -=undo " don't open folds when you undo stuff 
" }}}

" 自动补全括号和引号  {{{
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap < <><ESC>i
inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
" }}}

" 切换到正在编辑的文件目录
map <leader>d :execute "cd" expand("%:h")<cr> 
:autocmd BufEnter * cd %:p:h

" 拷贝粘贴
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" 根据给定方向搜索当前光标下的单词，结合下面两个绑定使用
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<cr>"
    else
        execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" 用 */# 向 前/后 搜索光标下的单词
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" vim 自动补全 Python 代码  {{{
" 来自http://vim.sourceforge.net/scripts/script.php?script_id=850
"pydiction 1.2 python auto complete
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
"defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20
" }}}

" Tag list (ctags)  {{{
" http://www.vim.org/scripts/script.php?script_id=273
" <leader>t 打开TagList窗口，窗口在右边
nmap <silent> <leader>t :TlistToggle<cr>
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1             "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1           "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1          "在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_WinWidth = s:PlugWinSize
let Tlist_Auto_Open = 0
let Tlist_Display_Prototype = 0
let Tlist_Close_On_Select = 0
" }}}

" NerdTree 插件    {{{
" http://www.vim.org/scripts/script.php?script_id=1658
let NERDTreeShowHidden = 1
let NERDTreeWinPos = "left"
let NERDTreeWinSize = s:PlugWinSize 
nmap <leader>n :NERDTreeToggle<cr>
" }}}

" NERD_commenter.vim   {{{
" http://www.vim.org/scripts/script.php?script_id=1218
" Toggle单行注释/“性感”注释/注释到行尾/取消注释
map <leader>cc ,c<space>
map <leader>cs ,cs
map <leader>c$ ,c$
map <leader>cu ,cu
" }}}


