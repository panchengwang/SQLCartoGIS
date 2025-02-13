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

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
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

