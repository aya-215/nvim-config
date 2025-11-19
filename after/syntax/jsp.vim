" Vim syntax file
" Language:     JSP (JavaServer Pages)
" Maintainer:   Auto-generated from vscode-jsp
" Last Change:  2025
" Based on:     https://github.com/pthorsson/vscode-jsp

if exists("b:current_syntax")
  finish
endif

" HTMLをベースとして読み込み
runtime! syntax/html.vim
unlet! b:current_syntax

" Java構文を埋め込み用に読み込み
if version < 600
  syntax include @javaTop <sfile>:p:h/java.vim
else
  syntax include @javaTop syntax/java.vim
endif

" JSPコメント: <%-- ... --%>
syntax region jspComment start=+<%--+ end=+--%>+ contains=jspCommentTodo
syntax keyword jspCommentTodo contained TODO FIXME XXX NOTE

" JSPディレクティブ: <%@ ... %>
syntax region jspDirective start=+<%@+ end=+%>+ contains=jspDirectiveAttr,jspDirectiveName
syntax match jspDirectiveName contained "\(page\|include\|taglib\|tag\|attribute\|variable\)"
syntax match jspDirectiveAttr contained '\w\+\s*=\s*"[^"]*"'
syntax match jspDirectiveAttr contained "\w\+\s*=\s*'[^']*'"

" JSP宣言: <%! ... %>
syntax region jspDeclaration start=+<%!+ end=+%>+ contains=@javaTop

" JSP式: <%= ... %>
syntax region jspExpression start=+<%=+ end=+%>+ contains=@javaTop

" JSPスクリプトレット: <% ... %>
syntax region jspScriptlet start=+<%[^@!=]+ start=+<%\s+ end=+%>+ contains=@javaTop

" EL式: ${ ... } と #{ ... }
syntax region jspEL start=+\${+ end=+}+ contains=jspELKeyword,jspELOperator
syntax region jspEL start=+#{+ end=+}+ contains=jspELKeyword,jspELOperator
syntax keyword jspELKeyword contained empty true false null eq ne lt le gt ge and or not div mod
syntax match jspELOperator contained "[+\-*/%<>=!&|?:]"

" JSP標準アクション: <jsp:XXX>
syntax region jspTag start=+<jsp:\w\++ end=+>+ contains=jspTagName,jspTagAttr,htmlString
syntax region jspTagClose start=+</jsp:\w\++ end=+>+ contains=jspTagName
syntax match jspTagName contained "\<jsp:\w\+"
syntax match jspTagAttr contained '\w\+\s*=\s*"[^"]*"'
syntax match jspTagAttr contained "\w\+\s*=\s*'[^']*'"

" JSTL/カスタムタグ: <c:XXX>, <fmt:XXX> など
syntax region jspCustomTag start=+<\w\+:\w\++ end=+>+ contains=jspCustomTagName,jspTagAttr,htmlString
syntax region jspCustomTagClose start=+</\w\+:\w\++ end=+>+ contains=jspCustomTagName
syntax match jspCustomTagName contained "\<\w\+:\w\+"

" HTML属性内のJSP要素をサポート
syntax cluster htmlPreproc add=jspExpression,jspEL

" ハイライトグループの定義
highlight default link jspComment Comment
highlight default link jspCommentTodo Todo
highlight default link jspDirective PreProc
highlight default link jspDirectiveName Statement
highlight default link jspDirectiveAttr Type
highlight default link jspDeclaration Function
highlight default link jspExpression Identifier
highlight default link jspScriptlet Special
highlight default link jspEL String
highlight default link jspELKeyword Keyword
highlight default link jspELOperator Operator
highlight default link jspTag Type
highlight default link jspTagClose Type
highlight default link jspTagName Type
highlight default link jspTagAttr htmlArg
highlight default link jspCustomTag Type
highlight default link jspCustomTagClose Type
highlight default link jspCustomTagName Type

let b:current_syntax = "jsp"
