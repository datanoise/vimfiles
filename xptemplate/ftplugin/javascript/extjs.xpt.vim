if !g:XPTloadBundle('javascript', 'extjs')
  finish
endif

XPTemplate priority=lang-2

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common

fun! s:f.JSToSnakeCase()
  return self.S(self.SV('[A-Z]\+', '_\l&', 'g'), '\<_', '', '')
endfunction

XPTemplateDef

XPT p hint=property
`property^: `value^`
`property...^,
`property^: `value^`,
`property...^

XPT conf hint=Apply\ config
XSET property=Trigger('p')
var config = {
    `property^
};
Ext.apply(this, config);

XPT class hint=Define\ Class
XSET config...|post=`config^
XSET config=Trigger('conf')
`namespace^.`class^ = Ext.extend(`base^, {
    `
    `property...^`
    `property^: `value^,`
    `property...^
    initComponent: function() {
        `config...^
        `namespace^.`class^.superclass.initComponent.apply(this, arguments);
        `cursor^
    }
});
Ext.reg("`class^JSToSnakeCase()^", `namespace^.`class^);

