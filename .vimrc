" This is a list of directories which will be searched
" for runtime files:
set runtimepath=~/.vim,~/.vim/after,~/.vimtest,$VIMRUNTIME

" Vim defaults, not Vi
set nocompatible

" Enable file type detection
filetype on

" Enable plugins for specific file types
filetype plugin on

" Enable loading the indent file for specific file types
"filetype indent on

" Dont like *.swp files
set nobackup

" Buffers (I want to change betwen buffers unsaved!)
set hidden

" Welcome to the 21st century
set encoding=utf-8

" Colors
if has('syntax') && &t_Co > 2

    " Enable 256 colors?
    if &term == "xterm-color" || &term == "xterm"
        set t_Co=256
        colorscheme notangotan
    else
        colorscheme default
    endif

    " Syntax Highlighting
    syntax on

endif

" Auto char comment in new line
set formatoptions+=r

" Always show a status line
set laststatus=2
set statusline=%<[%n]\ %F\ %y\ %r\ %1*%m%*%w%=%-10(%l,%c%V%)\ %P/%-6L\ HEX=%-4(%B%)

" Show line numbers
set number

" Mark trailing white space
" (very useful to see no printable characters)
set list listchars=tab:›\ ,trail:·,eol:¬

" Show matching brackets/parenthesis
set showmatch

" Code folders
set foldmethod=marker
"set foldmethod=expr

" Turn on auto/smart indenting
set autoindent
set nosmartindent

" Make <tab> and <backspace> smarter
set smarttab

" Spaces for <tab>
set tabstop=4
set shiftwidth=4

" Use spaces, no tabs
set expandtab

" Ignore case in searchs
set ignorecase

" Highligh all search matches
set hlsearch

" Show search as you type
set incsearch

" Not beep
set vb


" ============================================================================
" Sets by filetype
" ============================================================================
autocmd FileType python set omnifunc=pythoncomplete#Complete ai et ts=4 sts=4 sw=4 cc=80
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP ai et ts=4 sts=4 sw=4
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType snippet set nofoldenable syntax=off
autocmd FileType taskpaper set nonu ts=2 sw=2 et
autocmd FileType vimwiki set nonu ts=2 sw=2 et
autocmd FileType lua set omnifunc=luacomplete#Complete ai et ts=4 sts=4 sw=4

" Twig
autocmd BufNewFile,BufRead *.twig set filetype=html.twig
" Arduino
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp


" ============================================================================
" Python comments (#)
" ============================================================================
:map <silent> <C-c> :.s/^ \?/\1#/ \| :nohls<CR>
:map <silent> <C-x> :.s/^#\+/ / \| :nohls<CR>

" Execute current python file
"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>


" ============================================================================
" Auto completion
" ============================================================================
" :help ins-completion

" Omni-Completion: C-Space in place of C-x C-o
" python: .vim/autoload/pythoncomplete.vim
inoremap <Nul> <C-x><C-o>
set completeopt=menuone,preview,longest

" Dictionary word completion: C-x C-k
"set dictionary+=/usr/share/dict/words
"set dictionary+=/usr/share/dict/spanish

" Thesaurus word replacement: C-x C-t
"set thesaurus+=~/.vim/mthesaur.txt


" ============================================================================
" Load tags by project
" ============================================================================
if match(getcwd(), '/var/olx/billing') == 0
    set tags=/var/olx/billing/src/tags
endif
if match(getcwd(), '/var/olx/siteadmin/trunk/admin/olx/FeaturedAd') == 0
    set tags=/var/olx/siteadmin/trunk/admin/olx/FeaturedAd/src/tags
endif
if match(getcwd(), '/var/olx/site/trunk') == 0
    set tags=/var/olx/site/trunk/tags
endif


" ############################################################################
" BEGIN PLUGINS
" ############################################################################


" ============================================================================
" TagList <taglist_46.zip> v4.6 [2013-02-27]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=273
" :help Tlist

map <F2> :TlistToggle<CR>


" ============================================================================
" NERDTree <NERDTree.zip> v4.2.0 [2011-12-28]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=1658
" :help NERDTree

map <F3> :NERDTreeToggle<CR>
"map <silent> <C-e> :NERDTreeToggle<CR>

" NERDTree window width by hostname (different screen resolution)
if hostname() == 'howl'
	let g:NERDTreeWinSize = 20
else
	let g:NERDTreeWinSize = 40
endif

" NERDTree window position
let g:NERDTreeWinPos = "right"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Ignore files
let NERDTreeIgnore=['\.pyc$', '\~$']


" ============================================================================
" Bclose <bclose.vim>
" ============================================================================
" http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window

" :Bclose
" :Bclose N
" :Bclose <name>

