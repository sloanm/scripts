cd c:\evtmon
echo "unzip the file"
unzip c:\evtmon\lvdca_evtmon_All.zip -d c:\evtmon\
timeout /t 7 /nobreak

timeout /t 10 /nobreak

echo "Install the script"
c:\evtmon\evtmon-service-install.vbs
sc start evtmon

timeout /t 7 /nobreak

GOTO:EOF
