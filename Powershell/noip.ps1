$hostname = "****"
$pass = "****"
$username = "****"


$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)

$ip = (Invoke-WebRequest -Uri "http://icanhazip.com").Content
$noipUri = "http://dynupdate.no-ip.com/nic/update?hostname=" + $hostname + "&myip=" + $ip

Invoke-WebRequest -Uri $noipUri -Credential $creds