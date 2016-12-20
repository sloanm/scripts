systeminfo | find /I "OS Name" > file

REM  This line is a comment
REM This command is like awk and will print the 6th field
REM to read and write a file
REM http://stackoverflow.com/questions/6359820/how-to-set-commands-output-as-a-variable-in-a-batch-file
REM Variables in
REM  http://steve-jansen.github.io/guides/windows-batch-scripting/part-2-variables.html


FOR /F "tokens=6" %%a IN (file) DO ECHO %%a > file1

REM reads contents of file1 into the variable Var
SET /P Var=<File1

echo %Var%

REM This next block must have IF and ECHO in caps and the parens to run correctly
REM START executes a command on the terminal from within a shell scriptf

IF "%Var%"=="2008 " (
ECHO Match
START salt-call cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini'
)

REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  if the os is windows 2008 run the salt-call command -=-=

systeminfo | find /I "OS Name" > file

FOR /F "tokens=6" %%a IN (file) DO ECHO %%a > file1

SET /P Var=<File1

echo %Var%

IF "%Var%"=="2008 " (
ECHO Match
START salt-call cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini'
)
