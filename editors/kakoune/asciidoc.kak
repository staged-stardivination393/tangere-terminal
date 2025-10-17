# http://asciidoc.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# *** Note ***************************************************
# This file was modified on Oct 16, 2025 to include categories from the tangere
# colorschemes: adjunct, distinct, emphatic, faded, salient, and strong.
# See https://github.com/ftonneau/tangere-terminal
# ************************************************************

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.(a(scii)?doc|asc) %{
    set-option buffer filetype asciidoc
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group asciidoc-highlight global WinSetOption filetype=asciidoc %{
    require-module asciidoc

    add-highlighter window/asciidoc ref asciidoc
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/asciidoc }
}

provide-module asciidoc %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/asciidoc group

# Titles and headers (multi-line style)
add-highlighter shared/asciidoc/ regex (\A|\n\n)([^\n]+)\n(={2,})\h*$ 2:title 3:faded
add-highlighter shared/asciidoc/ regex (\A|\n\n)([^\n]+)\n(-{2,})\h*$ 2:header 3:faded
add-highlighter shared/asciidoc/ regex (\A|\n\n)([^\n]+)\n(~{2,})\h*$ 2:header 3:faded
add-highlighter shared/asciidoc/ regex (\A|\n\n)([^\n]+)\n(\^{2,})\h*$ 2:header 3:faded
add-highlighter shared/asciidoc/ regex (\A|\n\n)([^\n]+)\n(\+{2,})\h*$ 2:header 3:faded

# Titles and headerss (one-line style)
add-highlighter shared/asciidoc/ regex (\A|\n\n)(=)\h+([^\n]+)$ 2:faded 3:title
add-highlighter shared/asciidoc/ regex (\A|\n\n)(={2,})\h+([^\n]+)$ 2:faded 3:header

# Comments
add-highlighter shared/asciidoc/ regex ^//(?:[^\n/][^\n]*|)$ 0:comment
add-highlighter shared/asciidoc/ regex ^(/{4,}).*?\n(/{4,})$ 0:comment

# List titles
add-highlighter shared/asciidoc/ regex ^\.[^\h\W][^\n]*$ 0:title

# Bulleted lists
add-highlighter shared/asciidoc/ regex ^\h*([-\*])\h+[^\n]+$ 0:list 1:bullet
add-highlighter shared/asciidoc/ regex ^\h*([-\*]+)\h+[^\n]+(\n\h+[^-\*\n]*)?$ 0:list 1:bullet

# Delimited blocks
# https://docs.asciidoctor.org/asciidoc/latest/blocks/delimited/
add-highlighter shared/asciidoc/ regex ^(-{4,})\n[^\n\h].*?\n(-{4,})$ 0:block
add-highlighter shared/asciidoc/ regex ^(={4,})\n[^\n\h].*?\n(={4,})$ 0:block
add-highlighter shared/asciidoc/ regex ^(~{4,})\n[^\n\h].*?\n(~{4,})$ 0:block
add-highlighter shared/asciidoc/ regex ^(\*{4,})\n[^\n\h].*?\n(\*{4,})$ 0:block

# Monospaced text
add-highlighter shared/asciidoc/ regex \B(\+)([^+][^\n]+?)(\+)\B 1:faded 2:mono 3:faded
add-highlighter shared/asciidoc/ regex \B(`)([^`][^\n]+?)(`)\B 1:faded 2:mono 3:faded

# Bolded text
add-highlighter shared/asciidoc/ regex \s(\*)([^\n\*]+)(\*)\B 1:faded 2:strong 3:faded
add-highlighter shared/asciidoc/ regex \h(\*)([^\n\*]+)(\*)\B 1:faded 2:strong 3:faded
add-highlighter shared/asciidoc/ regex (\*{2})(?!\h)([^\n\*]+)(\*{2}) 1:faded 2:strong 3:faded
add-highlighter shared/asciidoc/ regex \h(\*{2})[^\n\*]+(\*{2}) 1:faded 2:strong 3:faded

# Italicized text
# These are simpler because italic marks cannot be bullets.
add-highlighter shared/asciidoc/ regex \b(_)([^\n]+?)(_)\b 1:faded 2:emphatic 3:faded
add-highlighter shared/asciidoc/ regex (__)([^\n]+?)(__) 1:faded 2:emphatic 3:faded

# Subscripts and superscripts
add-highlighter shared/asciidoc/ regex [^\\](~)([^\n]+?)(~) 1:faded 2:salient 3:faded
add-highlighter shared/asciidoc/ regex [^\\](\^)([^\n]+?)(\^) 1:faded 2:salient 3:faded

# Attributes
add-highlighter shared/asciidoc/ regex ^:(?:(!?)[-\w]+|[-\w]+(!?)): 0:adjunct 1:distinct 2:distinct
add-highlighter shared/asciidoc/ regex [^\\](\{[-\w]+\})[^\\]? 1:adjunct

# Options
add-highlighter shared/asciidoc/ regex ^\[[^\n]+\]$ 0:adjunct

# Admonition paragraphs
add-highlighter shared/asciidoc/ regex ^(NOTE|TIP|IMPORTANT|CAUTION|WARNING): 0:distinct
add-highlighter shared/asciidoc/ regex ^\[(NOTE|TIP|IMPORTANT|CAUTION|WARNING)\]$ 0:distinct

# Paragraph styles
add-highlighter shared/asciidoc/ regex ^\[(normal|literal|verse|quote|listing|abstract|partintro)[^\n]*?\]) 0:distinct
add-highlighter shared/asciidoc/ regex ^\[(comment|example|sidebar|source|music|latex|graphviz)[^\n]*?\]) 0:distinct

# Links, inline macros
add-highlighter shared/asciidoc/ regex \b((?:https?|ftp|irc://)[^\h\[]+)(\[[^\n]*?\]) 1:link 2:adjunct
add-highlighter shared/asciidoc/ regex (link|mailto):([^\n]+)(\[[^\n]*\]) 1:distinct 2:link 3:adjunct
add-highlighter shared/asciidoc/ regex (xref):([^\n]+)(\[[^\n]*\]) 1:distinct 2:link 3:adjunct
add-highlighter shared/asciidoc/ regex <<[^\n><]+>> 0:salient

# Commands
# ‾‾‾‾‾‾‾‾

}
