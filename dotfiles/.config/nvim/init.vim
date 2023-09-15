" Usage: toggle fold in Vim with 'za'. 'zR' to open all folds, 'zM' to close
" General: options {{{

" Enable filetype detection, plugin loading, and indentation loading
filetype plugin indent on

" Code Completion:
set completeopt=menuone,longest wildmode=longest,list,full wildmenu

" Messages:
" c = don't give |ins-completion-menu| messages; they're noisy
" I = ignore startup message
set shortmess+=c shortmess+=I

" K will lookup words from the english dictionary for all files
set keywordprg=:DefEng

" Hidden Buffer: enable instead of having to write each buffer
set hidden

" Sign Column: show it automatically
set signcolumn=auto

set cursorline

" Mouse: enable GUI mouse support in all modes
set mouse=a

" SwapFiles: prevent their creation
set noswapfile

" Command Line Height: higher for display for messages
set cmdheight=1

" Line Wrapping: do not wrap lines by default
set nowrap linebreak

" Indentation:
set expandtab autoindent smartindent shiftwidth=2 softtabstop=2 tabstop=8

" Filename: for gf (@-@='@', see: https://stackoverflow.com/a/45244758)
set isfname+=@-@ isfname+=:

" Highlight Search:
" note: hlsearcha nd nohlsearch are defined in autocmd outside function
set incsearch inccommand=nosplit

" Spell Checking:
set dictionary=$HOME/.american-english-with-propcase.txt
set spelllang=en_us

" Single Space After Punctuation: useful when doing :%j (the opposite of gq)
set nojoinspaces

set showtabline=2

set autoread

set grepprg=rg\ --vimgrep

" Paste: this is actually typed <C-/>, but term nvim thinks this is <C-_>
set pastetoggle=<C-_>

set notimeout   " don't timeout on mappings
set ttimeout    " do timeout on terminal key codes

" Numbering:
set number

" Window Splitting: Set split settings (options: splitright, splitbelow)
set splitright

" Terminal Color Support: only set guicursor if truecolor
if $COLORTERM ==# 'truecolor'
  set termguicolors
else
  set guicursor=
endif

" Set Background: for PaperColor/Molokai, also sets handler
set background=dark

" Colorcolumn:
set colorcolumn=80

" Status Line: specifics for custom status line
set laststatus=2 ttimeoutlen=50 noshowmode

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" Updatetime: time Vim waits to do something after I stop moving
set updatetime=300

" Linux Dev Path: system libraries
set path+=/usr/include/x86_64-linux-gnu/

" Vim history for command line; can't imagine that more than 100 is needed
set history=100

" Set the diff expression to EnhancedDiff
set diffopt+=internal,algorithm:patience

" Folding
set foldenable foldmethod=marker foldnestmax=1

" Redraw Window: whenever a window regains focus
augroup custom_redraw_on_refocus
  autocmd!
  autocmd FocusGained * redraw!
augroup end

augroup zliu_incsearch_highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  " autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

augroup custom_nginx
  autocmd!
  autocmd FileType nginx set iskeyword+=$
  autocmd FileType zsh set iskeyword+=-
augroup end

" }}}
" General: package management {{{

" Available Commands:
"   PackagerStatus, PackagerInstall, PackagerUpdate, PackagerClean

