timeout /t 2 /nobreak

move ./update/Cubiix_Project.pck ./
move ./update/Cubiix_Project.exe ./
move ./update/libgdsqlite.windows.template_release.x86_64.dll ./

start ./Cubiix_Project.exe

del /f /q ./update

timeout /t 2 /nobreak