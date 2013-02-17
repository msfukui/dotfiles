#!/bin/csh -f

foreach file ( *.dot )
  if ( -d $file ) then
    cd $file
    foreach subfile ( *.dot )
      cp -p $subfile ${HOME}/.$file:r/.$subfile:r
    end
    cd ..
  else
    cp -p $file ${HOME}/.$file:r
  endif
end
