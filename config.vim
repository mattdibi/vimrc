" Vundle config
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" Eye-candy plugins
Plugin 'liuchengxu/space-vim-dark' " Colorscheme
Plugin 'challenger-deep-theme/vim' " Colorscheme
Plugin 'itchyny/lightline.vim'     " Stylish statusline
Plugin 'airblade/vim-gitgutter'    " In-editor git diffs
Plugin 'markonm/traces.vim'        " Range, pattern and substitute preview (requires 8.0.1206+)
Plugin 'camspiers/animate.vim'     " Window animation library
Plugin 'camspiers/lens.vim'        " Automatic resize of active window (integrates with animate.vim)

" Navigation
Plugin 'tpope/vim-vinegar'         " Netwr enchancer
Plugin 'tpope/vim-projectionist'   " Project navigation

" Autocompletion
Plugin 'valloric/youcompleteme'  " Code autocompletion
"Plugin 'zxqfl/tabnine-vim'       " Deep learning code autocompletion
Plugin 'SirVer/ultisnips'        " Snippets engine

" Basics
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rhysd/vim-clang-format'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Colorscheme
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" Challenger deep
colorscheme challenger_deep
let g:lightline = { 'colorscheme': 'challenger_deep'}

" Space vim dark
" colorscheme space-vim-dark
" let g:lightline = { 'colorscheme': 'Dracula' }

" Common
syntax enable
set noswapfile        " Do not create swap files
set number            " Display line numbers
set relativenumber    " Line numbers are relative to current line
set showcmd           " Show typed commands
set showmatch         " Show matching parenthesis
set cmdheight=1       " Command line height
set cursorline        " Highlight current line

set undofile          " Maintain undo history between sessions
set undodir=~/.vim/undodir " Undo history directory

set autoread          " Autoload file changes. You can undo by pressing u.
set wildmenu          " Visual autocomplete for command menu
set laststatus=2      " Always diplay status bar
set noshowmode        " Don't show current vim mode
set updatetime=250    " Update time 250ms

set backspace=indent,eol,start " Backspace through lines

" <Space> and \ are now leader keys, this way
" something will pop up in the showcmd corner.
map <Space> <leader>

" Uncomment the following to have Vim jump to the last position when ropening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Smart resize
nnoremap <Up>    :resize +5<CR>
nnoremap <Down>  :resize -5<CR>
nnoremap <Left>  :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" Search
set ignorecase
set smartcase
set incsearch         " Start searching before pressing enter
set nows              " Once hitting the search bottom it stops instead of restarting from the first match

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"Formatting
set breakindent       " Wrap lines without changing the amount of indent. VIM 8 only!
set autoindent        " Auto indentation. To paste use paste mode: :set paste
set wrap              " Wrap long lines
set shiftwidth=4      " Use indents of 4 spaces
set expandtab         " Tabs are spaces, not tabs
set tabstop=4         " An indentation every four columns
set nojoinspaces      " Prevents inserting two spaces after punctuation on a join (J)
set splitright        " Puts new vsplit windows to the right of the current
set splitbelow        " Puts new split windows to the bottom of the current

" MatchIt
" Installation for Vim 8
packadd! matchit
" Installation for Vim 7 and older
" runtime macros/matchit.vim

" Function row mode toggle hotkeys
" F3: Toggle list char
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
nnoremap <F3> :set list!<CR>

" F4: Switch between source and header file
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" F5: Toggle paste mode
set pastetoggle=<F5>

" YCM configuration
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

nnoremap <leader>g  :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>t  :YcmCompleter GetType<CR>
nnoremap <leader>d  :YcmCompleter GetDoc<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
nnoremap <leader>r  :YcmForceCompileAndDiagnostics<CR>

" Ultisnips configuration
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Ultisnips folder
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/custom_snippets/']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Clang-format
let g:clang_format#code_style = "google"

" C++
" ;g generates the C++ header guard
autocmd Filetype c,h,hpp,cc,cpp map ;g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" Copies search matches inside register
" :CopyMatches reg
function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" make
autocmd Filetype c,h,hpp,cc,cpp set makeprg=make\ -C\ ~/Scrivania/pcn_v2/PCN/build

" Latex :make command
autocmd Filetype tex set makeprg=pdflatex\ %\ \-file\-line\-error\ \-interaction=nonstopmode
autocmd Filetype tex set errorformat=%f:%l:\ %m
" Latex accented characters
autocmd Filetype tex inoremap è \`e
autocmd Filetype tex inoremap é \'e
autocmd Filetype tex inoremap ò \`o
autocmd Filetype tex inoremap à \`a
autocmd Filetype tex inoremap ù \`u
autocmd Filetype tex inoremap ì \`\i\

" Run current python file
autocmd Filetype python map <F2> :!python3 %<CR>