" By default, :Bclose will close a buffer even if it is displayed in multiple
" windows (the windows are not closed). Put the following in your vimrc if you
" would prefer that a buffer is not closed if it is displayed more than once:
"
" :let bclose_multiple = 0
"
" Default : \bc

" Save on exit
"set autowriteall

" Buffers
nmap <C-n> :bnext!<CR>
nmap <C-p> :bprevious!<CR>

cnoremap qq Bclose


" ============================================================================
" snipMate <snipMate.zip> v0.83 [2009-07-13]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=2540
" :help snipMate
"
" Use :set ft=html.css
" to activate snippets for both HTML and CSS for the current file.

let g:snips_author = 'Leonardo Vidarte'


" ============================================================================
" FuzzyFinder : buffer/file/command/tag/etc explorer with fuzzy matching
" <vim-fuzzyfinder.zip> v.4.2.2 [2010-09-30]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=1984

" Plugin loaded from ~/.vimtest (see runtimepath)

nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFile<CR>


" ============================================================================
" Efficient python folding : Fold python code nicely and toggle with one keyst
" <python_editing.vim> v.1.1 [2006-03-28]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=1494


" ============================================================================
" pyflakes.vim : PyFlakes on-the-fly Python code checking
" <pyflakes-vim.zip> v.3.01 [2010-11-30]
" ============================================================================
" http://www.vim.org/scripts/script.php?script_id=2441


" ============================================================================
" AutoClose.vim : This plugin enable an auto-close chars feature for you
" ============================================================================
" http://townk.github.io/vim-autoclose/


" ############################################################################
" END PLUGINS
" ############################################################################


" ============================================================================
" MAPPING
" ============================================================================
" :help keycodes

"cmap W w
"cmap Q q
"cmap WQ wq

" Jump to another window
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Now I have not C-j for join
nmap <C-i> :join<CR>

" Resize window
nmap <S-j> <C-w>+
nmap <S-k> <C-w>-
nmap <S-h> <C-w><
nmap <S-l> <C-w>>

" Check php file syntax
map <C-b> :! php -l %<CR>

" Underline actual line
nmap <silent> <C-_> :set cursorline!<CR>

" Highlight actual column
nmap <silent> ,cc :set cursorcolumn!<CR>

" Save as sudo
ca w!! w !sudo tee "%"


" ============================================================================
" ABBREVIATES
" ============================================================================
" ab[breviate] list abbreviate (i:insert mode, c:command line, !:both)
" unab[breviate] unset abbreviate
" ia[bbrev] same as :ab, but for Insert mode only 
" ca[bbrev] same as :ab, but for Command-line mode only 
iab _name Leonardo Vidarte
iab _signature Leonardo Vidarte <lvidarte@gmail.com>
iab _date <C-r>=strftime("%Y-%b-%d")<CR>
iab _datetime <C-r>=strftime("%Y/%m/%d %H:%M:%S")<CR>
iab _die  $_=&$_;die(sprintf("<pre>%s:%d\n%s</pre>",__FILE__,__LINE__,print_r($_,true)));
iab _lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nulla risus, iaculis sed pulvinar ac, tristique vitae augue. Ut tempor luctus ultrices. Sed vitae elit risus, nec adipiscing felis. In hac habitasse platea dictumst. Vivamus porta risus vel mi blandit nec tempus purus tempor. Ut id magna mauris, sed porttitor arcu. Vestibulum dignissim quam quis tellus dignissim tincidunt. Nunc in lectus et sapien auctor tempus. Nulla a orci eget nisl adipiscing facilisis id nec nisl. Nullam eget justo vitae arcu ullamcorper porta ultricies quis orci. Sed varius porta purus, et laoreet urna porttitor in. Proin non feugiat nunc. Aliquam laoreet arcu urna, in placerat nisi. Curabitur pretium, libero non malesuada fermentum, massa velit congue justo, luctus cursus lorem enim at nisl.


" ============================================================================
" MOUSE
" ============================================================================
" The mouse can be enabled for different modes:
"    n Normal mode
"    v Visual mode
"    i Insert mode
"    c Command-line mode
"    h all previous modes when editing a help file
"    a all previous modes
"    r for |hit-enter| and |more-prompt| prompt
set mouse=n


" ============================================================================
" HowTo
" ============================================================================
" Add help
" :helptags .vim/doc
"
" Install vimball (.vba)
" 1. edit vimball and :source %
" 2. :UseVimball PATH
" Uninstall vimball
" 1. :RmVimball VIMBALLNAME

" Useful VIM Settings for working with Python:
" http://py.vaults.ca/~x/python_and_vim.html
"
" # vim{colon} ai ts=4 sts=4 et sw=4
"
" set all (display all options)
" set (display current settings of options)
