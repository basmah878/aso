#!/bin/bash
# Mostrar cuántos archivos y carpetas hay en un directorio

#!/bin/bash
dir=$1
f=$(find "$dir" 1 -type f | wc -l)
d=$(find "$dir"  1 -type d | wc -l)	"

fi
