#!/bin/bash



### Functions Block
setWebDirPerm() {
	sudo chown -R sepadmin /var/www/html/
	sudo chgrp -R www-data /var/www/html/
	sudo chmod -R 750 /var/www/html/
	sudo chmod g+s /var/www/html/
	sudo chmod g+w /var/www/html/aflfuzzerweb/uploadtmp
}

## Display warning message
read -p $'Have you copied the web files to the server directory yet? If not, please do so. \nOtherwise, press enter to continue!'

### Execution Block
## Create upload directory for temporary storage
echo "Creating temporary upload directory..."
mkdir -p /var/www/html/aflfuzzerweb/uploadtmp
## Set permissions of the web server directory to allow authenticated upload
echo "Setting permissions on web directories..."
setWebPermDir

exit 0
