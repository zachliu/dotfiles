" Author: Zach Liu <zach.z.liu@gmail.com>
"
" Notes:
"   * To toggle sections below, scroll over a folded section and type 'za'
"     when in Normal mode.
" Additional Notes --------- {{{
"
" This is my .vimrc. I use Linux Mint 18.2.
" My workflow is terminal-based, so I use this with vim-nox.
"
" PreRequisites:
"   To get the most out of this vimrc, please install the following
"   system dependencies. This may not be comprehensive, but represents
"   some basics I believe everyone should have that you might not have
"   by default on a modern Ubuntu-based OS:
"   * git && build-essential && curl
"   * nodejs && npm
"   * rust && cargo
"   * exuberant-ctags
"
" Installation:
"   1. Put file in correct place within filesystem
"     If using Vim, soft-link this file to ~/.vimrc
"     If using NeoVim, soft-link this file to ~/.config/nvim/init.vim
"   2. Install Vim-Plug (a great plugin manager)
"     As of August 20, 2017, you just need to run this command:
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   3. Open vim (hint: type vim at command line and press enter :p)
"   4. :PlugInstall
"   5. :PlugUpdate
"   6. :PlugUpgrade
"
" TextObjectSelection:
" object-select OR text-objects
" delete the inner (...) block where the cursor is.
" dib ( or 'di(' )
" -----------------------------------------------------------
" SystemCopy:
" The default mapping is cp, and can be followed by any motion or text object.
" For instance:

" cpiw => copy word into system clipboard
" cpi' => copy inside single quotes to system clipboard
" In addition, cP is mapped to copy the current line directly.

" The sequence cv is mapped to paste the content of system clipboard
" to the next line.
" -----------------------------------------------------------
"  Folding:
"  zi: toggles everything
"  za: toggles the current section
" -----------------------------------------------------------
" ParenInsertion:
" There are 3 ways
" 1. use Ctrl-V ) to insert paren without trigger the plugin.
" 2. use Alt-P to turn off the plugin.
" 3. use DEL or <C-O>x to delete the character insert by plugin.
"
" QuickfixAndLocationList:
" ccl: close quickfix (my abbreviation: cc)
" cw: open quickfix if there is anything to open
" lcl: close location list (my abbreviation: lc)
" lw: open location list if there is anything to open
"
" InsertModeEditing:
" TLDR
"   :help insert-index
" CTRL-H   delete the character in front of the cursor
" CTRL-W   delete the word in front of the cursor
" CTRL-U   delete all characters in front of the cursor
" CTRL-L   delete character under cursor (I create this in general remappings)

