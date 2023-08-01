mkdir ORIGISO
mkdir NEWISO
sudo mount -o loop debian-12.0.0-amd64-netinst.iso ./ORIGISO
cp -rT ./ORIGISO/ ./NEWISO/
sudo umount ./ORIGISO 
chmod +w -R ./NEWISO/install.amd/
gunzip ./NEWISO/install.amd/gtk/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F ./NEWISO/install.amd/gtk/initrd
gzip ./NEWISO/install.amd/gtk/initrd
chmod -w -R ./NEWISO/install.amd
chmod +w ./NEWISO/md5sum.txt
cd NEWISO
find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > ./md5sum.txt
chmod -w ./md5sum.txt
cd ..
genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -o debian.iso ./NEWISO
isohybrid --uefi debian.iso
sudo rm -rf ./ORIGISO ./NEWISO

