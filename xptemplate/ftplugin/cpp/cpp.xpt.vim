XPTemplate priority=sub

" Setting priority of cpp to "sub" or "subset of language", makes it override
" all c snippet if conflict



XPTvar $TRUE          true
XPTvar $FALSE         false
XPTvar $NULL          NULL

XPTvar $BRif     \n
XPTvar $BRloop    \n
XPTvar $BRloop  \n
XPTvar $BRstc \n
XPTvar $BRfun   \n

XPTvar $TypeAbove 0

XPTvar $VOID_LINE  /* void */;
XPTvar $CURSOR_PH      /* cursor */

XPTvar $CL  /*
XPTvar $CM   *
XPTvar $CR   */

XPTvar $CS   //



XPTinclude
      \ _common/common
      \ _comment/singleDouble
      \ _condition/c.like
      \ _func/c.like
      \ _loops/c.while.like
      \ _loops/java.for.like
      \ _preprocessor/c.like
      \ _structures/c.like
XPTinclude
            \ c/c

" ========================= Function and Variables =============================
let s:f = g:XPTfuncs()

function! s:f.cleanTempl( ctx, ... )
  let cleaned = substitute( a:ctx, '\s*\(class\|typename\|int\|long\)\s*', '', 'g' )
  return cleaned
endfunction

let s:defaultImpl = { 'void'  : ''
                   \, 'int'   : "\treturn 0;"
                   \, 'unsigned int'   : "\treturn 0;"
                   \, 'short' : "\treturn 0;"
                   \, 'unsigned short' : "\treturn 0;"
                   \, 'char'  : "\treturn '\0';"
                   \, 'unsigned char'  : "\treturn '\0';"
                   \, 'double': "\treturn 0.0;"
                   \, 'float' : "\treturn 0.0f;"
                   \, 'bool'  : "\treturn false;"
                   \}

let s:todo = "\t/* TODO : implement here */"

fun! s:GetDefaultImplementation( type )

    if has_key( s:defaultImpl, a:type )
        return s:defaultImpl[ a:type ]
    endif

    if a:type =~ '.*\*$'
        return "return NULL;"
    endif

    return ''
endfunction

fun! s:GetImplementationFile() "{{{
    let name = expand('%:p')
    
    if name =~ '\.h$'
        let name = substitute( name, 'h$', '[cC]*', '' )
    elseif name =~ '\.hpp$'
        let name = substitute( name, 'hpp$', '[cC]*', '' )
    endif

    return glob( name )
endfunction "}}}

" Count the number of blanck character before anything interesting
" has happened
fun! s:CalculateIndentation( ln ) "{{{
    let i = 0
    let spacecount = 0
    let maxi = len( a:ln )

    while i < maxi
        let c = (a:ln)[i]
        if c == ' '
            let spacecount = spacecount + 1
        elseif c == '\t'
            let spacecount = spacecount + &tabstop
        else
            break
        endif

        let i = i + 1
    endwhile

    return i
endfunction "}}}

fun! s:f.GetLastStructClassDeclaration() "{{{
    let lineNum = line('.')
    let ourIndentation = s:CalculateIndentation( getline( lineNum ))

    let lineNum = lineNum - 1

    while lineNum >= 0
        let txt = getline( lineNum )

        if txt =~ '\(struct\)\|\(class\)'
            if s:CalculateIndentation( txt ) < ourIndentation
                return substitute( txt, '\s*\(\(struct\)\|\(class\)\)\s\+\(\S\+\).*', '\4', '' )
            endif
        endif

        let lineNum = lineNum - 1
    endwhile

    return ""
endfunction "}}}

