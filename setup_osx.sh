#!/bin/bash

#// smithsf0x

start(){
	echo "       ______________________"
	echo "      /                     /"
	echo "     /     smithsf0x       /"
	echo "    / automated installer /"
	echo "   /   for PSP2SDK       /"
	echo "  /      MacOS X        /"
	echo " /_____________________/"
	echo "|"
}

check_command_line_tools(){
	xcode-select -p >& /dev/null
	current_exit_status=$?

	if [ $current_exit_status == 0 ]
		then 
			echo "|CommandLineTools Installed:        YES"
			command_line_tools_installed=$TRUE
		else
			echo "|CommandLineTools Installed:   	NO"
			command_line_tools_installed=$FALSE
	fi
	current_exit_status=null
}

check_autoconf(){
	autoconf --version >& /dev/null
	current_exit_status=$?

	if [ $current_exit_status == 0 ]
		then 
			echo "|autoconf Installed:	             YES"
			autoconf_installed=$TRUE
		else
			echo "|autoconf Installed:	             NO"
			autoconf_installed=$FALSE
	fi
	current_exit_status=null
}

check_devkit_arm(){
	echo -ne "|DevKitARM Installed:                "
	if [ -z "$DEVKITARM" ]
		then
			echo "NO"
			devkit_arm_installed=$FALSE
		else 
			echo "YES"
			devkit_arm_installed=$TRUE
	fi
}

set_env_vars(){
	echo "" >> ~/.bash_profile
	echo "#PSP2SDK" >> ~/.bash_profile
	echo "export PSP2SDK=\$DEVKITPRO/psp2" >> ~/.bash_profile
	echo "export PATH=\$PATH:\$PSP2SDK/bin" >> ~/.bash_profile
}

create_psp2_folder(){
	if [ ! -d "$PSP2SDK" ]
		then 
			mkdir $PSP2SDK
			echo "DONE"
		else 
			echo "ALREADY CREATED"
	fi
}

setup(){
	echo -ne "|Exporting and Writing:              "
	set_env_vars
	export PSP2SDK=$DEVKITPRO/psp2
	export PATH=$PATH:$PSP2SDK/bin
	echo "DONE"
	echo -ne "|Creating PSP2SDK folder:            "
	create_psp2_folder
	echo "|------------------------------|"
	echo "|       Setup FINISHED         |"
	echo "| Run 'source ~/.bash_profile' |" 
	echo "|    Now run install_osx.sh    |"
	echo "|------------------------------|"
	echo ""
}

start


check_command_line_tools

if [ ! command_line_tools_installed ]
	then
		echo -ne "|Installing command line tools:      "
		xcode-select --install >& /dev/null
		echo "DONE"
fi

check_devkit_arm

if [ ! devkit_arm_installed ]
	then
		echo -ne "|Running devKitARM installer:        "
		perl ./devkitARMupdate.pl >& /dev/null
		echo "DONE"
fi

check_autoconf

if [ ! autoconf_installed ]
	then
		echo -ne "|Downloading autoconf:               "
		mkdir ./temp
		cd ./temp
		curl -O http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.xz >& /dev/null
		tar xf autoconf-latest.tar.xz
		rm ./autoconf-latest.tar.xz
		echo "DONE"
		echo -ne "|Making and Installing autoconf:     "
		cd autoconf*
		./conifgure
		./make
		./make install
		cd ../..
		rm -Rf ./temp
		echo "DONE"	
fi

setup


