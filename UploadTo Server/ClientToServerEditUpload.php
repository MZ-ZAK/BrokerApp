<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

// Getting the received JSON into $json variable.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;

for($steps = 0; $steps < 9;$steps++)
{
    if($steps == 0)
    {
        // Getting the data.
        $SQLID;
        if(isset($_POST['SQLID']))
        {
            $SQLID = $_POST['SQLID'];
        }
        
        $WORKERID;
        if(isset($_POST['WORKERID']))
        {
            $WORKERID = $_POST['WORKERID'];
        }
        
        $gotBy;
        if(isset($_POST['gotBy']))
        {
            $gotBy = $_POST['gotBy'];
        }
        
        $OWNERID;
        if(isset($_POST['OWNERID']))
        {
            $OWNERID = $_POST['OWNERID'];
        }
        
        $ACTIVEUSER;
        if(isset($_POST['ACTIVEUSER']))
        {
            $ACTIVEUSER = $_POST['ACTIVEUSER'];
        }
        
        $CONTACTNAME;
        if(isset($_POST['CONTACTNAME']))
        {
            $CONTACTNAME = capitalizeAndTrim($_POST['CONTACTNAME']);
        }
        
        $CONTACTMOBILE;
        if(isset($_POST['CONTACTMOBILE']))
        {
            $CONTACTMOBILE = $_POST['CONTACTMOBILE'];
        }
        
        $CONTACTWORK;
        if(isset($_POST['CONTACTWORK']))
        {
            $CONTACTWORK = capitalizeAndTrim($_POST['CONTACTWORK']);
        }
        
        $CONTACTCAR;
        if(isset($_POST['CONTACTCAR']))
        {
            $CONTACTCAR = capitalizeAndTrim($_POST['CONTACTCAR']);
        }
        
        $INFO;
        if(isset($_POST['INFO']))
        {
            $INFO = capitalizeAndTrim($_POST['INFO']);
        }
        
        $VOICELINK;
        if(isset($_POST['VOICELINK']))
        {
            $VOICELINK = $_POST['VOICELINK'];
        }
        
        $DATEADDED;
        if(isset($_POST['DATEADDED']))
        {
            $DATEADDED = $_POST['DATEADDED'];
        }
    }
    if($steps == 1)
    {
        $VOICELINKNEWVALUES = [];

        $getIDQuery5 = "select VOICELINK from clients where ID = $SQLID" ;
        $getID5 = mysqli_fetch_array(mysqli_query($con, $getIDQuery5)) ;
        if (isset($getID5))
        {
            $oldDatabaseVoiceLinks = stringToArray($getID5['VOICELINK']);
            $newDatabaseVoiceLinks = stringToArray($VOICELINK);
            if($oldDatabaseVoiceLinks != false && $newDatabaseVoiceLinks != false)
            {
                for($i22 = 0; $i22 < count($oldDatabaseVoiceLinks) ; $i22++)
                {
                    $a = false;
                    for($i = 0; $i < count($newDatabaseVoiceLinks) ; $i++)
                    {
                        if($oldDatabaseVoiceLinks[$i22] == $newDatabaseVoiceLinks[$i])
                        {
                            $a = true;
                            break;
                        }
                    }
                    if($a == false)
                    {
                        if (is_file("AudioFiles/" . $OWNERID . "/contact/" . $oldDatabaseVoiceLinks[$i22] . ".aac"))
                        {
                            unlink("AudioFiles/" . $OWNERID . "/contact/" . $oldDatabaseVoiceLinks[$i22] . ".aac");
                        }
                    }
                } 
            }
            else if($newDatabaseVoiceLinks == false && $oldDatabaseVoiceLinks != false)
            {
                for($f = 0; $f < count($oldDatabaseVoiceLinks) ; $f++)
                {
                    if (is_file("AudioFiles/" . $OWNERID . "/contact/" . $oldDatabaseVoiceLinks[$f] . ".aac"))
                    {
                        unlink("AudioFiles/" . $OWNERID . "/contact/" . $oldDatabaseVoiceLinks[$f] . ".aac");
                    }
                }
            }
        }
        $newDatabaseVoiceLinks = stringToArray($VOICELINK);
        if($newDatabaseVoiceLinks != false)
        {
            $VOICELINKNEWVALUES = $newDatabaseVoiceLinks;
        }
    }
    
    if($steps == 2)
    {
        if(isset($_FILES['Audio0']['name']))
        {
            $Audio0=$_FILES['Audio0']['name'];
            $AudioPath= "AudioFiles/" . $OWNERID . "/contact/" . $Audio0;
            if (file_exists($AudioPath))
            {
                //array_push($VOICELINKNEWVALUES,substr($Audio0,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio0']['tmp_name'],$AudioPath);
                //array_push($VOICELINKNEWVALUES,substr($Audio0,0,-4));
            }
        }
    }
    if($steps == 3)
    {
        if(isset($_FILES['Audio1']['name']))
        {
            $Audio1=$_FILES['Audio1']['name'];
            $AudioPath= "AudioFiles/" . $OWNERID . "/contact/" . $Audio1;
            if (file_exists($AudioPath))
            {
                //array_push($VOICELINKNEWVALUES,substr($Audio1,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio1']['tmp_name'],$AudioPath);
                //array_push($VOICELINKNEWVALUES,substr($Audio1,0,-4));
            }
        }
    }  
    if($steps == 4)
    {
        if(isset($_FILES['Audio2']['name']))
        {
            $Audio2=$_FILES['Audio2']['name'];
            $AudioPath= "AudioFiles/" . $OWNERID . "/contact/" . $Audio2;
            if (file_exists($AudioPath))
            {
                //array_push($VOICELINKNEWVALUES,substr($Audio2,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio2']['tmp_name'],$AudioPath);
                //array_push($VOICELINKNEWVALUES,substr($Audio2,0,-4));;
            }
        }
    } 
    if($steps == 5)
    {
        if(isset($_FILES['Audio3']['name']))
        {
            $Audio3=$_FILES['Audio3']['name'];
            $AudioPath= "AudioFiles/" . $OWNERID . "/contact/" . $Audio3;
            if (file_exists($AudioPath))
            {
                //array_push($VOICELINKNEWVALUES,substr($Audio3,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio3']['tmp_name'],$AudioPath);
                //array_push($VOICELINKNEWVALUES,substr($Audio3,0,-4));
            }
        }
    } 
    if($steps == 6)
    {
        if(isset($_FILES['Audio4']['name']))
        {
            $Audio4=$_FILES['Audio4']['name'];
            $AudioPath= "AudioFiles/" . $OWNERID . "/contact/" . $Audio4;
            if (file_exists($AudioPath))
            {
                //array_push($VOICELINKNEWVALUES,substr($Audio4,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio4']['tmp_name'],$AudioPath);
                //array_push($VOICELINKNEWVALUES,substr($Audio4,0,-4));
            }
        }
    }    
    if($steps == 7)
    {
        $VOICELINKARRAYTOSTRING = "[";
        for($km = 0; $km < count($VOICELINKNEWVALUES); $km ++)
        {
            if($km < count($VOICELINKNEWVALUES) - 1)
            {
                $VOICELINKARRAYTOSTRING = $VOICELINKARRAYTOSTRING . $VOICELINKNEWVALUES[$km] . ",";
            }
            else
            {
                $VOICELINKARRAYTOSTRING = $VOICELINKARRAYTOSTRING . $VOICELINKNEWVALUES[$km] . "]";
            }
        }
        
        if(count($VOICELINKNEWVALUES) == 0)
        {
            $VOICELINKARRAYTOSTRING = "[]";
        }
    }    
    if($steps == 8)
    {
        if (! mysqli_set_charset($con, "utf8"))
        {
           exit() ;
        }
        
        $getIDQuery1 = "select * from clients where ID = $SQLID" ;
        $getID1 = mysqli_fetch_array(mysqli_query($con, $getIDQuery1)) ;
        if (isset($getID1))
        {
        	$sqlQuery = "UPDATE clients SET ACTIVEUSER = $ACTIVEUSER,CONTACTNAME = '$CONTACTNAME',CONTACTMOBILE = '$CONTACTMOBILE',CONTACTWORK = '$CONTACTWORK',CONTACTCAR = '$CONTACTCAR',
            INFO = '$INFO',VOICELINK = '$VOICELINKARRAYTOSTRING',DATEADDED = CURRENT_TIMESTAMP() WHERE ID = $SQLID";
        	
        	$check = mysqli_query($con, $sqlQuery) ;
        	if (isset($check))
        	{
        	   $getIDQuery3 = "select * from clients where ID = $SQLID" ;
        	   $getID3 = mysqli_fetch_array(mysqli_query($con, $getIDQuery3)) ;
               if (isset($getID3))
                {
                    //$returnValue1 = [$getID3['DATEADDED'],$getID3['VOICELINK']];
                    //$returnArrayString = "[";
                    //$returnArrayString = $returnArrayString . implode(",",$returnValue1) . "]";
                    $returnIs['DATEADDED'] = $getID3['DATEADDED'];
                    $returnIs['VOICELINK'] = $getID3['VOICELINK'];
            		$SuccessMSG1 = json_encode($returnIs) ;
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
    }
}
function stringToArray($dataString)
{
    $returnData = [];
    if(strlen($dataString) > 3)
    {
        $dataString = substr($dataString, 1);
        $item = "";
        for($i11 = 0; $i11 < strlen($dataString) ; $i11++)
        {
            if (substr($dataString, $i11, 1) != "," && substr($dataString, $i11, 1) != "]")
            {
                $item = $item . substr($dataString, $i11, 1);
            }
            else if (substr($dataString, $i11, 1) == ",")
            {
                if(strlen($item)>4)
                {
                    array_push($returnData,trim($item));
                    $item = "";
                }
                else
                {
                   $item = ""; 
                }
            }
            else if (substr($dataString, $i11, 1) == "]")
            {
                if(strlen($item)>4)
                {
                    array_push($returnData,trim($item));
                    $item = "";
                }
                else
                {
                   $item = ""; 
                }
            }
        }
    return $returnData;
    }
    else {return false;}
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