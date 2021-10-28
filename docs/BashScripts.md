# AFL++ Operation Scripts

These scripts co-ordinate the operation of the backend that processes AFL jobs.
They were developed with the intention of being executed from www-data however can be called independently.


# Prerequisites

We offer a pre-built Docker image that contains all needed scripts and tools pre-installed for zero-effort setup.
If you would like to build your own image or deploy on bare-metal/virtualised hardware and use these scripts then you'll need the packages below.

## Manual Installation

 1. Execute ./installAflPrereqs.sh This script will install most of the
    needed packages in preparation for the fuzzing web service. It is
    currently compatible with Ubuntu 20.04 LTS, 21.04 & 21.10 x64
    releases.
 2. Execute ./installDocker.sh which will install the Docker Container
    engine which is needed for the containerized version of AFL. This is release agnostic however we recommend sticking to LTS versions.
 3. Create the afl directory under the current users Documents folder.
 4. Create the docker-afl directory under the current users Documents folder.
 5. Copy the scripts from the "Backend/Bash Scripts" folder to another folder named scripts under the afl directory. Make those files executable
 6. Copy the docker files from the "Backend/AFL_Backend" folder to the docker-afl folder. Make those files executable.
 7. Copy the files from the "Frontend" folder to the directory where
    your web server is configured to operate from, usually this is
    /var/www/html
 8. Next, run the setAflPermission.sh script which will set the
    permissions of the web server directory to ones suitable for
    authenticated uploads which is needed for our product.
    Replace the sudoers file with the one located in the "backend/Bash
 9. Files" folder. This includes command aliases that are executed under
    the www-data user which is the web server user account. If you don't
    wish to copy directly, you can open up the file and review diff line
    by line to copy accordingly.
