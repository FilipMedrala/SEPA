#!/bin/bash

echo "SEPA P23 Auto-install Script"

if [[ $(lsb_release -rs) == "21.04" ]];
	
	echo "Detected Ubuntu 21.04!"
	echo "Updating current packages..."
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
	
	echo "Installing prerequitsites for AFL/AFL++..."
	sudo apt-get install -y build-essential python3-dev automake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools
	sudo apt-get install -y lld-12 llvm-12 llvm-12-dev clang-12
	sudo apt-get install -y gcc-10-plugin-dev libstdc++-10-dev
	
	echo "Cloning AFL++ git repo..."
	git clone https://github.com/AFLplusplus/AFLplusplus && cd AFLplusplus
	
	echo "Compiling AFL++ with default settings..."
	make distrib
	
	echo "Installing AFL++"
	sudo make install
	cd ../
	
	echo "Cloning AFL Fuzzing test program fuzzgoat..."
	git clone https://github.com/fuzzstati0n/fuzzgoat && cd fuzzgoat
	echo "Changing fuzzgoat compiler to more compatible llvm one..."
	export CC=afl-clang-fast
	
	echo "Compiling fuzzgoat"
	sudo make
	cd ../
	
	echo "Installing web environment..."
	sudo apt-get install apache2 php libapache2-mod-php
	
	echo "Done!"
else
	echo "Script is only compatibile with Ubuntu 21.04"
fi