function! s:packager_init(packager) abort
  call a:packager.add('https://github.com/kristijanhusak/vim-packager', {'type': 'opt'})

  " Autocompletion And IDE Features:
  call a:packager.add('https://github.com/neoclide/coc.nvim.git', {'do': 'yarn install --frozen-lockfile'})
  call a:packager.add('git@github.com:tjdevries/coc-zsh.git')

  " TreeSitter:
  call a:packager.add('https://github.com/nvim-treesitter/nvim-treesitter.git', {'do': ':TSUpdate'})
  call a:packager.add('https://github.com/lewis6991/spellsitter.nvim.git')
  call a:packager.add('https://github.com/nvim-treesitter/playground.git')
  call a:packager.add('https://github.com/windwp/nvim-ts-autotag.git')
  call a:packager.add('https://github.com/nvim-treesitter/nvim-treesitter-context')
  call a:packager.add('https://github.com/JoosepAlviste/nvim-ts-context-commentstring.git', {'requires': [
      \ 'https://github.com/tpope/vim-commentary',
      \ ]})

  " LocationList:
  call a:packager.add('https://github.com/elbeardmorez/vim-loclist-follow.git')

  " Editorconfig:
  call a:packager.add('https://github.com/gpanders/editorconfig.nvim.git')

  " Tree:
  call a:packager.add('https://github.com/kyazdani42/nvim-tree.lua.git', {'requires': [
      \ 'https://github.com/kyazdani42/nvim-web-devicons.git',
      \ ]})

  " General:
  call a:packager.add('https://github.com/bronson/vim-visual-star-search')
  call a:packager.add('https://github.com/fidian/hexmode')
  call a:packager.add('https://github.com/simeji/winresizer')
  call a:packager.add('https://github.com/sjl/strftimedammit.vim')
  call a:packager.add('https://github.com/unblevable/quick-scope')
  call a:packager.add('https://github.com/windwp/nvim-autopairs.git')
  call a:packager.add('https://github.com/ntpeters/vim-better-whitespace.git')
  call a:packager.add('https://github.com/NvChad/nvim-colorizer.lua')
  call a:packager.add('https://github.com/tpope/vim-characterize.git')

  call a:packager.add('git@github.com:gcmt/taboo.vim')
  call a:packager.add('git@github.com:itchyny/lightline.vim')
  call a:packager.add('git@github.com:kh3phr3n/tabline')
  call a:packager.add('git@github.com:christoomey/vim-system-copy')
  call a:packager.add('git@github.com:mhinz/vim-startify')

  " KeywordPrg:
  call a:packager.add('git@github.com:pappasam/vim-keywordprg-commands.git')

  " Fuzzy Finder:
  call a:packager.add('https://github.com/nvim-telescope/telescope.nvim.git', {'requires': [
      \ 'https://github.com/nvim-lua/plenary.nvim.git',
      \ ]})

  " Git:
  call a:packager.add('https://github.com/tpope/vim-fugitive')
  call a:packager.add('https://github.com/rhysd/git-messenger.vim.git')
  call a:packager.add('https://github.com/lewis6991/gitsigns.nvim.git')

  " Text Objects:
  call a:packager.add('https://github.com/machakann/vim-sandwich')
  call a:packager.add('https://github.com/kana/vim-textobj-user')

  " Writing:
  call a:packager.add('https://github.com/dkarter/bullets.vim')
  call a:packager.add('https://github.com/folke/zen-mode.nvim.git')
  call a:packager.add('https://github.com/jlesquembre/rst-tables.nvim')
  call a:packager.add('https://github.com/folke/twilight.nvim.git')
  call a:packager.add('https://github.com/moiatgit/vim-rst-sections')

  " Previewers:
  call a:packager.add('https://github.com/iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'})
  call a:packager.add('https://github.com/weirongxu/plantuml-previewer.vim', {'requires': [
      \ 'https://github.com/tyru/open-browser.vim',
      \ ]})

  " Code Formatters:
  call a:packager.add('git@github.com:pappasam/vim-filetype-formatter')

  " Repl Integration:
  call a:packager.add('git@github.com:pappasam/nvim-repl.git', {'requires': [
        \ 'https://github.com/tpope/vim-repeat',
        \ ]})

  " Syntax Theme:
  call a:packager.add('git@github.com:pappasam/papercolor-theme-slim.git')
  " call a:packager.add('git@github.com:zachliu/molokai.git')
  " call a:packager.add('git@github.com:zachliu/papercolor-theme-slim.git')

  " Jupyter Integration:
  call a:packager.add('https://github.com/goerz/jupytext.vim.git')

  " Syntax Highlighting & Indentation:
  call a:packager.add('https://github.com/evanleck/vim-svelte.git', {'requires': [
      \ 'https://github.com/cakebaker/scss-syntax.vim.git',
      \ 'https://github.com/groenewege/vim-less.git',
      \ 'https://github.com/leafgarland/typescript-vim.git',
      \ 'https://github.com/othree/html5.vim.git',
      \ 'https://github.com/pangloss/vim-javascript.git',
      \ ]})
  call a:packager.add('https://github.com/Vimjas/vim-python-pep8-indent')
  call a:packager.add('https://github.com/Yggdroot/indentLine')
  call a:packager.add('https://github.com/aklt/plantuml-syntax.git')
  call a:packager.add('https://github.com/chr4/nginx.vim.git')
  call a:packager.add('https://github.com/delphinus/vim-firestore.git')
  call a:packager.add('https://github.com/mattn/vim-xxdcursor')
  call a:packager.add('https://github.com/neovimhaskell/haskell-vim')
  call a:packager.add('https://github.com/vim-scripts/SAS-Syntax')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'), {
      \ 'window_cmd': 'edit',
      \ })

" }}}
" General: key mappings {{{

let mapleader = ","

