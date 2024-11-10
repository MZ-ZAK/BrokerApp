<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (!$con) {
    die('Could not connect: ' .  mysqli_error());
}
echo 'Connected successfully';

$loginQuery = "SELECT * FROM constants";
$check = mysqli_fetch_array(mysqli_query($con, $loginQuery)) ;
if (isset($check))
{
	echo "SQL Connected";
}
else
{
	echo "SQL NOT Connected";
}
mysqli_close($con) ;
?>