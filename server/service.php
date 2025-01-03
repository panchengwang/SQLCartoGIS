<?php

include_once("./dbconfig.php");
include_once("./UserServer.php");
function makeResponseAndExit($success, $message)
{
    echo json_encode(array(
        "success" => $success,
        "message" => $message
    ));
    exit(0);
}

header('Content-type: text/plain');

// 检查客户端是否发送过来request参数 
if (!isset($_REQUEST['request'])) {
    makeResponseAndExit(false, "No request parameters");
}

// 如果传过来的请求参数不符合json标准，返回错误信息
$request = @json_decode($_REQUEST['request']);
if (!$request) {
    makeResponseAndExit(false, 'Invalid json string for request');
}

// 请求参数中没有 type
if (!isset($request->type)) {
    makeResponseAndExit(false, 'No request type');
}

$reqgrp = explode("_", $request->type)[0];
$sv = new Server();
if ($reqgrp === "USER") {
    $sv = new UserServer();
} else {
    makeResponseAndExit(false, "Invalid request type: {$request->type}");
}

$sv->setRequest($request);
$sv->run();
echo json_encode($sv->getResponse());

// $dbconn = @pg_connect("host=" . HOST . " port=" . PORT . " dbname=" . DBNAME . " user=" . USERNAME . " password=" . PASSWORD);
// if (!$dbconn) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => @pg_last_error()
//     ));
//     exit();
// }


// $result = @pg_query_params($dbconn, "select sc_service_run($1)", array(
//     $_REQUEST['request']
// ));

// if (!$result) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => @pg_last_error()
//     ));
//     exit(0);
// }
// $row = @pg_fetch_row($result);
// $response = $row[0];

// pg_free_result($result);
// pg_close($dbconn);


// echo $response;