function! s:default_key_mappings()
  " Coc: settings for coc.nvim
  nmap     <silent>        <C-]> <Plug>(coc-definition)
  nnoremap <silent>        <C-k> <Cmd>call CocActionAsync('doHover')<CR>
  inoremap <silent>        <C-s> <Cmd>call CocActionAsync('showSignatureHelp')<CR>
  nnoremap <silent>        <C-w>f <Cmd>call coc#float#jump()<CR>
  nmap     <silent>        <leader>st <Plug>(coc-type-definition)
  nmap     <silent>        <leader>si <Plug>(coc-implementation)
  nmap     <silent>        <leader>su <Plug>(coc-references)
  nmap     <silent>        <leader>sr <Plug>(coc-rename)
  nmap     <silent>        <leader>sa v<Plug>(coc-codeaction-selected)
  vmap     <silent>        <leader>sa <Plug>(coc-codeaction-selected)
  nnoremap <silent>        <leader>sn <Cmd>CocNext<CR>
  nnoremap <silent>        <leader>sp <Cmd>CocPrev<CR>
  nnoremap <silent>        <leader>sl <Cmd>CocListResume<CR>
  nnoremap <silent>        <leader>sc <Cmd>CocList commands<cr>
  nnoremap <silent>        <leader>so <Cmd>CocList -A outline<cr>
  nnoremap <silent>        <leader>sw <Cmd>CocList -A -I symbols<cr>
  inoremap <silent> <expr> <c-space> coc#refresh()
  inoremap <silent> <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
  inoremap <silent> <expr> <TAB> coc#pum#visible() ? coc#_select_confirm() : "\<TAB>"
  nnoremap                 <leader>d <Cmd>call CocActionAsync('diagnosticToggle')<CR>
  nnoremap                 <leader>D <Cmd>call CocActionAsync('diagnosticPreview')<CR>
  nmap     <silent>        <leader>n <Plug>(coc-diagnostic-next)
  nmap     <silent>        <leader>p <Plug>(coc-diagnostic-prev)

  " Toggle gitsigns
  nnoremap <silent> <leader>g <Cmd>GitsignsToggle<CR>

  " View Syntax Groups
  nnoremap <silent> zS <cmd>call <SID>syntax_group()<CR>

  " Escape: also clears highlighting
  nnoremap <silent> <esc> <Cmd>noh<return><esc>

  " J: unmap in normal mode unless range explicitly specified
  nnoremap <silent> <expr> J v:count == 0 ? '<esc>' : 'J'

  " SearchBackward: remap comma to single quote
  nnoremap ' ,

  " Exit: Preview, Help, QuickFix, and Location List
  inoremap <silent> <C-c> <Esc>:pclose <BAR> cclose <BAR> lclose <CR>a
  nnoremap <silent> <C-c> :pclose <BAR> cclose <BAR> lclose <CR>

 " InsertModeHelpers: Insert one line above after enter
  inoremap <M-CR> <CR><C-o>O

  " MoveVisual: up and down visually only if count is specified before
  nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
  vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
  nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
  vnoremap <expr> j v:count == 0 ? 'gj' : 'j'

  " MoveTabs: moving forward, backward, and to number with vim tabs
  nnoremap T gt
  nnoremap t gT

  " ToggleRelativeNumber: uses custom functions
  nnoremap <silent> <leader>R <cmd>ToggleNumber<CR>
  nnoremap <silent> <leader>r <cmd>ToggleRelativeNumber<CR>

  " TogglePluginWindows:
  nnoremap <silent> <space>j <Cmd>NvimTreeFindFileToggle<CR>
  nnoremap <silent> <space>J <Cmd>NvimTreeToggle<CR>
  nnoremap <silent> <space>l <Cmd>call <SID>coc_toggle_outline()<CR>

  " Toggle Treesitter Context:
  nnoremap <silent> <leader>c <Cmd>TSContextToggle<CR>

  " Zenmode / Writing:
  nnoremap <leader><leader>g <Cmd>ZenMode<CR>
  nnoremap <leader><leader>l <Cmd>Twilight<CR>

  " IndentLines: toggle if indent lines is visible
  nnoremap <silent> <leader>i <Cmd>IndentLinesToggle<CR>

  " ResizeWindow: up and down; relies on custom functions
  nnoremap <silent> <leader><leader>h <cmd>ResizeWindowHeight<CR>
  nnoremap <silent> <leader><leader>w <cmd>ResizeWindowWidth<CR>

  " Repl: Sam's repl plugin
  nnoremap <leader><leader>e <Cmd>ReplToggle<CR>
  nmap     <leader>e <Plug>ReplSendLine
  vmap     <leader>e <Plug>ReplSendVisual

  " Sandwich: below mappings address the issue raised here:
  nmap s <Nop>
  xmap s <Nop>

  " Telescope: create shortcuts for finding stuff
  nnoremap <silent> <C-p><C-p> <Cmd>Telescope find_files hidden=true<CR>
  nnoremap <silent> <C-p><C-b> <Cmd>Telescope buffers<CR>
  nnoremap <silent> <C-p><C-g> <Cmd>Telescope git_status<CR>
  nnoremap <silent> <C-n><C-n> <Cmd>Telescope live_grep<CR>
  nnoremap <silent> <C-n><C-w> <Cmd>Telescope grep_string<CR>
  nnoremap <silent> <C-n><C-h> <Cmd>Telescope help_tags<CR>

  " FiletypeFormat: remap leader f to do filetype formatting
  nnoremap <silent> <leader>f <Cmd>FiletypeFormat<cr>
  vnoremap <silent> <leader>f :FiletypeFormat<cr>

  " GitMessenger:
  nmap <leader>sg <Plug>(git-messenger)

  " Open <cfile> with gx
  nnoremap gx <Cmd>call <SID>gx_improved()<CR>

  " Mouse Copy: system copy mouse characteristics
  vnoremap <RightMouse> "+y

  " Mouse Paste: make it come from the system register
  nnoremap <MiddleMouse> "+<MiddleMouse>

  " Mouse Open Close Folds: open folds with the mouse, and close the folds
  " open operation taken from: https://stackoverflow.com/a/13924974
  nnoremap <expr> <2-LeftMouse> foldclosed(line('.')) == -1 ? '\<2-LeftMouse>' : 'zo'
  nnoremap <RightMouse> <LeftMouse><LeftRelease>zc

  " Insert Mode moves - arrows
  imap <C-h> <left>
  imap <C-j> <down>
  imap <C-k> <up>
  imap <C-l> <right>
  " Insert Mode moves - begin/end of line
  inoremap <C-e> <Esc>A
  inoremap <C-a> <Esc>I

  " Auto-execute all filetypes
  let &filetype=&filetype
