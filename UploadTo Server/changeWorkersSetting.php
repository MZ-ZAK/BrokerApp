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
$workerSQLID = $obj['workerSQLID'] ;
$OWNERID = $obj['OWNERID'] ;
$EditedByID = $obj['EditedByID'] ;
$EditedByName = $obj['EditedByName'] ;
$ACTIVE = $obj['ACTIVE'] ;
$ADMIN = $obj['ADMIN'] ;


if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}

$sqlQuery = "UPDATE worker SET ACTIVE = $ACTIVE, ADMIN = $ADMIN WHERE ID = $workerSQLID";
$check = mysqli_query($con, $sqlQuery) ;
if (isset($check))
{
    $sqlQueryDate = "SELECT CURRENT_TIMESTAMP()";
    $sqlQueryDateQuery = mysqli_fetch_array(mysqli_query($con, $sqlQueryDate)); 
    $insertedDate = $sqlQueryDateQuery[0];
    $ServerSyncsqlQuery = "INSERT INTO serversync (OWNERID,DATABASENAME,DATAID,OPERATION,DONEBY,DONEBYNAME,DATE) VALUES ($OWNERID,'worker',$workerSQLID,'Update',$EditedByID,'$EditedByName','$insertedDate')";
    $check = mysqli_query($con, $ServerSyncsqlQuery) ;
                    
    $InvalidMSG = 1;
    $SuccessMSG = json_encode($InvalidMSG) ;
    echo $SuccessMSG ;
}
else
{
   $InvalidMSG = 2;
   $InvalidMSGJSon = json_encode($InvalidMSG) ;
   echo $InvalidMSGJSon ;
}
mysqli_close($con) ;

function DotTest($data)
{
    $data = trim($data) ;
    $filteredData = str_replace(' ','.',$data);
    return $filteredData;
    for ($i0 = 0; $i0 < 10; $i0++)
    {
        $filteredData = str_replace('  ',' ',$filteredData);
        if($i0 == 9)
        {
            //return $filteredData;
        }
    }
}

function capitalizeAndTrim($data)
{
   $data = trim($data," ") ;
   $stringRev = strrev($data);
   
   $sOut = '' ;
   $foundSpace = 0 ;
   $startAt = 0;
   $stopAt = 0;
   
   for ($i2 = 0; $i2 < strlen($stringRev); $i2++)
   {
        if(substr($stringRev, $i2, 1) != " ")
        {
            $sOut = substr($stringRev,$i2);
            break;
        }
   }
   
   $stringRev = strrev($sOut);
   $sOut = "";
   
   for ($i1 = 0; $i1 < strlen($stringRev); $i1++)
   {
        if(substr($stringRev, $i1, 1) != " ")
        {
            $sOut = substr($stringRev,$i1);
            break;
        }
   }
   
   $stringRev = $sOut;
   $sOut = "";
   
   for ($i = 0; $i < strlen($stringRev); $i++)
   {
      if (substr($stringRev, $i, 1) == " ")
      {
         $foundSpace++ ;
         if ($foundSpace > 1)
         {
            continue ;
         }
      }
      else
      {
         $foundSpace = 0 ;
      }
      $sOut = $sOut . substr($stringRev, $i, 1) ;
   }
   /*
   $words = explode(' ', $sOut);
   $capitalized = [];
   foreach ($words as $w) {
   $capitalized.add($words.$capitalized);
   }
   */
   return ucwords($sOut) ;
   //return $sOut ;
}
function EgyptDate($mysqlTimeData)
{
   $g = strtotime($mysqlTimeData) + (9 * 3600) ;
   $date = date('Y M d h:i:s', $g) ;
   return $date ;
}
function NormalDate($mysqlTimeData)
{
   $g = strtotime($mysqlTimeData) + (9 * 3600) ;
   $date = date('Y M d h:i:s', $g) ;
   return $date ;
}

?>