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
$ID = $obj['ID'] ;
$OWNERID = $obj['OWNERID'] ;

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}
$sqlQuery = "select * from serversync where ID > $ID AND OWNERID = $OWNERID" ;
$check = mysqli_num_rows(mysqli_query($con, $sqlQuery)) ;
if (isset($check))
{
  $SuccessMSG = json_encode($check) ;
  echo $SuccessMSG ;
}
?>