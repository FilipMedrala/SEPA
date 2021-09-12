#!/bin/bash

echo "SEPA P23 Auto-install Script"

install2104() {
	echo "Detected Ubuntu 21.04!"
	echo "Updating current packages..."
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

	echo "Installing prerequitsites for AFL/AFL++..."
	sudo apt-get install -y build-essential python3-dev automake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools
	sudo apt-get install -y lld-12 llvm-12 llvm-12-dev clang-12
	sudo apt-get install -y gcc-10-plugin-dev libstdc++-10-dev

	# Run the AFL++ install function
	afl_install()
}

install2004() {
	echo "Detected Ubuntu 20.04 LTS!"
	echo "Updating current packages..."
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

	echo "Installing prerequitsites for AFL/AFL++..."
	sudo apt-get install -y build-essential python3-dev automake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools
	sudo apt-get install -y lld-10 llvm-10 llvm-10-dev clang-10
	sudo apt-get install -y gcc-9-plugin-dev libstdc++-9-dev
	
	# Run the AFL++ install function
	afl_install()
}

afl_install() {
	echo "Cloning AFL++ git repo..."
	git clone https://github.com/AFLplusplus/AFLplusplus && cd AFLplusplus

	echo "Compiling AFL++ with default settings..."
	make distrib

	echo "Installing AFL++"
	sudo make install
	cd ../

	echo "Cloning AFL Fuzzing test program fuzzgoat..."
	cd $HOME/Documents
	git clone https://github.com/fuzzstati0n/fuzzgoat && cd fuzzgoat
	echo "Changing fuzzgoat compiler to LTO"
	export CC=afl-clang-lto++

	echo "Compiling fuzzgoat"
	sudo make
	cd ../

	echo "Installing web environment..."
	sudo apt-get install apache2 php libapache2-mod-php libapache2-mod-security2

	# Installing the security mod package
	sudo a2enmod security2
	sudo /etc/init.d/apache2 force-reload
	# Create temporary directories for the project logs
	sudo mkdir /var/www/html/SEPP23.com
	sudo mkdir /var/log/apache2/SEPP23.com
	echo "Done!"
}

if [[ $(lsb_release -rs) == "21.04" ]]
then
	install2104()
elif [[ $(lsb_release -rs) == "20.04" ]]
then
	install2004()
else
	echo "Script is only compatibile with Ubuntu 20.04 LTS or 21.04"
fi
