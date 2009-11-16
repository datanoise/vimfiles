if !g:XPTloadBundle('javascript', 'extjs')
  finish
endif

XPTemplate priority=lang-2

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common

fun! s:f.JSToSnakeCase()
  return self.S(self.SV('[A-Z]', '_\l&', 'g'), '\<_', '', '')
endfunction

XPTemplateDef

XPT ecls hint=Define\ Class
`namespace^.`class^ = Ext.extend(`base^, {
    `
    `property...^`
    `property^: `value^,`
    `property...^
    initComponent: function() {
        `cursor^
        `namespace^.`class^.superclass.initComponent.apply(this, arguments);
    }
});
Ext.reg("`class^JSToSnakeCase()^", `namespace^.`class^);

XPT p hint=property
`property^: `value^`
`property...^,
`property^: `value^`,
`property...^

