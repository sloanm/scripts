#Powershell installation of evtmon

c:\salt\salt-call.bat cp.get_dir salt://intu/pi-enttools/Evtmon c:\\ makedirs=True

c:\evtmon\evtmon-service-install.vbs

start-sleep 3

start-service evtmon

