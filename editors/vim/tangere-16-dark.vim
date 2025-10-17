" Tangere-16-dark theme for terminal vim
" This theme has been designed for use with the tangere-terminal color palette.
" Author: François Tonneau

highlight clear

if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "tangere-16-dark"

" Common section
" ------------------------------

" Edition
hi Normal               ctermfg=none
hi Cursor               ctermfg=none
hi CursorColumn         ctermfg=0       ctermbg=15
hi CursorLine           ctermfg=none    ctermbg=none    cterm=none
hi CursorLineNr         ctermfg=0       ctermbg=6       cterm=bold
hi LineNr               ctermfg=8

" Decoration
hi ColorColumn          ctermfg=8       ctermbg=none    cterm=underline
hi FoldColumn           ctermfg=8       ctermbg=none    cterm=bold
hi Folded               ctermfg=0       ctermbg=6
hi SignColumn           ctermfg=8       ctermbg=none    cterm=bold
hi TabLine              ctermfg=8       ctermbg=15      cterm=none
hi TabLineFill          ctermfg=15      ctermbg=15      cterm=none
hi TabLineSel           ctermfg=0       ctermbg=5       cterm=bold
hi VertSplit            ctermfg=15      ctermbg=none    cterm=none

" Search and navigation
hi Search               ctermfg=0       ctermbg=3       cterm=none
hi IncSearch            ctermfg=0       ctermbg=5       cterm=none
hi Directory            ctermfg=4       ctermbg=none    cterm=bold
hi netrwExe             ctermfg=2       ctermbg=none    cterm=bold
hi netrwClassify        ctermfg=8

" Prompt and status
hi ModeMsg              ctermfg=none    ctermbg=none    cterm=bold,italic
hi MoreMsg              ctermfg=0       ctermbg=6       cterm=none
hi Question             ctermfg=0       ctermbg=6       cterm=none
hi StatusLine           ctermfg=none    ctermbg=15      cterm=bold
hi StatusLineNC         ctermfg=8       ctermbg=15      cterm=none
hi Title                ctermfg=none                    cterm=bold
hi WildMenu             ctermfg=0       ctermbg=5       cterm=bold

" Visual aid
hi Conceal              ctermfg=6       ctermbg=none
hi Delimiter            ctermfg=none
hi Error                ctermfg=1       ctermbg=none    cterm=bold,underline
hi ErrorMsg             ctermfg=0       ctermbg=1       cterm=none
hi Ignore               ctermfg=none    ctermbg=none    cterm=none
hi MatchParen           ctermfg=none    ctermbg=none    cterm=bold,underline
hi NonText              ctermfg=6
hi SpecialKey           ctermfg=6
hi Todo                 ctermfg=none    ctermbg=none    cterm=bold
hi Underlined           ctermfg=3       ctermbg=none    cterm=bold,italic
hi Visual               ctermfg=0       ctermbg=2
hi VisualNOS            ctermfg=0       ctermbg=2
hi WarningMsg           ctermfg=0       ctermbg=3       cterm=none

" Popup menu
hi Pmenu                ctermfg=none    ctermbg=15
hi PmenuSel             ctermfg=0       ctermbg=6
hi PmenuSBar            ctermbg=none    ctermbg=15
hi PmenuThumb           ctermbg=none    ctermbg=8

" Generic syntax
hi Comment              ctermfg=7                       cterm=italic
hi Constant             ctermfg=6
hi Function             ctermfg=4                       cterm=bold,italic
hi Identifier           ctermfg=none                    cterm=none
hi Operator             ctermfg=none
hi PreProc              ctermfg=none                    cterm=italic
hi Special              ctermfg=none
hi SpecialComment       ctermfg=11                      cterm=italic
hi Statement            ctermfg=2                       cterm=bold
hi String               ctermfg=11                      cterm=none
hi Type                 ctermfg=6                       cterm=bold,italic

" Spelling
hi SpellBad            ctermfg=1        ctermbg=none    cterm=underline
hi SpellCap            ctermfg=7        ctermbg=none    cterm=underline
hi SpellLocal          ctermfg=11       ctermbg=none    cterm=underline
hi SpellRare           ctermfg=13       ctermbg=none    cterm=underline

" Diff
hi DiffAdd              ctermfg=0       ctermbg=3       cterm=none,nocombine
hi DiffChange           ctermfg=6       ctermbg=15      cterm=none,nocombine
hi DiffDelete           ctermfg=0       ctermbg=5       cterm=none,nocombine
hi DiffText             ctermfg=7       ctermbg=15      cterm=bold,nocombine

" Custom section
" ------------------------------
hi Distinct             ctermfg=11      ctermbg=none    cterm=italic
hi Faded                ctermfg=8

" Languages
" ------------------------------

" Markdown
hi! link markdownHeadingRule            Faded
hi! link markdownHeadingDelimiter       Faded
hi! link markdownCodeDelimiter          Faded
hi! link markdownCodeBlock              Distinct

