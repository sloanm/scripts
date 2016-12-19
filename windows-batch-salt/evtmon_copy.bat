#This is the first of two scripts to install and start evtmon
echo "Copy files from Github repot to local server"
mkdir c:\evtmon
cd c:\evtmon
c:\salt\salt-call.bat cp.get_file salt://intu/pi-enttools/lvdca_evtmon_All.zip c:\evtmon\lvdca_evtmon_All.zip
call evtmon.bat
