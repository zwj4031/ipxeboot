@echo off
set root=X:\windows\system32
if exist %root%\modex64.exe start /w "" modex64.exe
MODE CON COLS=56 LINES=10
:::创建符号链接，避免32位程序运行不正常
mklink %temp%\cmd.exe  C:\windows\system32\cmd.exe


%root%\pecmd.exe LINK %Desktop%\ghostx64,%root%\ghostx64.exe
%root%\pecmd.exe LINK %Desktop%\netcopyx64,%root%\netcopyx64.exe
cls
@echo 检测系统目录下是否存在ip.txt
if exist X:\windows\system32\ip.txt @echo 文件存在.准备提取...&&goto txtip
if not exist X:\windows\system32\ip.txt @echo 文件不存在.dhcp作为服务器地址...&&goto dhcpip


:::检测服务器文件并退出
:runtask
cd /d "%ProgramFiles(x86)%"
echo 取得ip地址为%ip%
goto autoghost
exit


::::从txt中提取服务器地址
:txtip
cd /d X:\windows\system32
for /f %%a in (ip.txt) do set ip=%%a
echo %ip%
echo 即将开始克隆或释放其它软件……
ping 127.0 -n 5 >nul
goto runtask

:::从dhcp中提取服务器地址
:dhcpip
for /f "tokens=1,2 delims=:" %%a in ('Ipconfig /all^|find /i "DHCP 服务器 . . . . . . . . . . . :"') do (
for /f "tokens=1,2 delims= " %%i in ('echo %%b')  do set ip=%%i
)
goto runtask


:autoghost
ping 127.0 -n 5 >nul
X:\windows\system32\pecmd.exe kill ghostx64.exe >nul
cd /d "X:\windows\system32" >nul
ghostx64.exe -ja=mousedos -batch >nul
if errorlevel 1 goto autoghost
exit

