#!/bin/sh
conv() {
	#BUG(poptart): Off by one on generation... it's technically wrong
	printf '%0.16f\n' "$(echo "scale=17; $1.0 / 255.0" | bc -l)"
}

exec_func() {
	hexinput=$(echo $1 | tr '[:lower:]' '[:upper:]' | tr -d "#")  # uppercase-ing
	
	a=$(echo $hexinput | cut -c-2)
	b=$(echo $hexinput | cut -c3-4)
	c=$(echo $hexinput | cut -c5-6)
	
	r=$(echo "ibase=16; $a" | bc)
	g=$(echo "ibase=16; $b" | bc)
	b=$(echo "ibase=16; $c" | bc)
	
	printf '<dict>\\n\\t\\t<key>Blue Component</key>\\n\\t\\t<real>%s</real>\\n\\t\\t<key>Green Component</key>\\n\\t\\t<real>%s</real>\\n\\t\\t<key>Red Component</key>\\n\\t\\t<real>%s</real>\\n\\t</dict>\\n' "$(conv $b)" "$(conv $g)" "$(conv $r)" 
}
export INTARGET="template.itermcolors"
export EXTENSION="itermcolors"
export TEMPLATEXFRM="exec_func"
