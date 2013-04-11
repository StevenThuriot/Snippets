[Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression" )
[Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" )

$destfile = "%DropLocation%/%system.teamcity.projectName%.Zip"
$dropLength = "%DropLocation%".TrimEnd('\', '/').Length + 1

Write-Host Creating ZIP Archive for version %AssemblyFileVersion%...
$mode = [System.IO.Compression.ZipArchiveMode]::Create
$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal

Write-Host Creating Archive.
$archive  = [System.IO.Compression.ZipFile]::Open( $destfile, $mode )

Write-Host Getting Items.
$files = Get-ChildItem -Path * -include %FilesToZip% -recurse

Write-Host Starting file enumeration of $files.Count items...

foreach($file in $files)
{
$fileName = $file.FullName.SubString($dropLength)
$entry = [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile( $archive, $file.FullName, $fileName, $compressionLevel )
Write-Host Added $entry.Name to ZIP Archive.
}

Write-Host Disposing archive.
$archive.Dispose();