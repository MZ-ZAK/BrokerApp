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
$SQLID = $obj['SQLID'] ;
$WORKERID = $obj['WORKERID'] ;
$gotBy = $obj['gotBy'] ;
$OWNERID = $obj['OWNERID'] ;
$CONTACTNAME = capitalizeAndTrim($obj['CONTACTNAME']) ;
$CONTACTMOBILE = $obj['CONTACTMOBILE'] ;
$CONTACTWORK = capitalizeAndTrim($obj['CONTACTWORK']);
$CONTACTCAR = capitalizeAndTrim($obj['CONTACTCAR']);
$INFO = capitalizeAndTrim($obj['INFO']) ;
$VOICELINK = $obj['VOICELINK'] ;
$DATEADDED = $obj['DATEADDED'];

$REQUESTS = $obj['REQUESTS'] ;

$REQUESTUNITTYPE1 = $obj['REQUESTUNITTYPE1'] ;
$REQUESTTYPE1 = $obj['REQUESTTYPE1'] ;
$REQUESTFURNISH1 = $obj['REQUESTFURNISH1'] ;
$UNITSTRUCTURE1 = $obj['UNITSTRUCTURE1'] ;
$UNITSTYLE1 = $obj['UNITSTYLE1'] ;
$UNITSTAGE1 = $obj['UNITSTAGE1'] ;
$UNITGROUP1 = $obj['UNITGROUP1'] ;
$UNITNAMEVALUE1 = $obj['UNITNAMEVALUE1'] ;
$UNITNAME1 = $obj['UNITNAME1'] ;

$REQUESTUNITTYPE2 = $obj['REQUESTUNITTYPE2'] ;
$REQUESTTYPE2 = $obj['REQUESTTYPE2'] ;
$REQUESTFURNISH2 = $obj['REQUESTFURNISH2'] ;
$UNITSTRUCTURE2 = $obj['UNITSTRUCTURE2'] ;
$UNITSTYLE2 = $obj['UNITSTYLE2'] ;
$UNITSTAGE2 = $obj['UNITSTAGE2'] ;
$UNITGROUP2 = $obj['UNITGROUP2'] ;
$UNITNAMEVALUE2 = $obj['UNITNAMEVALUE2'] ;
$UNITNAME2 = $obj['UNITNAME2'] ;

$REQUESTUNITTYPE3 = $obj['REQUESTUNITTYPE3'] ;
$REQUESTTYPE3 = $obj['REQUESTTYPE3'] ;
$REQUESTFURNISH3 = $obj['REQUESTFURNISH3'] ;
$UNITSTRUCTURE3 = $obj['UNITSTRUCTURE3'] ;
$UNITSTYLE3 = $obj['UNITSTYLE3'] ;
$UNITSTAGE3 = $obj['UNITSTAGE3'] ;
$UNITGROUP3 = $obj['UNITGROUP3'] ;
$UNITNAMEVALUE3 = $obj['UNITNAMEVALUE3'] ;
$UNITNAME3 = $obj['UNITNAME3'] ;

$REQUESTUNITTYPE4 = $obj['REQUESTUNITTYPE4'] ;
$REQUESTTYPE4 = $obj['REQUESTTYPE4'] ;
$REQUESTFURNISH4 = $obj['REQUESTFURNISH4'] ;
$UNITSTRUCTURE4 = $obj['UNITSTRUCTURE4'] ;
$UNITSTYLE4 = $obj['UNITSTYLE4'] ;
$UNITSTAGE4 = $obj['UNITSTAGE4'] ;
$UNITGROUP4 = $obj['UNITGROUP4'] ;
$UNITNAMEVALUE4 = $obj['UNITNAMEVALUE4'] ;
$UNITNAME4 = $obj['UNITNAME4'] ;

