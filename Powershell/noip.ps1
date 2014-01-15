$hostname = "***.no-ip.org"
$username = "***"
$pass = "***"

$ip = (Invoke-WebRequest -Uri "http://icanhazip.com").Content

$dummyUri = "http://dynupdate.no-ip.com/nic/update?hostname=" + $hostname + "&myip=1.2.3.4"
$noipUri = "http://dynupdate.no-ip.com/nic/update?hostname=" + $hostname + "&myip=" + $ip

$webclient = new-object System.Net.WebClient
$webclient.Credentials = new-object System.Net.NetworkCredential($username, $pass)


$webclient.DownloadString($dummyUri)

Start-Sleep -s 120

$webclient.DownloadString($noipUri)