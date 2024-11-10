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
$ID = $obj['id'] ;

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (!mysqli_set_charset($con, "utf8"))
{
    exit();
}

$sqlQuery = "UPDATE clients SET CONTACTMOBILE = 0 WHERE ID = " . $ID . "'";
$check = mysqli_query($con, $sqlQuery) ;
if (isset($check))
{
   $SuccessMSG = json_encode("Done") ;
   echo $SuccessMSG ;
}
else
{
   $InvalidMSG = 'Not Done' ;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
mysqli_close($con) ;

?>