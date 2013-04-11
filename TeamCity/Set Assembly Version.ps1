$FileExists = Test-Path "%GlobalAssemblyInfo%"

If ($FileExists -ne $True) { 
   Write-Host "%GlobalAssemblyInfo%" was not found.
   exit 1
}

$content = Get-Content "%GlobalAssemblyInfo%"

$hasAssemblyVersion = "'"+$content+"'" -match 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)'
$assemblyVersionFormattedCorrectly = $matches[0] -match "(?<major>[0-9]+)\.(?<minor>[0-9])+(\.(?<build>([0-9])))?(\.(?<revision>([0-9])))?"

$major=$matches['major'] -as [int]
$minor=$matches['minor'] -as [int]
$build=$matches['build'] -as [int]
$revision=$matches['revision'] -as [int]

$AssemblyVersion = "$major.$minor.$build.$revision"

Write-Host Assembly Version: $AssemblyVersion

$build=%build.number%

$AssemblyFileVersion = "$major.$minor.$build.$revision"
Write-Host Setting File Version to: $AssemblyFileVersion

$fileVersion = 'AssemblyFileVersion("' + $AssemblyFileVersion + '")';
$content -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $fileVersion | Set-Content "%GlobalAssemblyInfo%"

echo "##teamcity[setParameter name='AssemblyVersion' value='$AssemblyVersion']"
echo "##teamcity[buildNumber '$AssemblyFileVersion']"
echo "##teamcity[setParameter name='AssemblyFileVersion' value='$AssemblyFileVersion']"
echo "##teamcity[setParameter name='NuGetVersion' value='$major.$minor.$build']"