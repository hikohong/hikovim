#!/bin/bash
# This is the installation file which can be using easily
# author: hikohong@gmail.com

function print_usage()
{
	echo "==================================================================================="
	echo " hikovim install process"
	echo " Author Hiko Hong"
	echo "   ./setup.sh [option]"
	echo "   Example:"
	echo "   ./setup.sh"
	echo "   ./setup.sh --backup"
	echo "-----------------------------------------------------------------------------------"
	echo "[option] --install -i --install_without_backup --help -h"
	echo "  option default is -help page"
	echo "  -i --install has backup process"
	echo "==================================================================================="
}

function insall_to_home_system()
{
	if [ -d ~/.vim ];
	then
		rm -rf ~/.vim
	fi

	mkdir ~/.vim
	cp -r ./colors ~/.vim/
	cp -r ./doc ~/.vim/
	cp -r ./plugin ~/.vim/

	if [ -f ~/.vimrc ];
	then
		rm -f ~/.vimrc
	fi

	cp _vimrc ~/.vimrc
	if [ -f ~/.gvimrc ];
	then
		rm -f ~/.gvimrc
	fi

	cp _gvimrc ~/.gvimrc
}


function backup_exist_files()
{
	T=$(date +%Y%m%d%H%M%S)
	if [ -d ~/.vim ];
	then
		echo "~/.vim backup as ~/.vim_$T"
		mv ~/.vim ~/.vim_$T
	fi

	if [ -f ~/.vimrc ];
	then
		echo "~/.vimrc backups as ~/.vimrc_$T"
		mv ~/.vimrc ~/.vimrc_$T
	fi

	if [ -f ~/.gvimrc ];
	then
		echo "~/.gvimrc backups as ~/.gvimrc_$T"
		mv ~/.gvimrc ~/.gvimrc_$T
	fi
}

# main procedure
case $1 in
--install_without_backup)
	insall_to_home_system
	;;
--install)
	backup_exist_files
	insall_to_home_system
	;;
-i)
	backup_exist_files
	insall_to_home_system
	;;
-h)
	print_usage
	;;
-help)
	print_usage
	;;
*)
	print_usage
	;;
esac





