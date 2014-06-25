param($old,$new)

Get-ChildItem -recurse -file -exclude *.pdb,*.dll,*.exe | %{ $f=$_; (Get-Content $f.PSPath) | %{ $_ -replace $old, $new } | Set-Content $f.PSPath }	
Get-ChildItem -recurse -filter *$old* | Sort-Object -Property PSIsContainer | Rename-Item -NewName {  $_.Name  -replace $old, $new }
