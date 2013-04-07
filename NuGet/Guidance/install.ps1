param($installPath, $toolsPath, $package, $project)

$guidance = join-path $toolsPath OdeionPlatform.NuGet.exe

#First param == Selected project file
#Second param == Solution File

& $guidance  $([Char]34) $project.FullName $([Char]34)  $([Char]34) $project.Object.DTE.Solution.FullName $([Char]34) | Out-Null