endfunction

call s:default_key_mappings()

augroup custom_remap_man_help
  autocmd!
  autocmd FileType man,help nnoremap <buffer> <silent> <C-]> <C-]>
augroup end

augroup custom_remap_rst
  autocmd!
  autocmd FileType rst nnoremap <buffer>          <leader>f <Cmd>TableRstFormat<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s0 <Cmd>call RstSetSection(0)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s1 <Cmd>call RstSetSection(1)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s2 <Cmd>call RstSetSection(2)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s3 <Cmd>call RstSetSection(3)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s4 <Cmd>call RstSetSection(4)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s5 <Cmd>call RstSetSection(5)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s6 <Cmd>call RstSetSection(6)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sk <Cmd>call RstGoPrevSection()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sj <Cmd>call RstGoNextSection()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sa <Cmd>call RstIncrSectionLevel()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sx <Cmd>call RstDecrSectionLevel()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sl <Cmd>call RstSectionLabelize()<CR>
augroup end

augroup custom_remap_lsp_format
  autocmd!
  autocmd FileType haskell nmap <buffer> <silent> <leader>f <Cmd>call CocAction('format')<CR>
augroup end

augroup custom_remap_nvim_tree_lua
  autocmd!
  autocmd FileType NvimTree nnoremap <buffer> <silent> <C-l> <Cmd>NvimTreeResize +2<CR>
  autocmd FileType NvimTree nnoremap <buffer> <silent> <C-h> <Cmd>NvimTreeResize -2<CR>
augroup end

" }}}
" Package: language server protocol (LSP) with coc.nvim {{{

let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<C-h>'
let g:coc_start_at_startup = 1
let g:coc_filetype_map = {
      \ 'markdown.mdx': 'markdown',
      \ 'python.jinja2': 'python',
      \ 'sql.jinja2': 'sql',
      \ 'yaml.ansible': 'yaml',
      \ 'yaml.docker-compose': 'yaml',
      \ 'jinja.html': 'html',
      \ }

