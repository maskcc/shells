set nu
set tabstop=4 "设置tab键为4个空格
set shiftwidth=4  "自动缩进使用的空白长度
set softtabstop=4
set autowrite
set nocompatible
filetype on
filetype indent on
set cindent
"softtablestop = 12 按下tab 那么插入的是一个tab 和4个空格
set expandtab
set autoindent
set smartindent
set ignorecase
"autocmd BufNewFile, BufRead *.c, *.cpp, *.java, *.h :CFOLD
"设置折叠 fdm
set fdm=syntax
set smartcase
set tags=tags;
set autochdir
syntax on
"
"当前行的下划线
set cursorline
"搜索单词高亮
set hlsearch
set ic
set incsearch
"
highlight Folded ctermfg=0 ctermbg=7 
"自动跳转到上次打开位置 
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif                                   


set fileencodings=ucs-bom,utf-8,GB18030,gbk,GB2312
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }

Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"状态插件
Plug 'itchyny/lightline.vim'
""搜索插件
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"语法插件
Plug 'sheerun/vim-polyglot'
""彩色显示括号对。
Plug 'kien/rainbow_parentheses.vim'
"配色
Plug 'altercation/vim-colors-solarized'
call plug#end()

set tags=tags;
if filereadable("/etc/vim/vimrc.local")
      source /etc/vim/vimrc.local
  endif
let g:solarized_termcolors=256

"rainbow_parentheses的配置
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"end rainbow_parentheses



"solarized配置
""背景颜色
set background=light
"set background=dark
"colorscheme solarized
"系统自带的配色方案
colorscheme desert
"end  solarized配置

set laststatus=2
" 下面关闭状态栏
"set noshowmode
"
"fzf 配置
nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
"nmap <C-]> :ts
let g:fzf_action = { 'ctrl-e': 'edit' }
"end fzf
""" protobuffer
augroup filetype
au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

:noremap g<C-]> <C-]>