$REQUESTUNITTYPE5 = $obj['REQUESTUNITTYPE5'] ;
$REQUESTTYPE5 = $obj['REQUESTTYPE5'] ;
$REQUESTFURNISH5 = $obj['REQUESTFURNISH5'] ;
$UNITSTRUCTURE5 = $obj['UNITSTRUCTURE5'] ;
$UNITSTYLE5 = $obj['UNITSTYLE5'] ;
$UNITSTAGE5 = $obj['UNITSTAGE5'] ;
$UNITGROUP5 = $obj['UNITGROUP5'] ;
$UNITNAMEVALUE5 = $obj['UNITNAMEVALUE5'] ;
$UNITNAME5 = $obj['UNITNAME5'] ;

$REQUESTUNITTYPE6 = $obj['REQUESTUNITTYPE6'] ;
$REQUESTTYPE6 = $obj['REQUESTTYPE6'] ;
$REQUESTFURNISH6 = $obj['REQUESTFURNISH6'] ;
$UNITSTRUCTURE6 = $obj['UNITSTRUCTURE6'] ;
$UNITSTYLE6 = $obj['UNITSTYLE6'] ;
$UNITSTAGE6 = $obj['UNITSTAGE6'] ;
$UNITGROUP6 = $obj['UNITGROUP6'] ;
$UNITNAMEVALUE6 = $obj['UNITNAMEVALUE6'] ;
$UNITNAME6 = $obj['UNITNAME6'] ;

$REQUESTUNITTYPE7 = $obj['REQUESTUNITTYPE7'] ;
$REQUESTTYPE7 = $obj['REQUESTTYPE7'] ;
$REQUESTFURNISH7 = $obj['REQUESTFURNISH7'] ;
$UNITSTRUCTURE7 = $obj['UNITSTRUCTURE7'] ;
$UNITSTYLE7 = $obj['UNITSTYLE7'] ;
$UNITSTAGE7 = $obj['UNITSTAGE7'] ;
$UNITGROUP7 = $obj['UNITGROUP7'] ;
$UNITNAMEVALUE7 = $obj['UNITNAMEVALUE7'] ;
$UNITNAME7 = $obj['UNITNAME7'] ;

$REQUESTUNITTYPE8 = $obj['REQUESTUNITTYPE8'] ;
$REQUESTTYPE8 = $obj['REQUESTTYPE8'] ;
$REQUESTFURNISH8 = $obj['REQUESTFURNISH8'] ;
$UNITSTRUCTURE8 = $obj['UNITSTRUCTURE8'] ;
$UNITSTYLE8 = $obj['UNITSTYLE8'] ;
$UNITSTAGE8 = $obj['UNITSTAGE8'] ;
$UNITGROUP8 = $obj['UNITGROUP8'] ;
$UNITNAMEVALUE8 = $obj['UNITNAMEVALUE8'] ;
$UNITNAME8 = $obj['UNITNAME8'] ;

$REQUESTUNITTYPE9 = $obj['REQUESTUNITTYPE9'] ;
$REQUESTTYPE9 = $obj['REQUESTTYPE9'] ;
$REQUESTFURNISH9 = $obj['REQUESTFURNISH9'] ;
$UNITSTRUCTURE9 = $obj['UNITSTRUCTURE9'] ;
$UNITSTYLE9 = $obj['UNITSTYLE9'] ;
$UNITSTAGE9 = $obj['UNITSTAGE9'] ;
$UNITGROUP9 = $obj['UNITGROUP9'] ;
$UNITNAMEVALUE9 = $obj['UNITNAMEVALUE9'] ;
$UNITNAME9 = $obj['UNITNAME9'] ;

$REQUESTUNITTYPE10 = $obj['REQUESTUNITTYPE10'] ;
$REQUESTTYPE10 = $obj['REQUESTTYPE10'] ;
$REQUESTFURNISH10 = $obj['REQUESTFURNISH10'] ;
$UNITSTRUCTURE10 = $obj['UNITSTRUCTURE1'] ;
$UNITSTYLE10 = $obj['UNITSTYLE10'] ;
$UNITSTAGE10 = $obj['UNITSTAGE10'] ;
$UNITGROUP10 = $obj['UNITGROUP10'] ;
$UNITNAMEVALUE10 = $obj['UNITNAMEVALUE10'] ;
$UNITNAME10 = $obj['UNITNAME10'] ;