" Coc Global Extensions: automatically installed on Vim open
let g:coc_global_extensions = [
      \ '@yaegassy/coc-nginx',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-docker',
      \ 'coc-emoji',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-kotlin',
      \ 'coc-lists',
      \ 'coc-ltex',
      \ 'coc-lua',
      \ 'coc-markdownlint',
      \ 'coc-prisma',
      \ 'coc-pyright',
      \ 'coc-r-lsp',
      \ 'coc-rls',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-svelte',
      \ 'coc-svg',
      \ 'coc-syntax',
      \ 'coc-texlab',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-word',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ ]

" Note: coc-angular requires `npm install @angular/language-service` in
" project directory to stop coc from crashing. See:
" <https://github.com/iamcco/coc-angular/issues/47>

function! s:autocmd_custom_coc()
  if !exists("g:did_coc_loaded")
    return
  endif
  augroup custom_coc
    autocmd FileType coctree set nowrap
    autocmd FileType nginx let b:coc_additional_keywords = ['$']
    " autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd User CocNvimInit call s:default_key_mappings()
  augroup end
endfunction

function! s:coc_toggle_outline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

augroup custom_coc
  autocmd!
  autocmd VimEnter * call s:autocmd_custom_coc()
augroup end

" }}}
" Package: lua extensions for Neovim {{{

function! s:safe_require(package)
  try
    execute "lua require('" . a:package . "')"
  catch
    echom "Error with lua require('" . a:package . "')"
  endtry
endfunction

function! s:setup_lua_packages()
  call s:safe_require('config.colorizer')
  call s:safe_require('config.gitsigns')
  call s:safe_require('config.nvim-autopairs')
  call s:safe_require('config.nvim-tree')
  call s:safe_require('config.nvim-treesitter')
  call s:safe_require('config.nvim-ts-context-commentstring')
  call s:safe_require('config.nvim-web-devicons')
  call s:safe_require('config.spellsitter')
  call s:safe_require('config.telescope')
  call s:safe_require('config.treesitter-context')
endfunction

call s:setup_lua_packages()

function! s:nvimtree_vimenter()
  let cliargs = argv()
  if exists(':NvimTreeOpen') && len(cliargs) == 1 && isdirectory(cliargs[0])
    execute 'NvimTreeOpen ' . cliargs[0]
  endif
endfunction

augroup lua_extension_config
  autocmd!
  autocmd FileType vim let &l:path .= ','.stdpath('config').'/lua'
  autocmd FileType vim setlocal
        \ includeexpr=substitute(v:fname,'\\.','/','g')
        \ suffixesadd^=.lua
  autocmd VimEnter * call s:nvimtree_vimenter()
augroup end

command! GitsignsToggle Gitsigns toggle_signs

" }}}
" General: alacritty callback for dynamic terminal color change {{{

" Commented out this whole section because it wipes my bold characters
" Symptom(s): $ m man only shows bold chars for a split of a second
" function! s:alacritty_set_background()
"   let g:alacritty_background = system('alacritty-which-colorscheme')
"   if !v:shell_error
"     let &background = g:alacritty_background
"   else
"     echom 'Error calling "alacritty-which-colorscheme"'
"   endif
" endfunction

" call s:alacritty_set_background()
" call jobstart(
"       \ 'ls ' . $HOME . '/.config/alacritty/alacritty.yml | entr -ps "echo alacritty_change"',
"       \ {'on_stdout': { j, d, e -> s:alacritty_set_background() }}
"       \ )

" }}}
" General: syntax and colorscheme {{{

function! s:vim_syntax_group()
  let l:s = synID(line('.'), col('.'), 1)
  if l:s == ''
    echo 'none'
  else
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endif
endfun

function! s:syntax_group()
  if &syntax == ''
    TSHighlightCapturesUnderCursor
  else
    call s:vim_syntax_group()
  endif
endfunction

augroup custom_colorscheme
  autocmd!
  " typescriptParens are stupidly linked to 'Normal' in Neovim.
  " This causes problems with hover windows in coc and is solved here
  autocmd ColorScheme * highlight link typescriptParens cleared
  autocmd ColorScheme * highlight link ExtraWhitespace DiffText
  autocmd ColorScheme * highlight link HighlightedyankRegion Search
  autocmd ColorScheme * highlight link CocHighlightText Underlined

  autocmd ColorScheme * highlight CocErrorHighlight gui=undercurl
  autocmd ColorScheme * highlight CocWarningHighlight gui=undercurl
  autocmd ColorScheme * highlight CocInfoHighlight gui=undercurl
  autocmd ColorScheme * highlight CocHintHighlight gui=undercurl

  autocmd ColorScheme PaperColorSlim
      \ if &background == 'light' |
      \   execute 'highlight CocSearch guifg=#005f87' |
      \   execute 'highlight CocMenuSel guibg=#bcbcbc' |
      \ else |
      \   execute 'highlight CocSearch guifg=#5fafd7' |
      \   execute 'highlight CocMenuSel guibg=#585858' |
      \ endif
augroup end

augroup custom_papercolorslim_transparent_background
  autocmd!
  autocmd ColorScheme PaperColorSlim highlight Normal guibg=none
augroup end

" Toggle between my favorite two color schemes
function ToggleColorSchemes()
    if (g:colors_name == "PaperColorSlim")
        colorscheme Molokai
    else
        colorscheme PaperColorSlim
    endif
endfunction
nnoremap <silent> <leader>c :call ToggleColorSchemes()<CR>

try
  " colorscheme Molokai
  colorscheme PaperColorSlim
catch
  echo 'An error occurred while configuring Papercolor'
endtry

" }}}
" General: filetype {{{

augroup custom_filetype_recognition
  autocmd!
  autocmd BufEnter *.asm set filetype=nasm
  autocmd BufEnter *.scm set filetype=query
  autocmd BufEnter *.cfg,*.ini,.coveragerc,*pylintrc,zoomus.conf,config,credentials set filetype=dosini
  autocmd BufEnter *.config,.cookiecutterrc,DESCRIPTION,.lintr set filetype=yaml
  autocmd BufEnter *.handlebars set filetype=html
  autocmd BufEnter *.hql,*.q set filetype=hive
  autocmd BufEnter *.js,*.gs set filetype=javascript
  autocmd BufEnter *.mdx set filetype=markdown
  autocmd BufEnter *.min.js set filetype=none
  autocmd BufEnter *.m,*.oct set filetype=octave
  autocmd BufEnter *.py.j2 set filetype=python.jinja2
  autocmd BufEnter *.sql.j2 set filetype=sql.jinja2
  autocmd BufEnter *.toml set filetype=toml
  autocmd BufEnter *.tsv set filetype=tsv
  autocmd BufEnter .envrc set filetype=sh
  autocmd BufEnter .gitignore,.dockerignore set filetype=conf
  autocmd BufEnter renv.lock,.jrnl_config,*.bowerrc,*.babelrc,*.eslintrc,*.slack-term,*.htmlhintrc,*.stylelintrc,*.firebaserc set filetype=json
  autocmd BufEnter Dockerfile,Dockerfile.* set filetype=dockerfile
  autocmd BufEnter Makefile.* set filetype=make
  autocmd BufEnter poetry.lock,Pipfile set filetype=toml
  autocmd BufEnter tsconfig.json,*.jsonc,.markdownlintrc set filetype=jsonc
  " Setting .zshrc filetype to sh messes up with its syntax highlighting or parsing ¯\_(ツ)_/¯
  " autocmd BufEnter .zshrc set filetype=sh
augroup end

" }}}
" General: indentation {{{

augroup custom_indentation
  autocmd!
  " Reset to 2 (something somewhere overrides...)
  autocmd Filetype markdown setlocal shiftwidth=2 softtabstop=2
  " 4 spaces per tab, not 2
  autocmd Filetype python,c,haskell,rust,rst,kv,nginx,asm,nasm,gdscript3
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  " Use hard tabs, not spaces
  autocmd Filetype make,tsv,votl,go,gomod
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>
  autocmd Filetype dot setlocal autoindent cindent
augroup END

" }}}
" General: statusline & tabline {{{

" Tab Line
set tabline=%t

" Status Line
set laststatus=2
set statusline=
set statusline+=%#CursorLine#
set statusline+=\ %{mode()}
set statusline+=\ %*\  " Color separator + space
set statusline+=%{&paste?'[P]':''}
set statusline+=%{&spell?'[S]':''}
set statusline+=%r
set statusline+=%t
set statusline+=%m
set statusline+=%=
set statusline+=\ %y\  " file type
set statusline+=%#CursorLine#
set statusline+=\ %{&ff}\  " Unix or Dos
set statusline+=%*  " default color
set statusline+=\ %{strlen(&fenc)?&fenc:'none'}\  " file encoding

" Status Line
augroup custom_statusline
  autocmd!
  autocmd BufEnter NvimTree* setlocal statusline=\ NvimTree\ %#CursorLine#
augroup end

" }}}
" General: environment variables {{{

" Path: add node_modules for language servers / linters / other stuff
let $PATH = $PWD . '/node_modules/.bin:' . $PATH

" }}}
" General: abbreviations {{{

" If in_command is at beginning of line : return out_command
" Else : return in_command.
function! s:abbr_help(in_command, out_command)
  if (getcmdtype() == ':' && getcmdline() =~ '^' . a:in_command . '$')
    return a:out_command
  else
    return a:in_command
  endif
endfunction

" Open configuration files
cnoreabbrev <expr> v <SID>abbr_help('v', 'edit ~/config/dotfiles/.config/nvim/init.vim')
cnoreabbrev <expr> z <SID>abbr_help('z', 'edit ~/config/dotfiles/.zshrc')
cnoreabbrev <expr> b <SID>abbr_help('b', 'edit ~/config/dotfiles/.bashrc')
cnoreabbrev <expr> coc <SID>abbr_help('coc', 'edit ~/config/dotfiles/.config/nvim/coc-settings.json')

" Edit snippet files
cnoreabbrev <expr> snip <SID>abbr_help('snip', 'CocCommand snippets.editSnippets')

" 'c' is abbreviation for 'close'. I use it way more often than 'change'
cnoreabbrev <expr> c <SID>abbr_help('c', 'close')

" }}}
" General: comment & text format options {{{

" Notes:
" commentstring: read by vim-commentary; must be one template
" comments: csv of comments.
" formatoptions: influences how Vim formats text
"   ':help fo-table' will get the desired result
augroup custom_comment_config
  autocmd!
  autocmd FileType dosini setlocal commentstring=#\ %s comments=:#,:;
  autocmd FileType tmux,python,nginx setlocal commentstring=#\ %s comments=:# formatoptions=jcroql
  autocmd FileType jsonc setlocal commentstring=//\ %s comments=:// formatoptions=jcroql
  autocmd FileType sh setlocal formatoptions=jcroql
  autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
augroup end

augroup custom_indentation
  autocmd!
  " auto wrap when viewing/editing markdown
  autocmd Filetype markdown setlocal wrap
augroup END

" }}}
" General: colorColumn different widths for different filetypes {{{

augroup colorcolumn_configuration
  autocmd!
  autocmd FileType gitcommit setlocal colorcolumn=73 textwidth=72
augroup END

" }}}
" General: trailing whitespace {{{

function! s:trim_whitespace()
  let l:save = winsaveview()
  if &ft == 'markdown'
    " Replace lines with only trailing spaces
    %s/^\s\+$//e
    " Replace lines with exactly one trailing space with no trailing spaces
    %g/\S\s$/s/\s$//g
    " Replace lines with more than 2 trailing spaces with 2 trailing spaces
    %s/\s\s\s\+$/  /e
  else
    " Remove all trailing spaces
    %s/\s\+$//e
  endif
  call winrestview(l:save)
endfunction

command! TrimWhitespace call s:trim_whitespace()

augroup custom_fix_whitespace_save
  autocmd!
  autocmd BufWritePre * TrimWhitespace
augroup end

" }}}
" General: resize window {{{

" WindowWidth: Resize window to a couple more than longest line
" modified function from:
" https://stackoverflow.com/questions/2075276/longest-line-in-vim
function! s:resize_window_width()
  if &wrap
    echo 'run `:set nowrap` before resizing window'
    return
  endif
  let max_line = line('$')
  let maxlength = max(map(range(1, max_line), "virtcol([v:val, '$'])"))
  let adjustment = &number
        \ ? maxlength + max([len(max_line + ''), 2]) + 1
        \ : maxlength - 1
  normal! m`
  execute ':vertical resize ' . adjustment
  normal! ``
endfunction

function! s:resize_window_height()
  normal! m`
  let initial = winnr()

  " this duplicates code but avoids polluting global namespace
  wincmd k
  if winnr() != initial
    execute initial . 'wincmd w'
    1
    execute 'resize ' . (line('$') + 1)
    normal! ``
    return
  endif

  wincmd j
  if winnr() != initial
    execute initial . 'wincmd w'
    1
    execute 'resize ' . (line('$') + 1)
    normal! ``
    return
  endif
endfunction

command! ResizeWindowWidth call s:resize_window_width()
command! ResizeWindowHeight call s:resize_window_height()

" }}}
" General: avoid saving 'lcd' {{{

augroup custom_no_save_lcd
  autocmd!
  autocmd User BufStaySavePre
        \ if haslocaldir() |
        \ let w:lcd = getcwd() |
        \ execute 'cd '.fnameescape(getcwd(-1, -1)) |
        \ endif
  autocmd User BufStaySavePost
        \ if exists('w:lcd') |
        \ execute 'lcd' fnameescape(w:lcd) |
        \ unlet w:lcd |
        \ endif
augroup end

" }}}
" General: clean unicode {{{

" Replace unicode symbols with cleaned, ascii versions
function! s:clean_unicode()
  silent! %s/”/"/g
  silent! %s/“/"/g
  silent! %s/’/'/g
  silent! %s/‘/'/g
  silent! %s/—/-/g
  silent! %s/…/.../g
endfunction()
command! CleanUnicode call s:clean_unicode()

" }}}
" General: macro repeater {{{

" Allow '.' to repeat macros. Finally!
" Taken from here:
" https://vi.stackexchange.com/questions/11210/can-i-repeat-a-macro-with-the-dot-operator
" SR took it from GitHub: ckarnell/Antonys-macro-repeater
"
" When . repeats g@, repeat the last macro.
function! AtRepeat(_)
  " If no count is supplied use the one saved in s:atcount.
  " Otherwise save the new count in s:atcount, so it will be
  " applied to repeats.
  let s:atcount = v:count ? v:count : s:atcount
  " feedkeys() rather than :normal allows finishing in Insert
  " mode, should the macro do that. @@ is remapped, so 'opfunc'
  " will be correct, even if the macro changes it.
  call feedkeys(s:atcount.'@@')
endfunction

function! AtSetRepeat(_)
  set operatorfunc=AtRepeat
endfunction

" Called by g@ being invoked directly for the first time. Sets
" 'opfunc' ready for repeats with . by calling AtSetRepeat().
function! AtInit()
  " Make sure setting 'opfunc' happens here, after initial playback
  " of the macro recording, in case 'opfunc' is set there.
  set operatorfunc=AtSetRepeat
  return 'g@l'
endfunction

function! AtReg()
  let s:atcount = v:count1
  let l:c = nr2char(getchar())
  return '@'.l:c."\<plug>@init"
endfunction

function! QRepeat(_)
  call feedkeys('@'.s:qreg)
endfunction

function! QSetRepeat(_)
  set operatorfunc=QRepeat
endfunction

function! QStop()
  set operatorfunc=QSetRepeat
  return 'g@l'
endfunction

let s:qrec = 0
function! QStart()
  if s:qrec == 1
    let s:qrec = 0
    return "q\<plug>qstop"
  endif
  let s:qreg = nr2char(getchar())
  if s:qreg =~# '[0-9a-zA-Z"]'
    let s:qrec = 1
  endif
  return 'q'.s:qreg
endfunction

" }}}
" General: toggle numbers {{{

function! s:toggle_number()
  if &number == 0
    set number
  else
    set nonumber
  endif
endfunction

function! s:toggle_relative_number()
  if &relativenumber == 0
    set relativenumber
  else
    set norelativenumber
  endif
endfunction

command! ToggleNumber call s:toggle_number()
command! ToggleRelativeNumber call s:toggle_relative_number()

" }}}
" Package: markdown-preview.vim {{{

let g:mkdp_auto_start = v:false
let g:mkdp_auto_close = v:false

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = v:false

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
" default: 0
let g:mkdp_command_for_global = v:false

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle'
      \ }

