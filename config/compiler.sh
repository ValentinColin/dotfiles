##############
### CONFIG ###
##############

# gcc/g++
if [ $OS = "Darwin" ]; then
	alias gcc="/usr/local/Cellar/gcc/11.2.0/bin/gcc-11"
	alias g++="/usr/local/Cellar/gcc/11.2.0/bin/g++-11"
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