//$name1 = mb_convert_encoding($obj['name'], "utf8");
//$work1 = mb_convert_encoding($obj['work'], "utf8");
//$car1 = mb_convert_encoding($obj['car'], "utf8");

if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}

$getIDQuery1 = "select * from clients where ID = $SQLID" ;
$getID1 = mysqli_fetch_array(mysqli_query($con, $getIDQuery1)) ;
if (isset($getID1))
{
	$sqlQuery = "UPDATE clients SET CONTACTNAME = '$CONTACTNAME',CONTACTMOBILE = '$CONTACTMOBILE',CONTACTWORK = '$CONTACTWORK',CONTACTCAR = '$CONTACTCAR',
    INFO = '$INFO',VOICELINK = '$VOICELINK',DATEADDED = CURRENT_TIMESTAMP(),REQUESTS = $REQUESTS".
	
    ",REQUESTUNITTYPE1 = $REQUESTUNITTYPE1,REQUESTTYPE1 = $REQUESTTYPE1,REQUESTFURNISH1 = $REQUESTFURNISH1,UNITSTRUCTURE1 = $UNITSTRUCTURE1
	,UNITSTYLE1 = $UNITSTYLE1,UNITSTAGE1 = $UNITSTAGE1,UNITGROUP1 = '$UNITGROUP1',UNITNAMEVALUE1 = $UNITNAMEVALUE1,UNITNAME1 = '$UNITNAME1'".
	
	",REQUESTUNITTYPE2 = $REQUESTUNITTYPE2,REQUESTTYPE2 = $REQUESTTYPE2,REQUESTFURNISH2 = $REQUESTFURNISH2,UNITSTRUCTURE2 = $UNITSTRUCTURE2
	,UNITSTYLE2 = $UNITSTYLE2,UNITSTAGE2 = $UNITSTAGE2,UNITGROUP2 = '$UNITGROUP2',UNITNAMEVALUE2 = $UNITNAMEVALUE2,UNITNAME2 = '$UNITNAME2'".
    
    ",REQUESTUNITTYPE3 = $REQUESTUNITTYPE3,REQUESTTYPE3 = $REQUESTTYPE3,REQUESTFURNISH3 = $REQUESTFURNISH3,UNITSTRUCTURE3 = $UNITSTRUCTURE3
	,UNITSTYLE3 = $UNITSTYLE3,UNITSTAGE3 = $UNITSTAGE3,UNITGROUP3 = '$UNITGROUP3',UNITNAMEVALUE3 = $UNITNAMEVALUE3,UNITNAME3 = '$UNITNAME3'".
    
    ",REQUESTUNITTYPE4 = $REQUESTUNITTYPE4,REQUESTTYPE4 = $REQUESTTYPE4,REQUESTFURNISH4 = $REQUESTFURNISH4,UNITSTRUCTURE4 = $UNITSTRUCTURE4
	,UNITSTYLE4 = $UNITSTYLE4,UNITSTAGE4 = $UNITSTAGE4,UNITGROUP4 = '$UNITGROUP4',UNITNAMEVALUE4 = $UNITNAMEVALUE4,UNITNAME4 = '$UNITNAME4'".
    
    ",REQUESTUNITTYPE5 = $REQUESTUNITTYPE5,REQUESTTYPE5 = $REQUESTTYPE5,REQUESTFURNISH5 = $REQUESTFURNISH5,UNITSTRUCTURE5 = $UNITSTRUCTURE5
	,UNITSTYLE5 = $UNITSTYLE5,UNITSTAGE5 = $UNITSTAGE5,UNITGROUP5 = '$UNITGROUP5',UNITNAMEVALUE5 = $UNITNAMEVALUE5,UNITNAME5 = '$UNITNAME5'".
    
    ",REQUESTUNITTYPE6 = $REQUESTUNITTYPE6,REQUESTTYPE6 = $REQUESTTYPE6,REQUESTFURNISH6 = $REQUESTFURNISH6,UNITSTRUCTURE6 = $UNITSTRUCTURE6
	,UNITSTYLE6 = $UNITSTYLE6,UNITSTAGE6 = $UNITSTAGE6,UNITGROUP6 = '$UNITGROUP6',UNITNAMEVALUE6 = $UNITNAMEVALUE6,UNITNAME6 = '$UNITNAME6'".
    
    ",REQUESTUNITTYPE7 = $REQUESTUNITTYPE7,REQUESTTYPE7 = $REQUESTTYPE7,REQUESTFURNISH7 = $REQUESTFURNISH7,UNITSTRUCTURE7 = $UNITSTRUCTURE7
	,UNITSTYLE7 = $UNITSTYLE7,UNITSTAGE7 = $UNITSTAGE7,UNITGROUP7 = '$UNITGROUP7',UNITNAMEVALUE7 = $UNITNAMEVALUE7,UNITNAME7 = '$UNITNAME7'".
    
    ",REQUESTUNITTYPE8 = $REQUESTUNITTYPE8,REQUESTTYPE8 = $REQUESTTYPE8,REQUESTFURNISH8 = $REQUESTFURNISH8,UNITSTRUCTURE8 = $UNITSTRUCTURE8
	,UNITSTYLE8 = $UNITSTYLE8,UNITSTAGE8 = $UNITSTAGE8,UNITGROUP8 = '$UNITGROUP8',UNITNAMEVALUE8 = $UNITNAMEVALUE8,UNITNAME8 = '$UNITNAME8'".
    
    ",REQUESTUNITTYPE9 = $REQUESTUNITTYPE9,REQUESTTYPE9 = $REQUESTTYPE9,REQUESTFURNISH9 = $REQUESTFURNISH9,UNITSTRUCTURE9 = $UNITSTRUCTURE9
	,UNITSTYLE9 = $UNITSTYLE9,UNITSTAGE9 = $UNITSTAGE9,UNITGROUP9 = '$UNITGROUP9',UNITNAMEVALUE9 = $UNITNAMEVALUE9,UNITNAME9 = '$UNITNAME9'".
    
    ",REQUESTUNITTYPE10 = $REQUESTUNITTYPE10,REQUESTTYPE10 = $REQUESTTYPE10,REQUESTFURNISH10 = $REQUESTFURNISH10,UNITSTRUCTURE10 = $UNITSTRUCTURE10
	,UNITSTYLE10 = $UNITSTYLE10,UNITSTAGE10 = $UNITSTAGE10,UNITGROUP10 = '$UNITGROUP10',UNITNAMEVALUE10 = $UNITNAMEVALUE10,UNITNAME10 = '$UNITNAME10' WHERE ID = $SQLID";
	
	$check = mysqli_query($con, $sqlQuery) ;
	if (isset($check))
	{
	   $getIDQuery3 = "select * from clients where ID = $SQLID" ;
	   $getID3 = mysqli_fetch_array(mysqli_query($con, $getIDQuery3)) ;
       if (isset($getID1))
        {
            $returnValue1 = [$getID3['DATEADDED']];
    		$SuccessMSG1 = json_encode($returnValue1) ;
    		echo $SuccessMSG1 ;
        }
	}
	else
	{
		$returnValue1 = "UPDATED2";
		$SuccessMSG1 = json_encode($returnValue1) ;
		echo $SuccessMSG1 ;
	}
}
else
{
    $returnValue1 = "UPDATED3";
    $SuccessMSG1 = json_encode($returnValue1) ;
    echo $SuccessMSG1 ;
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