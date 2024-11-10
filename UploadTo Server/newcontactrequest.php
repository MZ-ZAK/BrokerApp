<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

// Getting the received JSON into $json variable.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;

$json = file_get_contents('php://input') ;
// Decoding the received JSON and store into $obj variable.
$obj = json_decode($json, true) ;
// Getting the data.
$rowid = $obj['id'] ;

$requestID = $obj['id'] ;

$divider = '$@#Ae+';

$requestData = "";

if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}
//Request data form
/*
'id' . $dividerXData . ''

*/
$sqlQuery = "UPDATE clients SET REQUEST'" . $requestID . "' = '" . $requestData . "' WHERE ID = '" . $rowid . "'";
$check = mysqli_query($con, $sqlQuery) ;
if (isset($check))
{
   $SuccessMSG = json_encode("1") ;
   echo $SuccessMSG ;
}
else
{
   $InvalidMSG = '0' ;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
mysqli_close($con) ;
?>