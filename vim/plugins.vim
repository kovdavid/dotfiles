call plug#begin()

Plug 'rhysd/clever-f.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-endwise'
Plug 'junkblocker/git-time-lapse'
Plug 'benekastah/neomake'
Plug 'DavsX/vim_test_runner', { 'for': 'perl' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'

Plug 'fatih/vim-go', { 'for': 'go' }

" if has('nvim')
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" endif

call plug#end()