fun! s:f.WriteCtorToCpp() " {{{
    let imple = s:GetImplementationFile()
    if imple == ''
        return
    endif

    let englobingClass = self.R('className')

    let args = self.R( 'ctorArgs' )
    let methodBody = [ englobingClass . '::' . englobingClass . '(' . args . ')'
                   \ , '{'
                   \ , '}'
                   \ , '' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return args
endfunction " }}}

fun! s:f.WriteDtorToCpp() " {{{
    let imple = s:GetImplementationFile()
    if imple == ''
        return
    endif

    let englobingClass = self.R('className')

    let methodBody = [ englobingClass . '::~' . englobingClass . '()'
                   \ , '{'
                   \ , '}'
                   \ , '' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return ''
endfunction " }}}

fun! s:f.WriteStaticToCpp()
    let name = self.R('name')

    let imple = s:GetImplementationFile()
    if imple == ''
        return name
    endif

    let englobingClass = self.GetLastStructClassDeclaration()
    if englobingClass == ''
        return name
    endif

    let methodBody = [ self.R('fieldType') . '    ' . englobingClass . '::' . name . ';' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return name
endfunction

fun! s:f.WriteCopyCtorToCpp() " {{{
    let cpy = self.R('cpy')

    let imple = s:GetImplementationFile()
    if imple == ''
        return cpy
    endif

    let englobingClass = self.R('className')

    let methodBody = [ englobingClass . '::' . englobingClass . '( const ' . englobingClass . ' &' . cpy . ' )'
                   \ , '{'
                   \ , '}'
                   \ , '' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return cpy
endfunction " }}}

fun! s:f.WriteMethodToCpp() "{{{
    let imple = s:GetImplementationFile()
    if imple == ''
        return ''
    endif

    let englobingClass = self.GetLastStructClassDeclaration()
    if englobingClass == ''
        return ''
    endif

    let args = self.R( 'args' )
    let constness = self.R( 'const?...' )
    let retType = self.R( 'retType' )
    let methodBody = [ retType . ' ' . englobingClass . '::' . self.R('funcName')
                                \ . '(' . args . ')' . constness
                   \ , '{'
                   \ , s:todo
                   \ , s:GetDefaultImplementation( retType )
                   \ , '}'
                   \ , '' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return ''
endfunction "}}}

fun! s:f.WriteOpOverloadToCpp()
    let imple = s:GetImplementationFile()
    if imple == ''
        return ''
    endif

    let englobingClass = self.GetLastStructClassDeclaration()
    if englobingClass == ''
        return ''
    endif

    let inputType = self.R( 'inputType' )
    let argName = self.R('inName' )
    let constness = self.R( 'const?...' )
    let retType = self.R( 'retType' )
    let methodBody = [ retType . ' ' . englobingClass . '::operator ' . self.R('opName')
                                \ . '( const ' . inputType . ' ' . argName . ' )' . constness
                   \ , '{'
                   \ , s:todo
                   \ , s:GetDefaultImplementation( retType )
                   \ , '}'
                   \ , '' ]

    let txt = extend( readfile( imple ), methodBody )
    call writefile( txt, imple )

    return ''
    
endfunction

" ================================= Snippets ===================================
XPTemplateDef

XPT all " ...begin, ...end,
`v^.begin(), `v^.end(), `cursor^
..XPT

XPT vector " std::vector<..> ..;
std::vector<`type^> `var^;
..XPT

XPT map " std::map<.., ..> ..;
std::map<`typeKey^,`val^>   `name^;
..XPT

XPT hstruct " struct with skeletons written into .cpp
struct `className^
{
    `constructor...{{^`^R('className')^( `ctorArgs^WriteCtorToCpp()^^ );
    `}}^`destructor...{{^~`^R('className')^(`^WriteDtorToCpp()^^);
    `}}^`copy constructor...{{^`^R('className')^( const `^R('className')^ &`cpy^WriteCopyCtorToCpp()^^ );
    `}}^`cursor^
};
..XPT

XPT hclass " class with skeletons written into .cpp
class `className^
{
public:
    `constructor...{{^`^R('className')^( `ctorArgs^WriteCtorToCpp()^^ );
    `}}^`destructor...{{^~`^R('className')^(`^WriteDtorToCpp()^^);
    `}}^`copy constructor...{{^`^R('className')^( const `^R('className')^ &`cpy^WriteCopyCtorToCpp()^^ );
    `}}^`cursor^
private:
};
..XPT

XPT hctor " Class constructor writing skeleton to cpp
`className^GetLastStructClassDeclaration()^( `ctorArgs^WriteCtorToCpp()^^ );
..XPT

XPT hdtor " Class destructor writing skeleton to cpp
XSET cursor=WriteDtorToCpp()
~`className^GetLastStructClassDeclaration()^();`cursor^
..XPT

XPT hcopyctor " Class copy constructor writing skeleton to cpp
`className^GetLastStructClassDeclaration()^( const `className^ `cpy^WriteCopyCtorToCpp()^^ );
..XPT

XPT hoperator " operator overloading writing skeleton to cpp
XSET cursor=WriteOpOverloadToCpp()
`retType^GetLastStructClassDeclaration()&^  operator `opName^( const `inputType^GetLastStructClassDeclaration()&^ `inName^ )`const?...{{^ const`}}^;`cursor^
..XPT

XPT class " class\ { public: ... };
class `className^
{
public:
    `className^( `ctorParam^ );
    ~`className^();
    `className^( const `className^ &cpy );
    `cursor^
private:
};

`className^::`className^( `ctorParam^ )
{
}

`className^::~`className^()
{
}

`className^::`className^( const `className^ &cpy )
{
}
..XPT

XPT hstatic " Static field + implementation
XSET name|post=WriteStaticToCpp()
static `fieldType^     `name^;
..XPT

XPT hmethod " class method + implementation
XSET cursor=WriteMethodToCpp()
`retType^   `funcName^( `args^ )`const?...{{^ const`}}^;`cursor^
..XPT

XPT functor " class ... { operator () ... };
struct `className^
{
    `closure...{{^`type^  `what^;
    `_^R('className')^( `type^ n`what^ ) : `what^( n`what^ ) {}

    `}}^`outType^   operator() ( `params^ )
    {
        `cursor^
    }
};
..XPT

XPT namespace " namespace { ... }
namespace `name^
{
    `cursor^
}
..XPT

XPT icastop " operator type ...
operator `typename^ ()
    { return `cursor^; }
