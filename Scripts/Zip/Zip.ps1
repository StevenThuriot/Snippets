gci -recurse -Directory -include bin,obj | Remove-Item -Force -Recurse
gci -recurse -File -include *.suo,*.user,*.tmp,*.vssscc | Remove-Item -Force -Recurse
gci -filter packages\* -Directory | Remove-Item -Force -Recurse

$current = (Get-Location).Path

$file = [System.IO.Path]::GetFileName($current)
$path = join-path -path $current -childpath /../$file.zip

[Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" )

If (Test-Path $path) { Remove-Item $path }
$optimal = [System.IO.Compression.CompressionLevel]::Optimal
[System.IO.Compression.ZipFile]::CreateFromDirectory($current, $path, $optimal, $FALSE)
