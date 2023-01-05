unlet b:current_syntax

syn include @SQL syntax/sql.vim
" syntax region sqlPythonString
"      \ matchgroup=SpecialComment
"      \ start=~\z('''\|"""\)\_s*\(ALTER\|BEGIN\|CALL\|COMMENT\|COMMIT\|CONNECT\|CREATE\|DELETE\|DROP\|END\|EXPLAIN\|EXPORT\|GRANT\|IMPORT\|INSERT\|LOAD\|LOCK\|MERGE\|REFRESH\|RENAME\|REPLACE\|REVOKE\|ROLLBACK\|SELECT\|SET\|TRUNCATE\|UNLOAD\|UNSET\|UPDATE\|UPSERT\|WITH\)~
"      \ end=+\z1+
"      \ contains=@SQL
"

" vim-python/python-syntax overriders incorrectly
syn keyword pythonTodo    FIXME NOTE NOTES TODO XXX contained

let b:current_syntax = 'python'
