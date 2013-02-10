#!/bin/csh -f

foreach file ( *.dot )
  cp -p $file ${HOME}/.$file:r
end
