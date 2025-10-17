# http://daringfireball.net/projects/markdown
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# *** Note ***************************************************
# This file was modified on Oct 16, 2025 to include categories from the tangere
# colorschemes: distinct, emphatic, faded, and strong.
# See https://github.com/ftonneau/tangere-terminal
# ************************************************************

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](markdown|md|mkd) %{
    set-option buffer filetype markdown
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=markdown %{
    require-module markdown

    hook window ModeChange pop:insert:.* -group markdown-trim-indent markdown-trim-indent
    hook window InsertChar \n -group markdown-insert markdown-insert-on-new-line
    hook window InsertChar \n -group markdown-indent markdown-indent-on-new-line
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window markdown-.+ }
}

hook -group markdown-load-languages global WinSetOption filetype=markdown %{
    markdown-load-languages <percent>
}

hook -group markdown-load-languages global WinSetOption filetype=markdown %{
    hook -group markdown-load-languages window NormalIdle .* %{markdown-load-languages gtGbGl}
    hook -group markdown-load-languages window InsertIdle .* %{markdown-load-languages gtGbGl}
}


hook -group markdown-highlight global WinSetOption filetype=markdown %{
    add-highlighter window/markdown ref markdown
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/markdown }
}


provide-module markdown %§

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/markdown regions
add-highlighter shared/markdown/inline default-region regions
add-highlighter shared/markdown/inline/text default-region group

add-highlighter shared/markdown/listblock region ^\h*[-*]\s ^(?=\S) regions
add-highlighter shared/markdown/listblock/g default-region group
add-highlighter shared/markdown/listblock/g/ ref markdown/inline
add-highlighter shared/markdown/listblock/g/marker regex ^\h*([-*])\s 1:bullet
add-highlighter shared/markdown/listblock/codeblock region -match-capture ^(\h*)```\h* ^(\h*)```\h*$ regions
add-highlighter shared/markdown/listblock/codeblock/ default-region fill meta

add-highlighter shared/markdown/codeblock region -match-capture ^(\h*)```\h* ^(\h*)```\h*$ regions
add-highlighter shared/markdown/codeblock/ default-region fill meta

add-highlighter shared/markdown/codeline region "^( {4}|\t)" "$" fill distinct

# https://spec.commonmark.org/0.29/#link-destination
add-highlighter shared/markdown/angle_bracket_url region (?<=<)([a-z]+://|(mailto|magnet|xmpp):) (?!\\).(?=>)|\n fill link
add-highlighter shared/markdown/inline/url region -recurse \( (\b[a-z]+://|(mailto|magnet|xmpp):) (?!\\).(?=\))|\s fill link
add-highlighter shared/markdown/listblock/angle_bracket_url region (?<=<)(\b[a-z]+://|(mailto|magnet|xmpp):) (?!\\).(?=>)|\n fill link

try %{
    require-module html
    add-highlighter shared/markdown/inline/tag region (?i)</?[a-z][a-z0-9-]*\s*([a-z_:]|(?=>)) > ref html/tag
}

add-highlighter shared/markdown/inline/code region -match-capture (`+) (`+) fill mono

# Setext-style header
add-highlighter shared/markdown/inline/text/ regex (\A|^\n)([^\n]+)\n(={2,})\h*\n\h*$ 2:title 3:faded
add-highlighter shared/markdown/inline/text/ regex (\A|^\n)([^\n]+)\n(-{2,})\h*\n\h*$ 2:header 3:faded

# Atx-style header
add-highlighter shared/markdown/inline/text/ regex ^(#+)([^\n]*) 1:faded 2:strong

# Text styles
# We allow up to 3 lines of 80 characters each (= 240) between two italics marks.
add-highlighter shared/markdown/inline/text/ regex (?<![_\\])(_)([^_\s]|[^_\s].{,240}?[^_\s])(_)(?!_) 1:faded 2:emphatic 3:faded
add-highlighter shared/markdown/inline/text/ regex (?<![\*\\])(\*)([^\*\s]|[^\*\s].{,240}?[^\*\s])(\*)(?!\*) 1:faded 2:emphatic 3:faded

add-highlighter shared/markdown/inline/text/ regex (?<![_\\])(__)([^_\s]|[^_\s].{,240}?[^_\s])(__) 1:faded 2:strong 3:faded
add-highlighter shared/markdown/inline/text/ regex (?<![\*\\])(\*\*)([^\*\s]|[^\*\s].{,240}?[^\*\s])(\*\*) 1:faded 2:strong 3:faded

add-highlighter shared/markdown/inline/text/ regex ^\h*(>\h*)+ 0:faded  # => handle for quoted paragraphs

# Commands
# ‾‾‾‾‾‾‾‾

define-command markdown-load-languages -params 1 %{
    evaluate-commands -draft %{ try %{
        execute-keys "%arg{1}1s```\h*(\w+)<ret>"
        evaluate-commands -itersel %{ try %{
            require-module %val{selection}

            add-highlighter "shared/markdown/codeblock/%val{selection}" region -match-capture "^(\h*)```\h*%val{selection}\b" "(^\h*)```" regions
            add-highlighter "shared/markdown/codeblock/%val{selection}/outer" default-region group
            add-highlighter "shared/markdown/codeblock/%val{selection}/outer/fence" regex (```)([^\n]*) 1:faded 2:distinct
            add-highlighter "shared/markdown/codeblock/%val{selection}/inner" region \A\h*```[^\n]*\K (?=```) ref %val{selection}

            add-highlighter "shared/markdown/listblock/codeblock/%val{selection}" region -match-capture "^(\h*)```\h*%val{selection}\b" "(^\h*)```" regions
            add-highlighter "shared/markdown/listblock/codeblock/%val{selection}/outer" default-region group
            add-highlighter "shared/markdown/listblock/codeblock/%val{selection}/outer/fence" regex (```)([^\n]*) 1:faded 2:distinct
            add-highlighter "shared/markdown/listblock/codeblock/%val{selection}/inner" region \A\h*```[^\n]*\K (?=```) ref %val{selection}
        }}
    }}
}

define-command -hidden markdown-trim-indent %{
    evaluate-commands -no-hooks -draft -itersel %{
        execute-keys x
        # remove trailing white spaces
        try %{ execute-keys -draft s \h + $ <ret> d }
    }
}

define-command -hidden markdown-insert-on-new-line %{
    try %{ execute-keys -draft -itersel k x s ^\h*\K((>\h*)+([*+-]\h)?|(>\h*)*[*+-]\h)\h* <ret> y gh j P }
}

define-command -hidden markdown-indent-on-new-line %{
    evaluate-commands -draft -itersel %{
        # preserve previous line indent
        try %{ execute-keys -draft <semicolon> K <a-&> }
        # remove trailing white spaces
        try %{ execute-keys -draft k x s \h+$ <ret> d }
    }
}

§
