if exists('b:did_ftplugin_ruby')
  finish
endif
let b:did_ftplugin_ruby = 1

" Projectionist setting
au User ProjectionistDetect
\ call projectionist#append(getcwd(),
\ {
\    'app/*.rb': {
\      'alternate': ['tests/{}_test.rb', 'test/{}_test.rb', 'spec/{}_spec.rb']
\    },
\    'spec/*_spec.rb': {
\      'alternate': ['lib/{}.rb', 'app/{}.rb']
\    },
\    'lib/*.rb': {
\      'alternate': ['tests/{}_test.rb', 'test/{}_test.rb', 'spec/{}_spec.rb']
\    },
\    'test/*_test.rb': {
\      'alternate': ['lib/{}.rb', 'app/{}.rb']
\    },
\    'tests/*_test.rb': {
\      'alternate': ['lib/{}.rb', 'app/{}.rb']
\    },
\ })
