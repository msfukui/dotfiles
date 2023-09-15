if exists('b:did_ftplugin_php')
  finish
endif
let b:did_ftplugin_php = 1

" Projectionist setting
au User ProjectionistDetect
\ call projectionist#append(getcwd(),
\ {
\    'src/*.php': {
\      'alternate': 'tests/{}Test.php'
\    },
\    'tests/*Test.php': {
\      'alternate': 'src/{}.php'
\    },
\ })
