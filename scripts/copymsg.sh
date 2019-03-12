 #!/bin/bash

 mkdir "${HOME}/.hasdoc"
 mkdir "${HOME}/.hasdoc-gen"
 cp -f "${PWD}/data/translations/"* "${HOME}/.hasdoc" 
 cp -f "${PWD}/src/subprojects/hasdoc-gen/data/translations/"* "${HOME}/.hasdoc-gen" 
