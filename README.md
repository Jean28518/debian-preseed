# debian-preseed

Script and config to create debian preseed .iso for full automatic installation in the graphical installer.

## Instructions

- Download the debian netinstaller from the offical site: <https://www.debian.org/download>
- move the .iso file next to the build.sh
- Change the path to the debian.iso in the build.sh in line 3
- Configure the preseed.cfg to your needs
- Run the script with root rights: `sudo bash ./build.sh`
- Your new iso is called debian.iso