..XPT

XPT castop " operator type ...
operator `typename^ ();

`className^::operator `typename^ ();
    { return `cursor^; }
..XPT

XPT iop "t operator ... ()
`type^ operator `opName^ ( `args^ )
{
    `cursor^
}
..XPT

XPT op " t operator ... ()
`type^ operator `opName^ ( `args^ );

`type^ `className^::operator `opName^ ( `args^ )
{
}
..XPT

XPT templateclass " template <...> class { ... }; ...
template
    <`templateParam^>
class `className^
{
public:
    `className^( `ctorParam^ );
    ~`className^();
    `className^( const `className^ &cpy );
    `cursor^
private:
};

template <`templateParam^>
`className^<`_^cleanTempl(R('templateParam'))^^>::`className^( `ctorParam^ )
{
}

template <`templateParam^>
`className^<`_^cleanTempl(R('templateParam'))^^>::~`className^()
{
}

template <`templateParam^>
`className^<`_^cleanTempl(R('templateParam'))^^>::`className^( const `className^ &cpy )
{
}
..XPT

XPT head  " /////////////////\ ...
///////////////////////////////////////////////////////////
////                `headerText^
///////////////////////////////////////////////////////////
..XPT

XPT try " try ... catch...
XSET handler=$CL void $CR
try
{
    `what^
}`...^
catch ( `except^ )
{
    `handler^
}`...^
..XPT

XPT namespace_ " namespace ... { SEL }
namespace `namspaceName^
{
    `wrapped^
}
..XPT

XPT try_ " try { SEL } catch...
XSET handler=$CL void $CR
try
{
    `wrapped^
}
`...^catch ( `except^ )
{
    `handler^
}
`...^

..XPT
