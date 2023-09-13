if exists('b:did_ftplugin_go')
  finish
endif
let b:did_ftplugin_go = 1

" Projectionist setting
au User ProjectionistDetect
\ call projectionist#append(getcwd(),
\ {
\    '*.go': {
\      'alternate': '{}_test.go'
\    },
\    '*_test.go': {
\      'alternate': '{}.go'
\    },
\ })