" }}}
" General: Leader mappings -------------------- {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" General: global config ------------ {{{

"A comma separated list of options for Insert mode completion
"   menuone  Use the popup menu also when there is only one match.
"            Useful when there is additional information about the
"            match, e.g., what file it comes from.

"   longest  Only insert the longest common text of the matches.  If
"            the menu is displayed you can use CTRL-L to add more
"            characters.  Whether case is ignored depends on the kind
"            of completion.  For buffer text the 'ignorecase' option is
"            used.

"   preview  Show extra information about the currently selected
"            completion in the preview window.  Only works in
"            combination with 'menu' or 'menuone'.
set completeopt=menuone,longest,preview

" Enable buffer deletion instead of having to write each buffer
set hidden

" Mouse: remove GUI mouse support
" This support is actually annoying, because I may occasionally
" use the mouse to select text or something, and don't actually
" want the cursor to move
set mouse=""

" Automatically change directory to current file
set autochdir

" SwapFiles: prevent their creation
set nobackup
set noswapfile

" Do not wrap lines by default
set nowrap

" Set column to light grey at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" Don't highlight all search results
set nohlsearch

" Remove query for terminal version
" This prevents un-editable garbage characters from being printed
" after the 80 character highlight line
set t_RV=

filetype plugin indent on

augroup cursorline_setting
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

set spelllang=en_us

set showtabline=2

set autoread

" When you type the first tab hit will complete as much as possible,
" the second tab hit will provide a list, the third and subsequent tabs
" will cycle through completion options so you can complete the file
" without further keys
set wildmode=longest,list,full
set wildmenu

" Grep: program is 'git grep'
set grepprg=git\ grep\ -n\ $*

" AirlineSettings: specifics due to airline
set laststatus=2
set ttimeoutlen=50
set noshowmode

" Pasting: enable pasting without having to do 'set paste'
" NOTE: this is actually typed <C-/>, but vim thinks this is <C-_>
set pastetoggle=<C-_>

" Backspace setting
set backspace=indent,eol,start

" clipboard X setting
set clipboard=exclude:.*

" Turn off complete vi compatibility
set nocompatible

" }}}
" General: Plugin Install --------------------- {{{

call plug#begin('~/.vim/plugged')

" Basics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-rooter'
Plug 'qpkorr/vim-bufkill'
Plug 'christoomey/vim-system-copy'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dkprice/vim-easygrep'
Plug 't9md/vim-choosewin'
Plug 'mhinz/vim-startify'
Plug 'wincent/terminus'
Plug 'gcmt/taboo.vim'
Plug 'yssl/QFEnter'
Plug 'djoshea/vim-autoread'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'simeji/winresizer'
Plug 'vimwiki/vimwiki'
Plug 'justinmk/vim-sneak'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" Basic coloring
Plug 'NLKNguyen/papercolor-theme'

" Utils
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'jiangmiao/auto-pairs'

" Language-specific syntax
Plug 'derekwyatt/vim-scala',
Plug 'wting/rust.vim'
Plug 'hdima/python-syntax',
Plug 'autowitch/hive.vim'
Plug 'elzr/vim-json',
Plug 'vimoutliner/vimoutliner'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ElmCast/elm-vim'
Plug 'mopp/rik_octave.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'StanAngeloff/php.vim'
Plug 'vim-scripts/SAS-Syntax'
Plug 'neovimhaskell/haskell-vim'
Plug 'aklt/plantuml-syntax'
Plug 'NLKNguyen/c-syntax.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'
Plug 'lervag/vimtex'

" Autocompletion
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install'  }  " for javascript
" Additional requirements:
"   ln -s /home/sroeca/configsettings/.tern-project /home/sroeca/.tern-project
Plug 'Rip-Rip/clang_complete'
Plug 'eagletmt/neco-ghc'

" Tagbar
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'
" Additional requirements
"   sudo npm install -g jsctags
"   sudo apt install -y php

" Indentation
Plug 'hynek/vim-python-pep8-indent'
Plug 'Yggdroot/indentLine'

" Web Development - Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'groenewege/vim-less'
Plug 'heavenshell/vim-jsdoc'

" Web Development - General
Plug 'mattn/emmet-vim'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-ragtag'

" Rainbow
Plug 'junegunn/rainbow_parentheses.vim'

" Writing
Plug 'dkarter/bullets.vim'

call plug#end()

" }}}
" General: Filetype specification ------------ {{{

augroup filetype_recognition
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown set filetype=markdown
  autocmd BufNewFile,BufRead,BufEnter *.hql,*.q set filetype=hive
  autocmd BufNewFile,BufRead,BufEnter *.config set filetype=yaml
  autocmd BufNewFile,BufRead,BufEnter *.bowerrc,*.babelrc,*.eslintrc
        \ set filetype=json
  autocmd BufNewFile,BufRead,BufEnter *.handlebars set filetype=html
  autocmd BufNewFile,BufRead,BufEnter *.m,*.oct set filetype=octave
  autocmd BufNewFile,BufRead,BufEnter *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,.pylintrc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
augroup END

augroup filetype_vim
  autocmd!
  autocmd BufWritePost *vimrc so $MYVIMRC |
        \ if has('gui_running') |
        \ so $MYGVIMRC |
        \ endif
augroup END

" }}}
" General: Indentation (tabs, spaces, width, etc)------------- {{{

" Note -> apparently BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosen with Filetype *
augroup indentation_sr
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python,c,elm,haskell,terraform,markdown
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>
augroup END

" }}}
" General: Writing (non-coding)------------------ {{{

" note: indenting and de-indenting in insert mode are:
"   <C-t> and <C-d>

augroup writing
  autocmd!
  autocmd FileType markdown :setlocal wrap linebreak nolist
  autocmd FileType markdown :setlocal colorcolumn=0
  autocmd BufNewFile,BufRead *.html,*.txt,*.tex :setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.html,*.txt,*.tex :setlocal colorcolumn=0
augroup END

" }}}
" General: Word definition and meaning lookup --- {{{

" Enable looking up values in either a dictionary or a thesaurus
" these are expected to be either:
"   Dict: dict-gcide
"   Thesaurus: dict-moby-thesaurus
function! ReadDictToPreview(word, dict) range
  let dst = tempname()
  execute "silent ! dict -d " . a:dict . " " . string(a:word) . " > " . dst
  pclose! |
        \ execute "silent! pedit! " . dst |
        \ wincmd P |
        \ set modifiable noreadonly |
        \ call append(0, 'This is a scratch buffer in a preview window') |
        \ set buftype=nofile nomodifiable noswapfile readonly nomodified |
        \ setlocal nobuflisted |
        \ wincmd p
  execute ":redraw!"
endfunction

command! -nargs=1 Def call ReadDictToPreview(<q-args>, "gcide")
command! -nargs=1 Syn call ReadDictToPreview(<q-args>, "moby-thesaurus")

 " }}}
" General: (relative) line number display ------------- {{{

function! ToggleRelativeNumber()
  if &rnu
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

function! RNUInsertEnter()
  if &rnu
    let w:line_number_state = 'rnu'
    set norelativenumber
  else
    let w:line_number_state = 'nornu'
  endif
endfunction

function! RNUInsertLeave()
  if w:line_number_state == 'rnu'
    set relativenumber
  else
    set norelativenumber
    let w:line_number_state = 'nornu'
  endif
endfunction

function! RNUWinEnter()
  if exists('w:line_number_state')
    if w:line_number_state == 'rnu'
      set relativenumber
    else
      set norelativenumber
    endif
  else
    set relativenumber
    let w:line_number_state = 'rnu'
  endif
endfunction

function! RNUWinLeave()
  if &rnu
    let w:line_number_state = 'rnu'
  else
    let w:line_number_state = 'nornu'
  endif
  set norelativenumber
endfunction

" autocmd that will set up the w:created variable
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1
set number relativenumber
augroup rnu_nu
  autocmd!
  "Initial window settings
  autocmd WinEnter * if !exists('w:created') |
        \ setlocal number relativenumber |
        \ endif
  " Don't have relative numbers during insert mode
  autocmd InsertEnter * :call RNUInsertEnter()
  autocmd InsertLeave * :call RNUInsertLeave()
  " Set and unset relative numbers when buffer is active
  autocmd WinEnter * :call RNUWinEnter()
  autocmd WinLeave * :call RNUWinLeave()
augroup end

" }}}
" General: Folding Settings --------------- {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux setlocal foldmethod=marker
  autocmd FileType vim,tmux setlocal foldlevelstart=0
  autocmd FileType * setlocal foldnestmax=1
  autocmd BufNewFile,BufRead .bashrc setlocal foldmethod=marker
  autocmd BufNewFile,BufRead .bashrc setlocal foldlevelstart=0
augroup END

" }}}
" General: Trailing whitespace ------------- {{{

" This section should go before syntax highlighting
" because autocommands must be declared before syntax library is loaded

function! TrimWhitespace()
  if &ft == 'markdown'
    return
  endif
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

highlight EOLWS ctermbg=red guibg=red
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  autocmd ColorScheme * highlight EOLWS ctermbg=red guibg=red
  autocmd InsertEnter * match EOLWS /\s\+\%#\@<!$/
  autocmd InsertLeave * match EOLWS /\s\+$/
augroup END

augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

" }}}
" General: Syntax highlighting ---------------- {{{

" Papercolor: options
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

" Python: Highlight self and cls keyword in class definitions
augroup python_syntax
  autocmd!
  autocmd FileType python syn keyword pythonBuiltinObj self
  autocmd FileType python syn keyword pythonBuiltinObj cls
augroup end

" Javascript: Highlight this keyword in object / function definitions
augroup javascript_syntax
  autocmd!
  autocmd FileType javascript syn keyword jsBooleanTrue this
  autocmd FileType javascript.jsx syn keyword jsBooleanTrue this
augroup end

" Syntax: select global syntax scheme
" Make sure this is at end of section
try
  set t_Co=256 " says terminal has 256 colors
  set background=dark
  colorscheme PaperColor
catch
endtry

hi CursorLine cterm=NONE

" }}}
" General: Resize Window --- {{{

" WindowWidth: Resize window to a couple more than longest line
" modified function from:
" https://stackoverflow.com/questions/2075276/longest-line-in-vim
function! ResizeWidthToLongestLine()
  let maxlength   = 0
  let linenumber  = 1
  while linenumber <= line("$")
    exe ":" . linenumber
    let linelength  = virtcol("$")
    if maxlength < linelength
      let maxlength = linelength
    endif
    let linenumber  = linenumber+1
  endwhile
  exe ":vertical resize " . (maxlength + 4)
endfunction

" }}}
" Plugin: Wiki --- {{{

" Wiki is only valid when in pre-defined wiki area
let g:vimwiki_global_ext = 0

" Define wikis
let wiki_personal = {}
let wiki_personal.index = 'main'
let wiki_personal.ext = '.md'
let wiki_personal.path = '~/Wiki/'

" Organize them in a list
let g:vimwiki_list = [wiki_personal]

" }}}
"  Plugin: Rainbow Parentheses --- {{{

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
augroup rainbow_settings
  " Section to turn on rainbow parentheses
  autocmd!
  autocmd BufEnter,BufRead * :RainbowParentheses
  autocmd BufEnter,BufRead *.html,*.css,*.jxs,*.js :RainbowParentheses!
augroup END

"  }}}
"  Plugin: NERDTree --- {{{

let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenInTabSilent = ''
let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCaseSensitiveSort = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortOrder = ['*', '\/$']
let g:NERDTreeIgnore=[
      \'venv$[[dir]]',
      \'__pycache__$[[dir]]',
      \'.egg-info$[[dir]]',
      \'node_modules$[[dir]]'
      \]
function! NERDTreeToggleCustom()
    if &filetype ==? 'startify'
      exec 'NERDTreeToggle'
    else
      if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
        " if NERDTree is open in window in current tab...
        exec 'NERDTreeClose'
      else
        exec 'NERDTree %'
      endif
    endif
endfunction

"  }}}
" Plugin: Ctrl p --- {{{

let g:ctrlp_mruf_relative = 1 " show only MRU files in the cwd
let g:ctrlp_user_command = [
      \'.git',
      \'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0
let g:ctrlp_switch_buffer = 0

" Cycles through windows until it finds a modifiable buffer
" First checks if startify and runs command if so
" it then runs ctrl-p there
" if there are no modifiable buffers, it does not run control p
" this prevents ctrl-p from opening in NERDTree, QuickFix, or other
function! CtrlPCommand()
    let current_window_number = 0
    let total_window_number = winnr('$')
    if &filetype ==? 'startify'
      exec 'CtrlPCurWD'
      return
    endif
    while !&modifiable && current_window_number < total_window_number
        exec 'wincmd w'
        let current_window_number = current_window_number + 1
    endwhile
    if current_window_number < total_window_number
      exec 'CtrlPCurWD'
    endif
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'

" }}}
" Plugin: Airline ---------------- {{{

let g:airline_theme='powerlineish'
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#whitespace#checks = []
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.spell = 'Ꞩ'

function! CustomAirlineDisplayPath()
  " get filepath relative to cwd
  let cwd = getcwd()
  return substitute(expand("%:p"), l:cwd . "/" , "", "")
endfunction
let g:airline_section_c = airline#section#create(
      \['%{CustomAirlineDisplayPath()}'])
let g:airline_section_x = airline#section#create(['%c:%L'])
let g:airline_section_y = airline#section#create(['ffenc'])
let g:airline_section_z = airline#section#create(['filetype'])
let g:airline_powerline_fonts = 1
let g:airline_inactive_collapse=0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'ℕ',
    \ 'i'  : 'ⅈ',
    \ 'R'  : 'ℛ',
    \ 'c'  : 'ℂ',
    \ 'v'  : '℣',
    \ 'V'  : '℣',
    \ '' : '℣',
    \ 's'  : '₷',
    \ 'S'  : '₷',
    \ '' : '₷',
    \ }

" }}}
"  Plugin: Tagbar ------ {{{
let g:tagbar_map_showproto = '`'
let g:tagbar_show_linenumbers = -1
let g:tagbar_autofocus = 1
let g:tagbar_indent = 1
let g:tagbar_sort = 0  " order by order in sort file
let g:tagbar_case_insensitive = 1
let g:tagbar_width = 37
let g:tagbar_silent = 1
let g:tagbar_foldlevel = 0
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

"  }}}
" Plugin: Startify ------------ {{{

let g:startify_list_order = ['dir', 'files', 'bookmarks', 'sessions',
      \ 'commands']
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 2
let g:startify_custom_header = [
      \ '      ___________       __                            .__',
      \ '      \_   _____/ _____/  |_  ________________________|__| ______ ____',
      \ '       |    __)_ /    \   __\/ __ \_  __ \____ \_  __ \  |/  ___// __ \',
      \ '       |        \   |  \  | \  ___/|  | \/  |_> >  | \/  |\___ \\  ___/',
      \ '      /_______  /___|  /__|  \___  >__|  |   __/|__|  |__/____  >\___  >',
      \ '              \/     \/          \/      |__|                 \/     \/',
      \ '',
      \ ' \++================================|                    _=_',
      \ '  \_________________________________/              ___/==+++==\___',
      \ '               """\__      \"""       |======================================/',
      \ '                     \__    \_          / ..  . _/--===+_____+===--""',
      \ '                        \__   \       _/.  .. _/         `+`',
      \ '                           \__ \   __/_______/                      \ /',
      \ '                          ___-\_\-`---==+____|                  ---==O=-',
      \ '                    __--+" .    . .        "==_                     / \',
      \ '                    /  |. .  ..     -------- | \',
      \ '                    "==+_    .   .  -------- | /',
      \ '                         ""\___  . ..     __=="',
      \ '                               """"--=--""',
      \] + map(startify#fortune#boxed(), {idx, val -> ' ' . val})


" }}}
"  Plugin: Terraform Syntax --- {{{

let g:terraform_align=1
" Use spacebar to fold/unfold resources
let g:terraform_remap_spacebar=1

" }}}
" Plugin: Miscellaneous global var config ------------ {{{

" Agit:
let g:agit_max_log_lines = 500

" UndoTree:
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3

" VimRooter:
let g:rooter_manual_only = 1

" VimTex:
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:tex_flavor = 'latex'

" PythonVirtualenv:
" necessary for jedi-vim to discover virtual environments
let g:virtualenv_auto_activate = 1

" QFEnter:
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>']
let g:qfenter_keymap.topen = ['<C-t>']
" do not copy quickfix when opened in new tab
let g:qfenter_enable_autoquickfix = 0

" WinResize:
let g:winresizer_start_key = '<C-E>'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" Taboo:
" Tab format hardcoded to main for now since I often do this anyway
let g:taboo_tab_format = ' [%N:tab]%m '
let g:taboo_renamed_tab_format = ' [%N:%l]%m '

" Haskell: 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to highlight `forall`
let g:haskell_enable_recursivedo = 1      " to highlight `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to highlight `proc`
let g:haskell_enable_pattern_synonyms = 1 " to highlight `pattern`
let g:haskell_enable_typeroles = 1        " to highlight type roles
let g:haskell_enable_static_pointers = 1  " to highlight `static`

" Python: highlighting
" Must be set to 1, otherwise TrailingWhitespace is completely messed up
let g:python_highlight_all = 1

" Ragtag: on every filetype
let g:ragtag_global_maps = 1

" VimJavascript:
let g:javascript_plugin_flow = 1

" JSX: for .js files in addition to .jsx
let g:jsx_ext_required = 0

" JsDoc:
let g:jsdoc_enable_es6 = 1

" EasyGrep: - use git grep
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match

" IndentLines:
let g:indentLine_enabled = 1  " indentlines disabled by default

" VimMarkdown:
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let g:vim_markdown_conceal = 0

" BulletsVim:
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]

" AutoPairs:
" unmap CR due to incompatibility with clang-complete
let g:AutoPairsMapCR = 0
let g:AutoPairsMapCh = 0  "Do not map <C-h> to delete brackets, quotes in pair

"  }}}
"  Plugin: AutoCompletion config, multiple plugins ------------ {{{

" NOTE: General remappings
" 1) go to file containing definition: <C-]>
" 2) Return from file (relies on tag stack): <C-O>

" Python
" Open module, e.g. :Pyimport os (opens the os module)
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#auto_close_doc = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#use_tabs_not_buffers = 1

" mappings
" auto_vim_configuration creates space between where vim is opened and
" closed in my bash terminal. This is annoying, so I disable and manually
" configure. See 'set completeopt' in my global config for my settings
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#documentation_command = "<leader>sd"
let g:jedi#usages_command = "<leader>su"
let g:jedi#rename_command = "<leader>sr"

" Javascript
let g:tern_show_argument_hints = 1
let g:tern_show_signature_in_pum = 1
augroup javascript_complete
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>
augroup END

" C++
" Jumping back defaults to <C-O> or <C-T>
" Defaults to <C-]> for goto definition
let g:clang_library_path = '/usr/lib/llvm-3.8/lib'
let g:clang_auto_user_options = 'compile_commands.json, path'
let g:clang_complete_auto = 0

" Haskell
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
augroup haskell_complete
  autocmd!
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

"  }}}
" General: Dict lookup --- {{{

" Enable looking up values in either a dictionary or a thesaurus
" these are expected to be either:
"   Dict: dict-gcide
"   Thesaurus: dict-moby-thesaurus
function! ReadDictToPreview(word, dict) range
  let dst = tempname()
  execute "silent ! dict -d " . a:dict . " " . string(a:word) . " > " . dst
  pclose! |
        \ execute "silent! pedit! " . dst |
        \ wincmd P |
        \ set modifiable noreadonly |
        \ call append(0, 'This is a scratch buffer in a preview window') |
        \ set buftype=nofile nomodifiable noswapfile readonly nomodified |
        \ setlocal nobuflisted |
        \ wincmd p
  execute ":redraw!"
endfunction

command! -nargs=1 Def call ReadDictToPreview(<q-args>, "gcide")
cabbrev def Def
command! -nargs=1 Syn call ReadDictToPreview(<q-args>, "moby-thesaurus")
cabbrev syn Syn

" }}}
" General: Key remappings ----------------------- {{{

" Omnicompletion:
" imap <C-space> <C-x><C-o>
" <C-@> is actually <C-space>
inoremap <C-@> <C-x><C-o>
inoremap <C-space> <C-x><C-o>

" Exit: Preview and Help
inoremap <silent> <C-c> <Esc>:pclose <BAR> helpclose<CR>a
nnoremap <silent> <C-c> :pclose <BAR> helpclose<CR>
inoremap <silent> <C-q> <Esc>:cclose <BAR> lclose<CR>a
nnoremap <silent> <C-q> :cclose <BAR> lclose<CR>

" MoveVisual: up and down visually only if count is specified before
" Otherwise, you want to move up lines numerically
" e.g. ignoring wrapped lines
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
" Move to beginning and end of visual line
" nnoremap 0 g0
" nnoremap $ g$
" moving forward and backward with vim tabs
nnoremap T gt
nnoremap t gT

" Insert Mode moves
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>

inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I

" IndentComma: placing commas one line down
" usable with repeat operator '.'
nnoremap <silent> <Plug>NewLineComma f,wi<CR><Esc>
      \:call repeat#set("\<Plug>NewLineComma")<CR>
nmap <leader><CR> <Plug>NewLineComma

" WindowHeight: Resize window to one more than window height
nnoremap <silent> <leader>h gg:exe "resize " . (line('$') + 1)<CR>

" BuffersAndWindows:
" Move from one window to another
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
" Scroll screen up and down
nnoremap <silent> K <c-e>
nnoremap <silent> J <c-y>
nnoremap <silent> H zh
nnoremap <silent> L zl
" Move cursor to top, bottom, and middle of screen
nnoremap <silent> gJ L
nnoremap <silent> gK H
nnoremap <silent> gM M

" VisualSearch: * and # work in visual mode too
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" QuickChangeFiletype:
" Sometimes we want to set some filetypes due to annoying behavior of plugins
" The following mappings make it easier to chage javascript plugin behavior
nnoremap <leader>jx :set filetype=javascript.jsx<CR>
nnoremap <leader>jj :set filetype=javascript<CR>

" ToggleRelativeNumber: uses custom functions
nnoremap <silent><leader>r :call ToggleRelativeNumber()<CR>

" TogglePluginWindows:
nnoremap <silent> <space>j :call NERDTreeToggleCustom()<CR>
nnoremap <silent> <space>l :TagbarToggle <CR>
nnoremap <silent> <space>u :UndotreeToggle<CR>

" Choosewin: (just like tmux)
nnoremap <leader>q :ChooseWin<CR>

" VimFugitive: git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>g. :Git add .<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>

" IndentLines: toggle if indent lines is visible
nnoremap <silent> <leader>i :IndentLinesToggle<CR>

" ResizeWindow: up and down; relies on custom function
" height
nnoremap <silent> <leader><leader>h gg:exe "resize " . (line('$') + 1)<CR>
" width
nnoremap <silent> <leader><leader>w mz:call ResizeWidthToLongestLine()<CR>`z

" AutoPairs:
imap <silent><CR> <CR><Plug>AutoPairsReturn

" VimSneak: remap f and F to the sneak command
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S

" }}}
" General: Command abbreviations ------------------------ {{{

" changing directories
cabbrev r Rooter
cabbrev f cd %:p:h

" abbreviate creating tab, vertical, and horizontal buffer splits
cabbrev bt tab sb
cabbrev bv vert sb
cabbrev bs sbuffer

" make it easier to type TabooRename
cabbrev : TabooRename

" fix misspelling of ls
cabbrev LS ls
cabbrev lS ls
cabbrev Ls ls

" fix misspelling of vs and sp
cabbrev SP sp
cabbrev sP sp
cabbrev Sp sp
cabbrev VS vs
cabbrev vS vs
cabbrev Vs vs

" echo current file path
cabbrev fp echo expand('%:p')

" Plug update and upgrade
cabbrev pu PlugUpdate <BAR> PlugUpgrade

" }}}
" General: Cleanup ------------------ {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" }}}