" }}}
" Package: preview compiled stuff in viewer {{{

function! s:preview()
  if &filetype ==? 'rst'
    silent exec 'terminal restview %'
    silent exec "normal \<C-O>"
  elseif &filetype ==? 'markdown'
    " from markdown-preview.vim
    silent exec 'MarkdownPreview'
  elseif &filetype ==? 'plantuml'
    " from plantuml-previewer.vim
    silent exec 'PlantumlOpen'
  else
    silent !gio open '%:p'
  endif
endfunction

command! Preview call s:preview()

" }}}
" Package: misc global var config {{{

" Make Python support work better with asdf
let g:python3_host_prog = "$HOME/.asdf/shims/python"

" Configure clipboard explicitly. Speeds up startup
let g:clipboard = {
      \ 'name': 'xsel',
      \ 'copy': {
      \    '+': 'xsel --clipboard --input',
      \    '*': 'xsel --clipboard --input',
      \  },
      \ 'paste': {
      \    '+': 'xsel --clipboard --output',
      \    '*': 'xsel --clipboard --output',
      \ },
      \ 'cache_enabled': 0,
      \ }

" Netrw: disable completely
let g:loaded_netrw= v:true
let g:netrw_loaded_netrwPlugin= v:true
let g:netrw_nogx = v:true

