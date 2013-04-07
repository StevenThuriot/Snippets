param($installPath, $toolsPath, $package, $project)

$project.Properties.Item("SignAssembly").Value = "true"

$projectUri = new-object system.uri($project.FullName)
$nugetUri = new-object system.uri($installPath)
$relativePath = $projectUri.MakeRelativeUri($nugetUri).OriginalString
$key = $relativePath + "/lib/Thuriot.pfx"
$key = $key -replace '/', [system.io.Path]::DirectorySeparatorChar

$project.Properties.Item("AssemblyOriginatorKeyFile").Value = $key