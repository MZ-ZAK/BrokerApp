<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

// Getting the received JSON into $json variable.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;

for($steps = 0; $steps < 18;$steps++)
{
    if($steps == 0)
    {
        //WorkerID who edited
        $WorkerID;
        if(isset($_POST['WorkerID']))
        {
            $WorkerID = $_POST['WorkerID'];
        }
        $WorkerNAME;
        if(isset($_POST['WorkerNAME']))
        {
            $WorkerNAME = $_POST['WorkerNAME'];
        }
        
        // Getting the data.
        $sqlID;
        if(isset($_POST['sqlID']))
        {
            $sqlID = $_POST['sqlID'];
        }
        $ownerID;
        if(isset($_POST['ownerID']))
        {
            $ownerID = $_POST['ownerID'];
        }
        
        $addedByID;
        if(isset($_POST['addedByID']))
        {
            $addedByID = $_POST['addedByID'];
        }
        
        $addedBy;
        if(isset($_POST['addedBy']))
        {
            $addedBy = capitalizeAndTrim($_POST['addedBy']);
        }
        
        $name;
        if(isset($_POST['name']))
        {
            $name = capitalizeAndTrim($_POST['name']);
        }
        
        $phone1;
        if(isset($_POST['phone1']))
        {
            $phone1 = capitalizeAndTrim($_POST['phone1']);
        }
        
        $phone2;
        if(isset($_POST['phone2']))
        {
            $phone2 = capitalizeAndTrim($_POST['phone2']);
        }
        
        $work;
        if(isset($_POST['work']))
        {
            $work = capitalizeAndTrim($_POST['work']);
        }
        
        $unit;
        if(isset($_POST['unit']))
        {
            $unit = $_POST['unit'];
        }
        
        $offerType;
        if(isset($_POST['offerType']))
        {
            $offerType = $_POST['offerType'];
        }
        
        $stage;
        if(isset($_POST['stage']))
        {
            $stage = $_POST['stage'];
        }
        
        $unitGroup;
        if(isset($_POST['unitGroup']))
        {
            $unitGroup = capitalizeAndTrim($_POST['unitGroup']);
        }
        
        $unitStructure;
        if(isset($_POST['unitStructure']))
        {
            $unitStructure = $_POST['unitStructure'];
        }
        
        $unitNumber;
        if(isset($_POST['unitNumber']))
        {
            $unitNumber = $_POST['unitNumber'];
        }
        
        $unitSection;
        if(isset($_POST['unitSection']))
        {
            $unitSection = capitalizeAndTrim($_POST['unitSection']);
        }
        
        $level;
        if(isset($_POST['level']))
        {
            $level = $_POST['level'];
        }
        
        $unitType;
        if(isset($_POST['unitType']))
        {
            $unitType = capitalizeAndTrim($_POST['unitType']);
        }
        
        $unitArea;
        if(isset($_POST['unitArea']))
        {
            $unitArea = $_POST['unitArea'];
        }
        $garden;
        if(isset($_POST['garden']))
        {
            $garden = $_POST['garden'];
        }
        $gardenArea;
        if(isset($_POST['gardenArea']))
        {
            $gardenArea = $_POST['gardenArea'];
        }
        $rooms;
        if(isset($_POST['rooms']))
        {
            $rooms = $_POST['rooms'];
        }
        $bathRooms;
        if(isset($_POST['bathRooms']))
        {
            $bathRooms = $_POST['bathRooms'];
        }
        $furnished;
        if(isset($_POST['furnished']))
        {
            $furnished = $_POST['furnished'];
        }
        $rent;
        if(isset($_POST['rent']))
        {
            $rent = $_POST['rent'];
        }
        $cash;
        if(isset($_POST['cash']))
        {
            $cash = $_POST['cash'];
        }
        $allOver;
        if(isset($_POST['allOver']))
        {
            $allOver = $_POST['allOver'];
        }
        $deposit;
        if(isset($_POST['deposit']))
        {
            $deposit = $_POST['deposit'];
        }
        $paid;
        if(isset($_POST['paid']))
        {
            $paid = $_POST['paid'];
        }
        $over;
        if(isset($_POST['over']))
        {
            $over = $_POST['over'];
        }
        $wanted;
        if(isset($_POST['wanted']))
        {
            $wanted = $_POST['wanted'];
        }
        $leftAmount;
        if(isset($_POST['leftAmount']))
        {
            $leftAmount = $_POST['leftAmount'];
        }
        $months;
        if(isset($_POST['months']))
        {
            $months = $_POST['months'];
        }
        
        $info;
        if(isset($_POST['info']))
        {
            $info = $_POST['info'];
        }
        $voiceLink;
        if(isset($_POST['voiceLink']))
        {
            $voiceLink = capitalizeAndTrim($_POST['voiceLink']);
        }
        $photoLink;
        if(isset($_POST['photoLink']))
        {
            $photoLink = capitalizeAndTrim($_POST['photoLink']);
        }
        $mapLoc;
        if(isset($_POST['mapLoc']))
        {
            $mapLoc = capitalizeAndTrim($_POST['mapLoc']);
        }
        $available;
        if(isset($_POST['available']))
        {
            $available = $_POST['available'];
        }
    }
    if($steps == 1)
    {
        
        $voiceLinkNEWVALUES = [];
        
        $getIDQuery5 = "select voiceLink from alldata where ID = $sqlID" ;
        $getID5 = mysqli_fetch_array(mysqli_query($con, $getIDQuery5)) ;
        if (isset($getID5))
        {
            $oldDatabasevoiceLinks = stringToArray($getID5['voiceLink']);
            $newDatabasevoiceLinks = stringToArray($voiceLink);
            if($oldDatabasevoiceLinks != false && $newDatabasevoiceLinks != false)
            {
                for($i22 = 0; $i22 < count($oldDatabasevoiceLinks) ; $i22++)
                {
                    $a = false;
                    for($i = 0; $i < count($newDatabasevoiceLinks) ; $i++)
                    {
                        if($oldDatabasevoiceLinks[$i22] == $newDatabasevoiceLinks[$i])
                        {
                            $a = true;
                            break;
                        }
                    }
                    if($a == false)
                    {
                        if (is_file("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasevoiceLinks[$i22] . ".aac"))
                        {
                            unlink("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasevoiceLinks[$i22] . ".aac");
                        }
                    }
                } 
            }
            else if($newDatabasevoiceLinks == false && $oldDatabasevoiceLinks != false)
            {
                for($f = 0; $f < count($oldDatabasevoiceLinks) ; $f++)
                {
                    if (is_file("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasevoiceLinks[$f] . ".aac"))
                    {
                        unlink("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasevoiceLinks[$f] . ".aac");
                    }
                }
            }
        }
        $newDatabasevoiceLinks = stringToArray($voiceLink);
        if($newDatabasevoiceLinks != false)
        {
            $voiceLinkNEWVALUES = $newDatabasevoiceLinks;
}
    }
    if($steps == 2)
    {
        if(isset($_FILES['Audio0']['name']))
        {
            $Audio0=$_FILES['Audio0']['name'];
            $AudioPath= "AudioFiles/" . $ownerID . "/unit/" . $Audio0;
            if (file_exists($AudioPath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio0,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio0']['tmp_name'],$AudioPath);
                //array_push($voiceLinkNEWVALUES,substr($Audio0,0,-4));
            }
        }
    }
    if($steps == 3)
    {
        if(isset($_FILES['Audio1']['name']))
        {
            $Audio1=$_FILES['Audio1']['name'];
            $AudioPath= "AudioFiles/" . $ownerID . "/unit/" . $Audio1;
            if (file_exists($AudioPath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio1,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio1']['tmp_name'],$AudioPath);
                //array_push($voiceLinkNEWVALUES,substr($Audio1,0,-4));
            }
        }
    }
    if($steps == 4)
    {
        if(isset($_FILES['Audio2']['name']))
        {
            $Audio2=$_FILES['Audio2']['name'];
            $AudioPath= "AudioFiles/" . $ownerID . "/unit/" . $Audio2;
            if (file_exists($AudioPath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio2,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio2']['tmp_name'],$AudioPath);
                //array_push($voiceLinkNEWVALUES,substr($Audio2,0,-4));;
            }
        }
    }
    if($steps == 5)
    {
        if(isset($_FILES['Audio3']['name']))
        {
            $Audio3=$_FILES['Audio3']['name'];
            $AudioPath= "AudioFiles/" . $ownerID . "/unit/" . $Audio3;
            if (file_exists($AudioPath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio3,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio3']['tmp_name'],$AudioPath);
                //array_push($voiceLinkNEWVALUES,substr($Audio3,0,-4));
            }
        }
    }
    if($steps == 6)
    {
        if(isset($_FILES['Audio4']['name']))
        {
            $Audio4=$_FILES['Audio4']['name'];
            $AudioPath= "AudioFiles/" . $ownerID . "/unit/" . $Audio4;
            if (file_exists($AudioPath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Audio4']['tmp_name'],$AudioPath);
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
        }
    }
    if($steps == 7)
    {
        $voiceLinkARRAYTOSTRING = "[";
        for($km = 0; $km < count($voiceLinkNEWVALUES); $km ++)
        {
            if($km < count($voiceLinkNEWVALUES) - 1)
            {
                $voiceLinkARRAYTOSTRING = $voiceLinkARRAYTOSTRING . $voiceLinkNEWVALUES[$km] . ",";
            }
            else
            {
                $voiceLinkARRAYTOSTRING = $voiceLinkARRAYTOSTRING . $voiceLinkNEWVALUES[$km] . "]";
            }
        }
        
        if(count($voiceLinkNEWVALUES) == 0)
        {
            $voiceLinkARRAYTOSTRING = "[]";
        }
    }
    if($steps == 8)
    {
        //Image
        $photoLinkNEWVALUES = [];
        
        $getIDQueryPhoto = "select photoLink from alldata where ID = $sqlID" ;
        $getIDPhoto = mysqli_fetch_array(mysqli_query($con, $getIDQueryPhoto)) ;
        if (isset($getIDPhoto))
        {
            $oldDatabasePhotoLinks = stringToArray($getIDPhoto['photoLink']);
            $newDatabasePhotoLinks = stringToArray($photoLink);
            if($oldDatabasePhotoLinks != false && $newDatabasePhotoLinks != false)
            {
                for($i22 = 0; $i22 < count($oldDatabasePhotoLinks) ; $i22++)
                {
                    $a1 = false;
                    for($i = 0; $i < count($newDatabasePhotoLinks) ; $i++)
                    {
                        if($oldDatabasePhotoLinks[$i22] == $newDatabasePhotoLinks[$i])
                        {
                            $a1 = true;
                            break;
                        }
                    }
                    if($a1 == false)
                    {
                        if (is_file("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasePhotoLinks[$i22]))
                        {
                            unlink("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasePhotoLinks[$i22]);
                        }
                    }
                } 
            }
            else if($newDatabasePhotoLinks == false && $oldDatabasePhotoLinks != false)
            {
                for($f = 0; $f < count($oldDatabasePhotoLinks) ; $f++)
                {
                    if (is_file("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasePhotoLinks[$f]))
                    {
                        unlink("AudioFiles/" . $ownerID . "/unit/" . $oldDatabasePhotoLinks[$f]);
                    }
                }
            }
        }
        $newDatabasePhotoLinks = stringToArray($photoLink);
        if($newDatabasePhotoLinks != false)
        {
            $photoLinkNEWVALUES = $newDatabasePhotoLinks;
        }
    }
    if($steps == 9)
    {
        if(isset($_FILES['Image0']['name']))
        {
            $Image0=$_FILES['Image0']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image0;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio0,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image0']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio0,0,-4));
            }
        }
    }
    if($steps == 11)
    {
        if(isset($_FILES['Image1']['name']))
        {
            $Image1=$_FILES['Image1']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image1;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio1,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image1']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio1,0,-4));
            }
        }
    }
    if($steps == 12)
    {
        if(isset($_FILES['Image2']['name']))
        {
            $Image2=$_FILES['Image2']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image2;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio2,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image2']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio2,0,-4));;
            }
        }
    }
    if($steps == 13)
    {
        if(isset($_FILES['Image3']['name']))
        {
            $Image3=$_FILES['Image3']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image3;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio3,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image3']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio3,0,-4));
            }
        }
    }
    if($steps == 14)
    {
        if(isset($_FILES['Image4']['name']))
        {
            $Image4=$_FILES['Image4']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image4;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image4']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
        }
    }
    if($steps == 15)
    {
       if(isset($_FILES['Image5']['name']))
        {
            $Image5=$_FILES['Image5']['name'];
            $ImagePath= "AudioFiles/" . $ownerID . "/unit/" . $Image5;
            if (file_exists($ImagePath))
            {
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
            else
            {
                move_uploaded_file($_FILES['Image5']['tmp_name'],$ImagePath);
                //array_push($voiceLinkNEWVALUES,substr($Audio4,0,-4));
            }
        } 
    }
    if($steps == 16)
    {
       $photoLinkARRAYTOSTRING = "[";
        for($km = 0; $km < count($photoLinkNEWVALUES); $km ++)
        {
            if($km < count($photoLinkNEWVALUES) - 1)
            {
                $photoLinkARRAYTOSTRING = "$photoLinkARRAYTOSTRING" . "$photoLinkNEWVALUES[$km]" . ',';
            }
            else
            {
                $photoLinkARRAYTOSTRING = "$photoLinkARRAYTOSTRING" . "$photoLinkNEWVALUES[$km]" . ']';
            }
        }
        
        if(count($photoLinkNEWVALUES) == 0)
        {
            $photoLinkARRAYTOSTRING = "[]";
        } 
    }
    if($steps == 17)
    {
        if (! mysqli_set_charset($con, "utf8"))
        {
           exit() ;
        }
        $getIDQuery1 = "select * from alldata where ID = $sqlID" ;
        $getID1 = mysqli_fetch_array(mysqli_query($con, $getIDQuery1)) ;
        if (isset($getID1))
        {
        	$sqlQuery = "UPDATE alldata SET name = '$name',phone1 = '$phone1',phone2 = '$phone2',work = '$work',
            
            offerType = $offerType,unitArea = $unitArea,garden = $garden,gardenArea = $gardenArea,rooms = $rooms,bathRooms = $bathRooms,furnished = $furnished,rent = $rent,cash = $cash,allOver = $allOver,
            deposit = $deposit,paid = $paid,over = $over,wanted = $wanted,leftAmount = $leftAmount,months = $months,info = '$info',voiceLink = '$voiceLinkARRAYTOSTRING',photoLink = '$photoLinkARRAYTOSTRING',mapLoc = '$mapLoc',
            available = $available WHERE ID = $sqlID";
        	
        	$check = mysqli_query($con, $sqlQuery) ;
        	if (isset($check))
        	{
        	   $getIDQuery3 = "select * from alldata where ID = $sqlID" ;
        	   $getID3 = mysqli_fetch_array(mysqli_query($con, $getIDQuery3)) ;
               if (isset($getID3))
                {
                    //Serversync Update
                    //$uniqueRandomString = generateRandomString();
                    $insertedID = $sqlID;
                    $sqlQueryDate = "SELECT CURRENT_TIMESTAMP()";
                    $sqlQueryDateQuery = mysqli_fetch_array(mysqli_query($con, $sqlQueryDate)); 
                    $insertedDate = $sqlQueryDateQuery[0];
                    $ServerSyncsqlQuery = "INSERT INTO serversync (OWNERID,DATABASENAME,DATAID,OPERATION,DONEBY,DONEBYNAME,DATE) VALUES($ownerID,'alldata',$sqlID,'Update',$WorkerID,'$WorkerNAME','$insertedDate')";
                    $check = mysqli_query($con, $ServerSyncsqlQuery) ;
                    
                    //if($unit == 2)
                    if($getID1['mapLoc'] != $mapLoc)
                    {
                        $updateQueryMapLocForApps = "UPDATE alldata SET mapLoc = '$mapLoc' WHERE ownerID = $ownerID AND unit = 2 AND stage = $stage AND unitGroup = '$unitGroup' AND unitNumber = $unitNumber";
                        $check = mysqli_query($con, $updateQueryMapLocForApps) ;
                    }
                    
                    $returnIs['voiceLink'] = $getID3['voiceLink'];
                    $returnIs['photoLink'] = $getID3['photoLink'];
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