" Man Pager
let g:man_hardwrap = v:true

" WinResize:
let g:winresizer_start_key = '<C-E>'
let g:winresizer_vert_resize = v:true
let g:winresizer_horiz_resize = v:true

" Haskell: 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = v:true   " to highlight `forall`
let g:haskell_enable_recursivedo = v:true      " to highlight `mdo` and `rec`
let g:haskell_enable_arrowsyntax = v:true      " to highlight `proc`
let g:haskell_enable_pattern_synonyms = v:true " to highlight `pattern`
let g:haskell_enable_typeroles = v:true        " to highlight type roles
let g:haskell_enable_static_pointers = v:true  " to highlight `static`

" IndentLines:
let g:indentLine_enabled = v:false  " indentlines disabled by default

" BulletsVim:
let g:bullets_enabled_file_types = [
    \ 'gitcommit',
    \ 'markdown',
    \ 'markdown.mdx',
    \ 'scratch',
    \ 'text',
    \ 'rst',
    \]
let g:bullets_outline_levels = ['num', 'std-']

" QuickScope: great plugin helping with f and F
let g:qs_highlight_on_keys = ['f', 'F']
let g:qs_max_chars = 10000

" HexMode: configure hex editing
" relevant command: Hexmode
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 2'

" Makefile: global variable to prevent syntax highlighting of commands
let g:make_no_commands = 1

