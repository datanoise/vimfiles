if !g:XPTloadBundle('javascript', 'extjs')
  finish
endif

XPTemplate priority=lang-2

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common

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
Ext.reg("`class^SV('\<.','\l&', '' )^", `namespace^.`class^);


