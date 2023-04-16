@echo off
color 0c
echo -
echo Cfx Waze.
echo -
timeout 5
test&cls
color 0a
echo -
echo Ligando servidor...
echo -
timeout 5
start artifacts\FXServer.exe +exec server.cfg +set onesync_enableInfinity 1 +set sv_enforceGameBuild 2545
exit