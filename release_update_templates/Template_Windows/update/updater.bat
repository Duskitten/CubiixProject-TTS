timeout /t 2 /nobreak

move ./Cubiix_Project.pck ../
move ./Cubiix_Project.exe ../
move ./libgdsqlite.windows.template_release.x86_64.dll ../

start ../Cubiix_Project.exe

del /f /q ../update

timeout /t 2 /nobreak