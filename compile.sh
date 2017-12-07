#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo '(compile-file "lib/gl_4_1.scm")' | chez -q
echo '(compile-file "lib/glfw.scm")' | chez -q
echo '(compile-file "lib/match.scm")' | chez -q
echo '(compile-file "main.scm")' | chez -q

