<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

// Getting the received JSON into $json variable.
$json = file_get_contents('php://input') ;
// Decoding the received JSON and store into $obj variable.
$obj = json_decode($json, true) ;
// Getting the data.
$userID = $obj['id'] ;
$mobile = $obj['mobile'] ;

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (!mysqli_set_charset($con, "utf8"))
{
    exit();
}

$loginQuery = "select * from clients where WORKERID = '$userID' and CONTACTMOBILE = '$mobile'" ;
      
$check = mysqli_fetch_array(mysqli_query($con, $loginQuery)) ;
if (isset($check))
{
   $InvalidMSG = "Found" ;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
else
{
   $InvalidMSG = "Not Found" ;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
mysqli_close($con) ;

?>