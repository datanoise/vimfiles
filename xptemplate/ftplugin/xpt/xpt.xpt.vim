XPTemplate priority=sub

let s:f = g:XPTfuncs() 
 
XPTinclude 
      \ _common/common
      \ vim/vim


" ========================= Function and Variables =============================

fun! s:f.hintEscape()
  " let v = substitute( self.V(), '\(\\*\)\([( ]\)', '\1\1\\\2', 'g' )
  let v = substitute( self.V(), '\(\\*\)\([(]\)', '\1\1\\\2', 'g' )
  return v
endfunction

let s:xpt_snip = split( globpath( &rtp, "**/*.xpt.vim" ), "\n" )
call map( s:xpt_snip, 'substitute(v:val, ''\V\'', ''/'', ''g'')' )
call map( s:xpt_snip, 'matchstr(v:val, ''\Vftplugin/\zs\.\*\ze.xpt.vim'')' )

let s:xpts = {}
for v in s:xpt_snip
  let [ ft, snip ] = split( v, '/' )
  if !has_key( s:xpts, ft )
    let s:xpts[ ft ] = []
  endif

  let s:xpts[ ft ] += [ snip ]
endfor

" echom string( s:xpts )



fun! s:f.xpt_vim_path()
  return keys( s:xpts )
endfunction

fun! s:f.xpt_vim_name(path)
  let path = matchstr( a:path, '\w\+' )
  if has_key( s:xpts, path )
    return s:xpts[ path ]
  else 
    return ''
  endif
endfunction

" ================================= Snippets ===================================
XPTemplateDef

" TODO detect path to generate popup list 
XPT incf hint=XPTinclude\ ...
XSET path=xpt_vim_path()
XSET name=xpt_vim_name( R( 'path' ) )
XPTinclude 
    \ _common/common`
    `...{{^`
    \ `path^/`name^`
    `...^`}}^


XPT container hint=let\ [s:f,\ s:v]\ =...
let s:f = g:XPTfuncs() 


XPT tmpl hint=XPT\ name\ ...
XSET tips|post=hintEscape()
\XPT `name^ " `tips^
`cursor^


XPT snip alias=tmpl


XPT var hint=XPTvar\ $***\ ***
XSET name|post=UpperCase(V())
XSET value|post=escape(V(), ' ')
XPTvar $`name^ `cursor^


XPT varLang hint=variables\ to\ define\ language\ properties
" variable prefix
XPTvar $VAR_PRE            


XPT varFormat hint=variables\ to\ define\ format
" if () ** {
XPTvar $BRif     ' '
" } ** else {
XPTvar $BRel   \n
" for () ** {
XPTvar $BRfor    ' '
" while () ** {
XPTvar $BRwhl  ' '
" struct name ** {
XPTvar $BRstc ' '
" int fun() ** {
XPTvar $BRfun   ' '
" class name ** {
XPTvar $BRcls    ' '


XPT varSpaces hint=variable\ to\ define\ spacing
" int fun( ** arg ** )
XPTvar $SParg      ' '
" if ** ( 
XPTvar $SPif       ' '
" if ( ** condition ** )
XPTvar $SPcnd      ' '
" a ** = ** b
XPTvar $SPeq       ' '
" a = a ** + ** 1
XPTvar $SPop       ' '
" (a, ** b, ** )
XPTvar $SPcm       ' '


XPT varConst hint=variables\ to\ define\ constants
XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $UNDEFINED     NULL


XPT varHelper hint=variables\ to\ define\ helper\ place\ holders
XPTvar $VOID_LINE      
XPTvar $CURSOR_PH      


XPT varComment1 hint=variables\ to\ define\ single\ sign\ comments
XPTvar $CS    `cursor^


XPT varComment2 hint=variables\ to\ define\ double\ sign\ comments
XPTvar $CL    `left sign^
XPTvar $CM    `cursor^
XPTvar $CR    `right sign^

XPT sparg " `\$SParg^
\`$SParg\^

XPT spcnd hint=`\$SPcnd^
\`$SPcnd\^

XPT speq hint=`\$SPeq^
\`$SPeq\^

XPT spop hint=`\$SPop^
\`$SPop\^

XPT spcomma hint=`\$SPcm^
\`$SPcm\^

XPT buildifeq hint={{}}
\``name^{{\^`cursor^\`}}\^

XPT inc hint=`::^
\`:`name^:\^


XPT fun hint=fun!\ s:f.**
XSET parameters|def=
XSET parameters|post=Echo( V() =~ '^\s*$' ? '' : V() )
fun! s:f.`name^(` `parameters` ^)
    `cursor^
endfunction



XPT xpt hint=start\ template\ to\ write\ template
XPTemplate priority=`prio^` `mark...^
XSET prio=ChooseStr( 'all', 'spec', 'like', 'lang', 'sub', 'personal' )
XSET keyword_disable...|post= keyword=`char^
XSET mark...|post= mark=`char^
XSET indent_disable...|post= indent=`indentValue^
XSET indentValue=ChooseStr( 'auto', 'keep' )

let s:f = g:XPTfuncs() 

`Include:varConst^

`Include:varFormat^

`XPTinclude...{{^`Include:incf^`}}^


" ========================= Function and Variables =============================

" ================================= Snippets ===================================
XPTemplateDef


`cursor^

" ================================= Wrapper ===================================

..XPT


