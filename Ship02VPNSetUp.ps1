Write-Host "Welcome! This simple script will set up a split-tunnel VPN connection to PSO2's Ship 02 servers." -BackgroundColor White -ForegroundColor Black
Write-Host "(Only PSO2 traffic will flow through the VPN!)" -BackgroundColor White -ForegroundColor Black
Write-Host "Press enter to start." -BackgroundColor White -ForegroundColor Black
Read-Host
$InstallLocation = Read-Host -Prompt 'Please indicate the install path of the pso2_bin folder. e.g. "C:\PHANTASYSTARONLINE2\pso2_bin" (without the "")'
$VPNName = Read-Host -Prompt 'Please indicate the name you would like Windows to identify the VPN as. e.g. "VPN Connection"'
Write-Host "Install folder has been set as ""$InstallLocation\"" and the VPN name has been set as $VPNName. Press enter to begin the VPN set up." -ForegroundColor Red -BackgroundColor Yellow
Read-Host
Add-VpnConnection -name "$VPNName" -ServerAddress opengw.opengw.net:444 -RememberCredential -SplitTunneling -PassThru
cmd.exe /c rasdial "$VPNName" vpn vpn
netsh interface ipv4 add route 202.234.0.0/16 "$VPNName"
Add-VpnConnectionTriggerApplication -ConnectionName "$VPNName" -ApplicationID "$InstallLocation\pso2.exe"
Add-VpnConnectionTriggerApplication -ConnectionName "$VPNName" -ApplicationID "$InstallLocation\pso2launcher.exe"
Set-VpnConnection -Name "$VPNName" -IdleDisconnectSeconds 60
Write-Host "Done! You can verify the connection works as intended by reading the logs above or by pinging the Ship 02 servers with:" -ForegroundColor Black -BackgroundColor Green
Write-Host "cmd /c "ping gs016.pso2gs.net"." -ForegroundColor Black -BackgroundColor Green
Write-Host "Press enter to exit." -ForegroundColor Black -BackgroundColor Green
Read-Host
exit