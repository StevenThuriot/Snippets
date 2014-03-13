$globalAssemblyFile = "GlobalAssemblyInfo.cs"
$globalAssemblyVersion = Get-Content .\$globalAssemblyFile

$hasAssemblyVersion = "'"+$globalAssemblyVersion+"'" -match 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)'

if (!$hasAssemblyVersion)
{
	Add-AppveyorMessage -Message "No AssemblyVersion found."
	return;
}

$assemblyVersionFormattedCorrectly = $matches[0] -match "(?<major>[0-9]+)\.(?<minor>[0-9])+(\.(?<build>([0-9])))?(\.(?<revision>([0-9])))?"

$major=$matches['major'] -as [int]
$minor=$matches['minor'] -as [int]
$build=$matches['build'] -as [int]
$revision=$matches['revision'] -as [int]

$AssemblyVersion = "$major.$minor.$build.$revision"

Add-AppveyorMessage -Message "Assembly Version: $AssemblyVersion"

$AssemblyFileVersion = "$major.$minor.$env:APPVEYOR_BUILD_NUMBER"
$AssemblyInformationalVersion = "$AssemblyFileVersion-$env:APPVEYOR_REPO_SCM" + ($env:APPVEYOR_REPO_COMMIT).Substring(0, 8)

Add-AppveyorMessage -Message "Patched File Version: $AssemblyFileVersion"
Add-AppveyorMessage -Message "Patched Informational Version: $AssemblyInformationalVersion"

$fileVersion = 'AssemblyFileVersion("' + $AssemblyFileVersion + '")';
$informationalVersion = 'AssemblyInformationalVersion("' + $AssemblyInformationalVersion + '")';

$foundFiles = get-childitem .\*AssemblyInfo.cs -recurse  
foreach( $file in $foundFiles )  
{
	if ($file.Name -eq $globalAssemblyFile)
	{
		#Don't patch the global info.
		continue;
	}

	$content = Get-Content "$file"
		
	Add-AppveyorMessage -Message "Patching $file"
	
	$content -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $fileVersion `
			 -replace 'AssemblyInformationalVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $informationalVersion | Set-Content "$file"
}