" vim-filetype-formatter:
let g:vim_filetype_formatter_verbose = v:false
let g:vim_filetype_formatter_ft_no_defaults = []
let g:vim_filetype_formatter_commands = {
      \ 'python': 'black -q - | isort -q - | docformatter -',
      \ }

" git-messenger:
let g:git_messenger_always_into_popup = v:false
let g:git_messenger_no_default_mappings = v:true

" nvim-repl:
let g:repl_filetype_commands = {
      \ 'bash': 'bash',
      \ 'javascript': 'node',
      \ 'python': 'bpython -q',
      \ 'R': 'R',
      \ 'sh': 'sh',
      \ 'vim': 'nvim --clean -ERM',
      \ 'zsh': 'zsh',
      \ }
let g:repl_default = &shell

"  }}}
" Package: lightline {{{

" This is a giant section
" that configures the status line for my vim editing.
" It's super important, so I devote a lot of code to it.
" Most of the functions are ported from the Lightline documentation

let g:lightline = {'active': {}, 'inactive': {}}

let g:lightline.mode_map = {
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

let g:lightline.component = {
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&ff}',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'percent': '%3p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%c:%L',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}' }

let g:lightline.active.left = [
      \ [ 'mode', 'paste', 'spell' ],
      \ [ 'ctrlpmark' ]
      \ ]

let g:lightline.inactive.left = [
      \ [ 'mode', 'paste', 'spell' ],
      \ [ 'ctrlpmark' ]
      \ ]

let g:lightline.active.right = [
      \ [ 'filetype' ],
      \ [ 'fileformat', 'fileencoding' ],
      \ [ 'lineinfo' ]
      \ ]

let g:lightline.inactive.right = [
      \ [ 'filetype' ],
      \ [],
      \ []
      \ ]

let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'mode': 'LightlineMode'
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let cwd = getcwd()
  let fname = substitute(expand("%:p"), l:cwd . "/" , "", "")
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~ '__Tagbar__.*' ? '' :
        \ fname =~ '__Gundo' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname =~ '__Tagbar__.*' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" }}}
" Package: startify {{{

let g:startify_list_order = []
let g:startify_fortune_use_unicode = v:true
let g:startify_enable_special = v:true
let g:startify_custom_header = []

function! s:set_startify()
  if !exists('g:loaded_startify')
    echom 'Startify is not loaded, skipping...'
    return
  endif
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
endfunction

autocmd VimEnter * call s:set_startify()

" }}}
