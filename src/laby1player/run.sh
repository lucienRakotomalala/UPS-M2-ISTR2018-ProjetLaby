#!/bin/bash
# script qui compile le doxy, make le pdf et l'ouvre
doxygen Doxyfile
cd latex/
make all
#evince refman.pdf &
cd ..
