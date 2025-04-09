
sleep 2

mv -f ./update/Cubiix_Project.pck ./Cubiix_Project.pck
mv -f ./update/Cubiix_Project.x86_64 ./Cubiix_Project.x86_64
mv -f ./update/libgdsqlite.linux.template_release.x86_64.so ./libgdsqlite.linux.template_release.x86_64.so

nohup ./Cubiix_Project.x86_64 &

rm -R ./update

exit