param($old,$new)

Get-ChildItem -recurse | Where-Object{$_.PSIsContainer -eq $false} | %{ $f=$_; (gc $f.PSPath) | %{ $_ -replace $old, $new } | sc $f.PSPath }	

$items = gci -recurse -filter *$old*

$items | Where-Object{$_.PSIsContainer -eq $false} | rename-item -newname {  $_.name  -replace $old,$new  }
$items | Where-Object{$_.PSIsContainer} | rename-item -newname {  $_.name  -replace $old,$new  }
