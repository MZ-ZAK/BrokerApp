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
$LASTUPDATEID = $obj['LASTUPDATEID'] ;
$OWNERID = $obj['OWNERID'] ;
$WorkerID = $obj['WorkerID'] ;

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) ;
if (! mysqli_set_charset($con, "utf8"))
{
   exit() ;
}
$sqlQuery = "select * from serversync where ID > $LASTUPDATEID AND OWNERID = $OWNERID ORDER BY ID ASC" ;
$result = mysqli_query($con, $sqlQuery) ;
$check = mysqli_num_rows($result) ;
if ($check > 0)
{
    $operationsRows = [];
    $DataBaseName = "";
    while ($row = mysqli_fetch_array($result))
    {
        $operationItem = [];
        $ID = $row['DATAID'];
        array_push($operationItem, $ID) ;
        $DataBaseName = $row['DATABASENAME'];
        array_push($operationItem, $DataBaseName) ;
        $OPERATION = $row['OPERATION'];
        array_push($operationItem, $OPERATION) ;
        
        $newLastUpdate = $row['ID'];
        
        $getAllDataRowByID = "select * from $DataBaseName where ID = $ID" ;
        $invokeGetAllData = mysqli_fetch_array(mysqli_query($con, $getAllDataRowByID)) ;
        if (isset($invokeGetAllData))
        {
            array_push($operationItem, $invokeGetAllData) ;
            array_push($operationItem, $newLastUpdate) ;
            
            array_push($operationsRows, $operationItem) ;
        }
        
    }
    $lastUpdateNumber = $operationsRows[count($operationsRows)-1][4];
    $newLastUpdateInWorker = "UPDATE worker SET LASTUPDATEID = $lastUpdateNumber WHERE ID = $WorkerID";
    $resultUpdate = mysqli_query($con, $newLastUpdateInWorker) ;
    
  $SuccessMSG = json_encode($operationsRows) ;
  echo $SuccessMSG ;
}
?>