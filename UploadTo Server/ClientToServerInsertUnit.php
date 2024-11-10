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



/*
ID: 1, sqlID: 0, ownerID: 10, addedByID: 11, addedBy: Worker, date: , name: ???? ???? ????? , 
phone1: 01001592435, phone2: 025740360, work: ????? , unit: 1, offerType: 1, stage: 4, unitGroup: V14, 
unitStructure: 2, unitNumber: 50, unitSection: 2, level: 0, unitType: J, unitArea: 0, garden: 0, gardenArea: 0, 
rooms: 0, bathRooms: 0, furnished: 0, rent: 0, cash: 5000000, allOver: 0, deposit: 0, paid: 0, over: 0, wanted: 0, left: 0, months: 0, info: 
voiceLink: [], photoLink: [], mapLoc: [2917.4571866401016, 3353.7763006977884]}
*/
// Getting the data.
$ownerID = $obj['ownerID'] ;
$addedByID = $obj['addedByID'] ;
$addedBy = $obj['addedBy'] ;

$name = capitalizeAndTrim($obj['name']) ;
$phone1 = capitalizeAndTrim($obj['phone1']) ;
$phone2 = capitalizeAndTrim($obj['phone2']) ;
$work = capitalizeAndTrim($obj['work']) ;

$unit = $obj['unit'] ;
$offerType = $obj['offerType'] ;
$stage = $obj['stage'];
$unitGroup = $obj['unitGroup'];
$unitStructure = $obj['unitStructure'] ;
$unitNumber = $obj['unitNumber'] ;
$unitSection = $obj['unitSection'] ;

$level = $obj['level'] ;
$unitType = $obj['unitType'] ;
$unitArea = $obj['unitArea'] ;
$garden = $obj['garden'] ;
$gardenArea = $obj['gardenArea'] ;
$rooms = $obj['rooms'] ;
$bathRooms = $obj['bathRooms'] ;
$furnished = $obj['furnished'] ;

$rent = $obj['rent'] ;
$cash = $obj['cash'] ;
$allOver = $obj['allOver'] ;
$deposit = $obj['deposit'] ;
$paid = $obj['paid'] ;
$over = $obj['over'] ;
$wanted = $obj['wanted'] ;
$leftAmount = $obj['leftAmount'] ;
$months = $obj['months'] ;

$info = $obj['info'] ;
$voiceLink = $obj['voiceLink'] ;
$photoLink = $obj['photoLink'] ;
$mapLoc = $obj['mapLoc'] ;

$available = $obj['available'] ;

//$name1 = mb_convert_encoding($obj['name'], "utf8");
//$work1 = mb_convert_encoding($obj['work'], "utf8");
//$car1 = mb_convert_encoding($obj['car'], "utf8");
//info,voiceLink,photoLink,mapLoc
//'$info','$voiceLink','$photoLink','$mapLoc' $ownerID

if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}

$getIDQuery1 = "select * from alldata where ownerID = $ownerID and addedByID = $addedByID and unit = $unit and stage = $stage and unitGroup = '$unitGroup' and unitNumber = $unitNumber and unitSection = '$unitSection' and level = $level and unitType = '$unitType'" ;
$getID1 = mysqli_fetch_array(mysqli_query($con, $getIDQuery1)) ;
if (isset($getID1))
{
    $SuccessMSG1 = json_encode($getID1) ;
    echo $SuccessMSG1 ;
}
else
{
    //DataInsert
    $sqlQuery = "INSERT INTO alldata (
    ownerID,addedByID,addedBy,date,name,phone1,phone2,work,
    unit,offerType,stage,unitGroup,unitStructure,unitNumber,unitSection,level,unitType,unitArea,garden,gardenArea,rooms,bathRooms,furnished,
    rent,cash,allOver,deposit,paid,over,wanted,leftAmount,months,
    info,voiceLink,photoLink,mapLoc,lastEditedByID,lastEditedByName,available
    ) VALUES (
    $ownerID,$addedByID,'$addedBy',CURRENT_TIMESTAMP(),'$name','$phone1','$phone2','$work',
    $unit,$offerType,$stage,'$unitGroup',$unitStructure,$unitNumber,'$unitSection',$level,'$unitType',$unitArea,$garden,$gardenArea,$rooms,$bathRooms,$furnished,
    $rent,$cash,$allOver,$deposit,$paid,$over,$wanted,$leftAmount,$months,
    '$info','$voiceLink','$photoLink','$mapLoc',$addedByID,'$addedBy',$available
    )" ;
    
    
    $check = mysqli_query($con, $sqlQuery) ;
    if (isset($check))
    {
        $getIDQuery = "select * from alldata where ownerID = $ownerID and addedByID = $addedByID and unit = $unit and stage = $stage and unitGroup = '$unitGroup' and unitNumber = $unitNumber and unitSection = '$unitSection' and level = $level and unitType = '$unitType'" ;
        $getID = mysqli_fetch_array(mysqli_query($con, $getIDQuery)) ;
        if (isset($getID))
        {
            //Serversync Insert
            //$uniqueRandomString = generateRandomString();
            $insertedID = $getID['ID'];
            $insertedDate = $getID['date'];
            $ServerSyncsqlQuery = "INSERT INTO serversync (OWNERID,DATABASENAME,DATAID,OPERATION,DONEBY,DONEBYNAME,DATE) VALUES($ownerID,'alldata',$insertedID,'Insert',$addedByID,'$addedBy','$insertedDate')";
            $check = mysqli_query($con, $ServerSyncsqlQuery) ;
            
            //return
            $SuccessMSG = json_encode($getID) ;
            echo $SuccessMSG ;
        }
        else
        {
          $InvalidMSG = "[]1" ;
          $InvalidMSGJSon = json_encode($InvalidMSG) ;
          echo $InvalidMSGJSon ;
        }
    }
    else
    {
       $InvalidMSG = "[]2";
       $InvalidMSGJSon = json_encode($InvalidMSG) ;
       echo $InvalidMSGJSon ;
    }
}
mysqli_close($con) ;

function generateRandomString($length = 15)
{
    $characters = "0123456789_-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $charactersLength = strlen($characters);
    $randomString = "";
    for ($i = 0; $i < $length; $i++)
    {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

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