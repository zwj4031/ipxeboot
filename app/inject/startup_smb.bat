@echo off
set root=X:\windows\system32
if exist %root%\sysx64.exe start /w "" sysx64.exe
#color b0 
set a=50
set b=34
:re
set /a a-=1
set /a b-=1
mode con: cols=%a% lines=%b% 
if %a% geq 16 if %b% geq 1 goto re
#MODE CON COLS=15 LINES=5
:::�����������ӣ�����32λ�������в�����
mklink %temp%\cmd.exe  C:\windows\system32\cmd.exe
%root%\pecmd.exe LINK %Desktop%\ghostx64,%root%\ghostx64.exe
%root%\pecmd.exe LINK %Desktop%\netcopy����ͬ��,%root%\netcopyx64.exe
%root%\pecmd.exe LINK %Desktop%\CGIһ����ԭ,%root%\cgix64.exe
%root%\pecmd.exe LINK %Desktop%\�ļ�������,explorer.exe,B:\
%root%\pecmd.exe LINK %Desktop%\���ӹ���,cmd.exe,"/c net use B: \\%ip%\pxe "" /user:guest&explorer.exe B:\"
cls
for /f "tokens=2 delims==" %%a in ('dir /b %root%\serverip*') do set ip=%%a
:�ж�ipֵ
if defined ip (
    goto runtask
) else (
%root%\pecmd.exe TEAM TEXT ��ȡ������IP�У����ϵͳĿ¼������ip.txt L204 T207 R1000 B768 $30^|wait 5000 
if exist X:\windows\system32\ip.txt @echo �ļ�����.׼����ȡ...&&goto txtip
if not exist X:\windows\system32\ip.txt @echo �ļ�������.dhcp��Ϊ��������ַ...&&goto dhcpip
)


:::���������ļ����˳�
:runtask
cd /d "%ProgramFiles(x86)%"
%root%\pecmd.exe TEAM TEXT �õ�������IPΪ%ip% L204 T207 R1000 B768 $30^|wait 2000 
echo 
cls
%root%\pecmd.exe TEAM TEXT ���ڳ�ʼ������.......L204 T207 R1000 B768 $30^|wait 5000 
ipconfig /renew>nul
goto autoexec
exit


::::��txt����ȡ��������ַ
:txtip
cd /d X:\windows\system32
for /f %%a in (ip.txt) do set ip=%%a
echo %ip%
%root%\pecmd.exe TEAM TEXT ��ʼ����ɣ�׼��ִ��������񡭡� L204 T207 R1000 B768 $30^|wait 3000 
goto runtask

:::��dhcp����ȡ��������ַ
:dhcpip
for /f "tokens=1,2 delims=:" %%a in ('Ipconfig /all^|find /i "DHCP ������ . . . . . . . . . . . :"') do (
for /f "tokens=1,2 delims= " %%i in ('echo %%b')  do set ip=%%i
)
goto runtask
exit
:autoexec
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

