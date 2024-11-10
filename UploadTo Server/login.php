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
$receviedData = $obj['mac'] ;
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}
$loginQuery = "SELECT * FROM worker WHERE MAC = '$receviedData'" ;
$check = mysqli_fetch_array(mysqli_query($con, $loginQuery)) ;
if (isset($check))
{
    if($check['ACTIVE'] == 0)
    {
       $InvalidMSG = [100] ;
       $InvalidMSGJSon = json_encode($InvalidMSG) ;
       echo $InvalidMSGJSon ;
    }
    else
    {
       $workerIDFromCheck = $check['ID']; 
       $OWNERIDFromCheck = $check['OWNERID']; 
       $AllClientData = "SELECT * FROM clients WHERE WORKERID = $workerIDFromCheck";
       $AllUnitsData = "SELECT * FROM alldata WHERE ownerID = $OWNERIDFromCheck";
       //." ORDER BY CONTACTNAME ASC" ;
       $result = mysqli_query($con, $AllClientData) ;
       $resultAllData = mysqli_query($con, $AllUnitsData) ;
       $rowHasAValue = mysqli_num_rows($result) ;
       $post = [] ;
       if ($rowHasAValue > 0)
       {
          while ($row = mysqli_fetch_row($result))
          {
             array_push($post, $row) ;
          }
       }
       $postAllData = [] ;
       $rowHasAValueAllData = mysqli_num_rows($resultAllData) ;
       if ($rowHasAValueAllData > 0)
       {
          while ($rowAllData = mysqli_fetch_row($resultAllData))
          {
             array_push($postAllData, $rowAllData) ;
          }
       }
       $arrayTest = [$check, $post, $postAllData] ;
       $SuccessMSG = json_encode($arrayTest) ;
       echo $SuccessMSG ;
    }
}
else
{
   $InvalidMSG = [0] ;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
mysqli_close($con) ;

?>