Write-Host "Welcome! This simple script will set up a split-tunnel VPN connection to PSO2's Ship 02 servers." -BackgroundColor White -ForegroundColor Black
Write-Host "(Only PSO2 traffic will flow through the VPN!)" -BackgroundColor White -ForegroundColor Black
Write-Host "PSO2's install path should be C:\PHANTASYSTARONLINE2\pso2_bin" -BackgroundColor White -ForegroundColor Black
Write-Host "If so, press enter to start or close this terminal to quit."
Read-Host
Add-VpnConnection -name "VPN" -ServerAddress vpn842381100.opengw.net:1971 -RememberCredential -SplitTunneling -PassThru
cmd.exe /c rasdial "VPN" vpn vpn
netsh interface ipv4 add route 202.234.0.0/16 "VPN"
Add-VpnConnectionTriggerApplication -ConnectionName "VPN" -ApplicationID "C:\PHANTASYSTARONLINE2\pso2_bin\pso2.exe"
Add-VpnConnectionTriggerApplication -ConnectionName "VPN" -ApplicationID "C:\PHANTASYSTARONLINE2\pso2_bin\pso2launcher.exe"
Set-VpnConnection -Name "$VPNName" -IdleDisconnectSeconds 60
Write-Host "Done! You can verify the connection works as intended by reading the logs above or by pinging the Ship 02 servers with:" -ForegroundColor Black -BackgroundColor Green
Write-Host "cmd /c "ping gs016.pso2gs.net"." -ForegroundColor Black -BackgroundColor Green
Write-Host "Press enter to exit." -ForegroundColor Black -BackgroundColor Green
Read-Host
exit