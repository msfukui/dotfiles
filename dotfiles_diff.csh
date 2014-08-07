#!/bin/csh -f

foreach file ( *.dot )
  if ( -d $file ) then
    cd $file
    foreach subfile ( *.dot )
      if ( -d $subfile ) then
        echo "[$file/$subfile]"
        diff -r ${HOME}/.$file:r/$subfile:r $subfile
      else
        echo "[$file/$subfile]"
        diff ${HOME}/.$file:r/.$subfile:r $subfile
      endif
    end
    cd ..
  else
    echo "[$file]"
    diff ${HOME}/.$file:r $file
  endif
end
