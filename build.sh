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
sudo genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o debian.iso ./NEWISO
sudo rm -rf ./ORIGISO ./NEWISO

