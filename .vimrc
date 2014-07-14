set nocompatible
filetype off

set ttyfast

syntax enable
"Color関連
"set nocompatible				" vim
set background=dark			" 背景色の傾向(カラースキームがそれに併せて色の明暗を変えてくれる)
"source .vimrc.colors
":colorscheme molokai
"let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
:colorscheme solarized

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 追加プラグイン
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc'
" インデントに色を付けて見やすくする
" NeoBundle 'nathanaelkane/vim-indent-guides'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------


" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
" let g:indent_guides_enable_on_vim_startup = 1

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black


set textwidth=0 " 一行に長い文章を書いていても自動折り返しをしない
set autoread " 他で書き換えられたら自動で読み直す
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions=lmoq " テキスト整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする

set showmatch " 括弧の対応をハイライト
set number " 行番号表示

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/


set autoindent " 自動でインデント
"set paste " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set smartindent " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent " Cプログラムファイルの自動インデントを始める
set ruler " ルーラーの表示

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0

if has("autocmd")
	"ファイルタイプの検索を有効にする
	filetype plugin on
	"そのファイルタイプにあわせたインデントを利用する
	filetype indent on
	" これらのftではインデントを無効に
	"autocmd FileType php filetype indent off

	autocmd FileType html :set indentexpr=
	autocmd FileType xhtml :set indentexpr=
endif

set wrapscan " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase " 混在していたら大文字小文字を区別する
set incsearch " インクリメンタルサーチ
set hlsearch " 検索文字をハイライト


" 0, 9で行頭、行末へ
nmap 1 0
nmap 0 ^
nmap 9 $

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap :set iminsert=0

" OSのクリップボードを使用する
set clipboard+=unnamed

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed

" Enable mouse support.
set mouse=a
set guioptions+=a

" For screen.
if &term =~ "^screen"
	augroup MyAutoCmd
		autocmd VimLeave * iminsert=0 mouse=
	augroup END

	" screenでマウスを使用するとフリーズするのでその対策
	set ttymouse=xterm2
endif

if has('gui_running')
	" Show popup menu if right click.
	set mousemodel=popup

	" Don't focus the window when the mouse
	pointer is moved.
	set nomousefocus
	" Hide mouse pointer on insert
	mode.
	set mousehide
endif


"Esc2回でハイライト解除
nmap <ESC><ESC> :nohlsearch<CR><ESC>

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis
set fileencoding=utf-8


"Python コメント時のタブ消失細作
au BufEnter *.py setlocal indentkeys+=0#

"ノーマルモードではセミコロンをコロンに。
nnoremap ; :

set fileformats=unix,dos,mac

" neocomplcache + vim-endwise
function! s:my_crinsert()
    return pumvisible() ? neocomplcache#close_popup() : "\<Cr>"
endfunction
inoremap <silent> <CR> <C-R>=<SID>my_crinsert()<CR>

" :let mapleader = "_"

" unite prefix key
nnoremap [unite] <Nop>
nmap <Space>u [unite]
" mappings
nnoremap [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap [unite]f :<C-u>Unite<Space>file<CR>
nnoremap [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap [unite]a :<C-u>Unite buffer file file_mru bookmark<CR>
nnoremap [unite]r :<C-u>Unite<Space>register<CR>
nnoremap [unite]R :<C-u>UniteResume<CR>
