@echo off
:::�����������ӣ�����32λ�������в�����
mklink %temp%\cmd.exe  C:\windows\system32\cmd.exe
set root=X:\windows\system32
::������������
#color b0 
set a=50
set b=34
:re
set /a a-=1
set /a b-=1
mode con: cols=%a% lines=%b% 
if %a% geq 16 if %b% geq 1 goto re
if "%1" == "netghost" goto netghost
cd /d "%ProgramFiles(x86)%"
if exist "%ProgramFiles(x86)%\ghost\houx64.exe start "" "%ProgramFiles(x86)%\ghost\houx64.exe"
if exist "%ProgramFiles(x86)%\student\student.exe" start "" /min "%ProgramFiles(x86)%\student\student.exe"

%root%\pecmd.exe TEAM TEXT ���ڳ�ʼ������.......L204 T207 R1000 B768 $30^|wait 5000 
ipconfig /renew >nul
@echo ��ʼ���������.
::���ִ�е���������%job%
for /f "tokens=1-2 delims=@ " %%a in ('dir /b %root%\*@*') do (
set %%a
set %%b
)
%root%\pecmd.exe TEAM TEXT �õ�������IPΪ%ip% L204 T207 R1000 B768 $30^|wait 2000 
%root%\pecmd.exe TEAM TEXT ����ִ�е�����%job% L204 T207 R1000 B568 $30^|wait 2000 
%root%\pecmd.exe TEAM TEXT �رշ���ǽ.......L204 T207 R1000 B768 $30^|wait 5000 
wpeutil disablefirewall
::����ȱ�ٵ�ϵͳ���

:::���������ļ����˳�
:runtask
cd /d "%ProgramFiles(x86)%"

::�����������
::for %%d in (ghostx64.exe netcopyx64.exe cgix64.exe) do (
::%root%\pecmd.exe TEAM TEXT ��������%%d L204 T207 R1000 B768 $30^|wait 5000 
::if not exist %root%\%%d tftp -i %ip% get /app/inject/default/%%d %root%\%%d 
::)

%root%\pecmd.exe LINK %Desktop%\ghostx64,%root%\ghostx64.exe
%root%\pecmd.exe LINK %Desktop%\netcopy����ͬ��,%root%\netcopyx64.exe
%root%\pecmd.exe LINK %Desktop%\CGIһ����ԭ,%root%\cgix64.exe
%root%\pecmd.exe LINK %Desktop%\ʷ����ΰ���Զ���¡,%root%\startup.bat,netghost
%root%\pecmd.exe LINK %Desktop%\�ļ�������,explorer.exe,B:\
%root%\pecmd.exe LINK %Desktop%\�ļ�������,WinXshell.exe,B:\
%root%\pecmd.exe LINK %Desktop%\���ӹ���,cmd.exe,"/c net use B: \\%ip%\pxe "" /user:guest&explorer.exe B:\"
start "" "X:\windows\syswow64\client\DbntCli.exe" %ip% 21984
goto %job%


::::::ִ������
:netghost
%root%\pecmd.exe TEAM TEXT �������ӻỰ����Ϊmousedos��ghostsrv���� L204 T207 R1000 B768 $30^|wait 2000 
X:\windows\system32\pecmd.exe kill ghostx64.exe >nul
cd /d "X:\windows\system32" >nul
ghostx64.exe -ja=mousedos -batch >nul
if errorlevel 1 goto netghost
exit

:smbcli
net use * /delete /y >nul
%root%\pecmd.exe TEAM TEXT �������ӹ���\\%ip%\pxeΪB��....L204 T207 R1000 B768 $30^|wait 8000
::echo �������ӹ���\\%ip%\pxeΪB�� 
::echo ����ܾ������ϣ���ȷ������%ip%��������Ϊpxe�Ĺ���!���ɹرձ�����!
net use B: \\%ip%\pxe "" /user:guest
if "%errorlevel%"=="0" ( 
 %root%\pecmd.exe TEAM TEXT ���ӷ������ɹ���׼���������棡 L204 T207 R1000 B568 $30^|wait 2000
 exit
) else (
 %root%\pecmd.exe TEAM TEXT ���ӷ�������ʱ����������ϣ���ȷ��������������Ϊpxe�Ĺ���! �� L204 T207 R1000 B768 $30^|wait 5000
goto runtask
)
exit
:netcopy
%root%\pecmd.exe TEAM TEXT ������������ͬ��netcopy���� L204 T207 R1000 B768 $30^|wait 2000 
start "" "%ProgramFiles(x86)%\ghost\netcopyx86.exe"

