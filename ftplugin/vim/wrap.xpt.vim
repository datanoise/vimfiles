if exists("b:__VIM_WRAP_XPT_VIM__")
    finish
endif
let b:__VIM_WRAP_XPT_VIM__ = 1


XPTinclude
      \ _common/common
"================ Wrapped Items ================"
XPTemplateDef

XPT invoke_ hint=call\ ..(SEL)
call `name^(`wrapped^)


XPT if_ hint=if\ SEL\ endif
if `condition^
  `wrapped^
end
