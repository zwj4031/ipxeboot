@echo off
set root=X:\windows\system32
if exist %root%\modex64.exe start /w "" modex64.exe
MODE CON COLS=56 LINES=10
:::�����������ӣ�����32λ�������в�����
mklink %temp%\cmd.exe  C:\windows\system32\cmd.exe


%root%\pecmd.exe LINK %Desktop%\ghostx64,%root%\ghostx64.exe
%root%\pecmd.exe LINK %Desktop%\netcopyx64,%root%\netcopyx64.exe
cls
@echo ���ϵͳĿ¼���Ƿ����ip.txt
if exist X:\windows\system32\ip.txt @echo �ļ�����.׼����ȡ...&&goto txtip
if not exist X:\windows\system32\ip.txt @echo �ļ�������.dhcp��Ϊ��������ַ...&&goto dhcpip


:::���������ļ����˳�
:runtask
cd /d "%ProgramFiles(x86)%"
echo ȡ��ip��ַΪ%ip%
goto autoghost
exit


::::��txt����ȡ��������ַ
:txtip
cd /d X:\windows\system32
for /f %%a in (ip.txt) do set ip=%%a
echo %ip%
echo ������ʼ��¡���ͷ������������
ping 127.0 -n 5 >nul
goto runtask

:::��dhcp����ȡ��������ַ
:dhcpip
for /f "tokens=1,2 delims=:" %%a in ('Ipconfig /all^|find /i "DHCP ������ . . . . . . . . . . . :"') do (
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

