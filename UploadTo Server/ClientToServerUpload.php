<?php
$HostName = "localhost" ;
$DatabaseName = "0" ;
$HostUser = "0" ;
$HostPass = "0" ;

// Getting the received JSON into $json variable.
//$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;

$OWNERID;
if(isset($_POST['OWNERID']))
{
    $OWNERID = $_POST['OWNERID'];
}

$SECTION;
if(isset($_POST['SECTION']))
{
    $SECTION = $_POST['SECTION'];
}

if(isset($_FILES['Audio0']['name']))
{
    $Audio0=$_FILES['Audio0']['name'];
    
    $videoPath= "AudioFiles/" . $OWNERID . "/" . $SECTION . "/" . $Audio0;
    move_uploaded_file($_FILES['Audio0']['tmp_name'],$videoPath);
}

if(isset($_FILES['Audio1']['name']))
{
    $Audio1=$_FILES['Audio1']['name'];
    $videoPath= "AudioFiles/" . $OWNERID . "/" . $SECTION . "/" . $Audio1;
    move_uploaded_file($_FILES['Audio1']['tmp_name'],$videoPath);
}

if(isset($_FILES['Audio2']['name']))
{
    $Audio2=$_FILES['Audio2']['name'];
    $videoPath= "AudioFiles/" . $OWNERID . "/" . $SECTION . "/" . $Audio2;
    move_uploaded_file($_FILES['Audio2']['tmp_name'],$videoPath);
}

if(isset($_FILES['Audio3']['name']))
{
    $Audio3=$_FILES['Audio3']['name'];
    $videoPath= "AudioFiles/" . $OWNERID . "/" . $SECTION . "/" . $Audio3;
    move_uploaded_file($_FILES['Audio3']['tmp_name'],$videoPath);
}

if(isset($_FILES['Audio4']['name']))
{
    $Audio4=$_FILES['Audio4']['name'];
    $videoPath= "AudioFiles/" . $OWNERID . "/" . $SECTION . "/" . $Audio4;
    move_uploaded_file($_FILES['Audio4']['tmp_name'],$videoPath);
}



?>