<?php

include_once("./dbconfig.php");


// check 
if (!isset($_REQUEST['request'])) {
    header('Content-type: text/json');
    echo json_encode(array(
        "success" => false,
        "message" => "No request parameter"
    ));
    exit(0);
}

$request = json_decode($_REQUEST['request']);
// if ($request->type == 'USER_CREATE') {
//     // }else if($request->type == 'USER_LOGIN'){
// // }else if($request->type == 'USER_LOGOUT'){
// // }else if($request->type == 'USER_RESET_PASSWORD'){
// }



$dbconn = @pg_connect("host=" . HOST . " port=" . PORT . " dbname=" . DBNAME . " user=" . USERNAME . " password=" . PASSWORD);
if (!$dbconn) {
    echo json_encode(array(
        "success" => false,
        "message" => @pg_last_error()
    ));
    exit();
}


$result = @pg_query_params($dbconn, "select sc_service_run($1)", array(
    $_REQUEST['request']
));

if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => @pg_last_error()
    ));
    exit(0);
}
$row = @pg_fetch_row($result);
$response = $row[0];

pg_free_result($result);
pg_close($dbconn);


echo $response;


