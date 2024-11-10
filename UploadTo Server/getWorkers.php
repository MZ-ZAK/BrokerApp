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
$ownerID = $obj['ID'] ;
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}

$workersQuery = "SELECT * FROM worker WHERE OWNERID = $ownerID AND ID != $ownerID" ;

$result = mysqli_query($con, $workersQuery) ;
$rowHasAValue = mysqli_num_rows($result) ;
$workers = [] ;
if ($rowHasAValue > 0)
{
  while ($row = mysqli_fetch_row($result))
  {
     array_push($workers, $row) ;
  }
}

$SuccessMSG = json_encode($workers) ;
echo $SuccessMSG ;
?>