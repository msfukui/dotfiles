if exists('b:did_ftplugin_php')
  finish
endif
let b:did_ftplugin_php = 1

" Projectionist setting
au User ProjectionistDetect
\ call projectionist#append(getcwd(),
\ {
\    'src/*.php': {
\      'alternate': ['tests/{}Test.php', 'tests/Unit/{}Test.php', 'tests/Feature/{}Test.php']
\    },
\    'tests/*Test.php': {
\      'alternate': 'src/{}.php'
\    },
\    'tests/Unit/*Test.php': {
\      'alternate': 'src/{}.php'
\    },
\    'tests/Feature/*Test.php': {
\      'alternate': 'src/{}.php'
\    },
\ })
