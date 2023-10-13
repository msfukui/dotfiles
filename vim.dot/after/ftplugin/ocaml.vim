if exists('b:did_ftplugin_ocaml')
  finish
endif
let b:did_ftplugin_ocaml = 1

" Projectionist setting
au User ProjectionistDetect
\ call projectionist#append(getcwd(),
\ {
\    'src/*.ml': {
\      'alternate': ['tests/{}_test.ml', 'test/{}_test.ml']
\    },
\    'lib/*.ml': {
\      'alternate': ['tests/{}_test.ml', 'test/{}_test.ml']
\    },
\    'tests/*_test.ml': {
\      'alternate': ['src/{}.ml', 'lib/{}.ml']
\    },
\    'test/*_test.ml': {
\      'alternate': ['src/{}.ml', 'lib/{}.ml']
\    },
\ })
