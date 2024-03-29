" 文字コードの自動認識
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf8
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

set laststatus=2
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"---------------------------------------
" 日本語関連
"---------------------------------------
" IMEが自動でONになるのを防ぐ
set iminsert=0    "入力モード時
set imsearch=0    "検索時

"---------------------------------------
" 一般
"---------------------------------------
" VI非互換モード
set nocompatible

"---------------------------------------
" 一般:挙動
"---------------------------------------
" スクロール時の余白確保
set scrolloff=5

" バックスペースでインデントや改行を削除できるようにする
set backspace=2

" バックアップ
set nobackup

"---------------------------------------
" 一般:キーバインド
"---------------------------------------
" 常に物理的行移動
nmap j g<Down>
nmap k g<Up>

" ghでハイライトのON/OFF
nmap gh :set hlsearch!<cr>
" glでタブ・改行のON/OFF
nmap gl :set list!<cr>

nnoremap <C-m>   :bn<cr>
nnoremap <C-n>   :bp<cr>
nnoremap <C-c>   :badd<Space>
nnoremap <C-d>   :bd<CR>

nmap U :set fileencoding=utf-8<cr>
nmap ,8 :e ++enc=utf8<cr>
nmap ,r :%s/ >/ )/<cr>:%s/ </ (/<cr>:%s/> /) /<cr>:%s/< /( /<cr>:%s/@.*\..*)/@)/<cr>
" <C-n>でOmni補完
imap <C-n> <C-x><C-o>
" <C-e>をEscに
imap <C-e> <Esc>

"---------------------------------------
" 一般:表示
"---------------------------------------
syntax on

set title     " タイトル
set number    " 行番号
set ruler     " ルーラ
set list      " タブや改行

set showmatch " 括弧の対応表示
set showcmd   " コマンドをステータスに表示

set wrap      " 折り返し表示

set hidden    " 複数バッファ開いたとき、保存せずに他のバッファに移れる
"---------------------------------------
" Tab/Space:表示
"---------------------------------------
" タブをスペースに展開
set expandtab
set tabstop=2      "space/tab
set shiftwidth=2   "自動インデント時のスペース量
set softtabstop=0  "キーボードからタブを押したとき(0の場合はts)
"set expandtab

" listの表示
set listchars=tab:>-,extends:<,trail:-

"---------------------------------------
" 検索:表示
"---------------------------------------
" 検索結果をハイライト
set hlsearch

"---------------------------------------
" 検索:挙動
"---------------------------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase
" インクリメンタルサーチ
set incsearch
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan

"--------------------------------------
" プラグイン
"--------------------------------------
set fencs=usc-bom,usc-21e,usc-2,iso-2022-jp-3,utf-8
set fencs+=cp932
set paste
set autoindent
set cindent
set expandtab
set tabstop=4
set shiftwidth=4
