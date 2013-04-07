param($installPath, $toolsPath, $package, $project)

$project.Properties.Item("SignAssembly").Value = "false"
$project.Properties.Item("AssemblyOriginatorKeyFile").Value = ""