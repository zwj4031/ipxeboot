@echo off
:::�����������ӣ�����32λ�������в�����
mklink %temp%\cmd.exe  C:\windows\system32\cmd.exe
mode con cols=45 lines=8

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

goto runtask

:::��dhcp����ȡ��������ַ
:dhcpip
for /f "tokens=1,2 delims=:" %%a in ('Ipconfig /all^|find /i "DHCP ������ . . . . . . . . . . . :"') do (
for /f "tokens=1,2 delims= " %%i in ('echo %%b')  do set ip=%%i
)
goto runtask


:autoghost
timeout 5 /nobreak
X:\windows\system32\pecmd.exe kill ghost64.exe >nul
cd /d "X:\windows\system32" >nul
ghost64.exe -ja=mousedos -batch >nul
if errorlevel 1 goto autoghost
exit

