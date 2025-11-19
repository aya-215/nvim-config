" Vim filetype plugin file
" Language:     JSP (JavaServer Pages)
" Maintainer:   Auto-generated
" Last Change:  2025

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" HTML ftpluginを継承
runtime! ftplugin/html.vim

" JSPコメントの設定
setlocal commentstring=<%--\ %s\ --%>
setlocal comments=s:<%--,e:--%>

" キーワードに':'を含める（カスタムタグ対応: <c:forEach> など）
setlocal iskeyword+=:

" インデント設定（HTMLベース）
setlocal autoindent
setlocal smartindent

" マッチペア設定
setlocal matchpairs+=<:>

" includeexpr設定（Javaのパッケージパスに対応）
setlocal includeexpr=substitute(v:fname,'\\.','/','g')

" suffixesadd設定（インポート時の拡張子補完）
setlocal suffixesadd=.java,.jsp

" アンドゥポイント用
let b:undo_ftplugin = "setlocal commentstring< comments< iskeyword< autoindent< smartindent< matchpairs< includeexpr< suffixesadd<"
