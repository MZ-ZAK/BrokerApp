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
$Mac = $obj['mac'] ;
$requestCode = $obj['requestCode'] ;
$userName = $obj['userName'] ;
$userPhone = $obj['userPhone'] ;
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}
$sqlQuery1 = "select * from worker where COMPANYMOBILE = '$requestCode'" ;
$check1 = mysqli_fetch_array(mysqli_query($con, $sqlQuery1)) ;
if (isset($check1))
{
   $serverSyncQuery = "select AUTO_INCREMENT from information_schema.TABLES where(TABLE_NAME = 'serversync')" ;
   $lastID_oFserverSyncQuery = mysqli_fetch_array(mysqli_query($con, $serverSyncQuery))[0]-1;
   $ownerId = $check1['OWNERID'];
   $companyName = $check1['COMPANYNAME'];
   $WORKERSCOUNT = $check1['WORKERSCOUNT'];
   $startDate = $check1['STARTDATE'];
   $endDate = $check1['ENDDATE'];
   $sqlQuery2 = "INSERT INTO worker (NAME,MOBILE,MAC,OWNERID,COMPANYNAME,COMPANYMOBILE,WORKERSCOUNT,STARTDATE,ENDDATE,LASTUPDATEID) VALUES ('$userName','$userPhone','$Mac',$ownerId,'$companyName','$requestCode',$WORKERSCOUNT,'$startDate','$endDate',$lastID_oFserverSyncQuery)" ;
   $check2 = mysqli_query($con, $sqlQuery2) ;
   if (isset($check2))
   {
      $SuccessMSG1 = json_encode("Done") ;
      echo $SuccessMSG1 ;
   }
}
else
{
   $sqlQuery3 = "select * from constants where CODE = '$requestCode'" ;
   $check3 = mysqli_fetch_array(mysqli_query($con, $sqlQuery3)) ;
   if (isset($check3))
   {
     $serverSyncQuery = "select AUTO_INCREMENT from information_schema.TABLES where(TABLE_NAME = 'serversync')" ;
     $lastID_oFserverSyncQuery = mysqli_fetch_array(mysqli_query($con, $serverSyncQuery))[0]-1;
     $lastIDQuery = "select AUTO_INCREMENT from information_schema.TABLES where(TABLE_NAME = 'worker')" ;
     $check5 = mysqli_fetch_array(mysqli_query($con, $lastIDQuery)) ;
     $newID = $check5[0];
     $sqlQuery4 = "INSERT INTO worker (NAME,MOBILE,MAC,OWNER,OWNERID,COMPANYNAME,COMPANYMOBILE,LASTUPDATEID) VALUES ('$userName','$userPhone','$Mac', 1, $newID,'$userName','$userPhone',$lastID_oFserverSyncQuery)" ;
        
     $check4 = mysqli_query($con, $sqlQuery4) ;
     if (isset($check4))
     {
        $sqlQuery6 = "select * from worker where ID = $newID" ;
        $check6 = mysqli_fetch_array(mysqli_query($con, $sqlQuery6)) ;
        if (isset($check6))
        {
            $pathToID1 = "AudioFiles/".$newID."/contact/";
            $pathToID2 = "AudioFiles/".$newID."/unit/";
            if(!file_exists($pathToID1))
            {
                mkdir($pathToID1, 0777, true);
            }
            if(!file_exists($pathToID2))
            {
                mkdir($pathToID2, 0777, true);
            }
            /*
            if (!mkdir($pathToID1, 0777, true)) {
                die('Failed to create folders...');
            }
            if (!mkdir($pathToID2, 0777, true)) {
                die('Failed to create folders...');
            }*/
            $arrayReturn = [$check6];
            $SuccessMSG2 = json_encode($arrayReturn) ;
            echo $SuccessMSG2 ;
        }
        else
          {
             $InvalidMSG = 'Connected...' ;
             $InvalidMSGJSon = json_encode($InvalidMSG) ;
             echo $InvalidMSGJSon ;
          }
     }
     else
      {
         $InvalidMSG = 'Connected...' ;
         $InvalidMSGJSon = json_encode($InvalidMSG) ;
         echo $InvalidMSGJSon ;
      }
   }
   else
   {
      $InvalidMSG = 'Connected...' ;
      $InvalidMSGJSon = json_encode($InvalidMSG) ;
      echo $InvalidMSGJSon ;
   }
}
mysqli_close($con) ;

?>