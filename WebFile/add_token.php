//
//  add_token.php
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

<?php

include 'db_config.php';

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

mysqli_set_charset($con, 'utf8');

$json = file_get_contents('php://input');

// Converts it into a PHP object
$data = json_decode($json);

$token = $data->token;
$debug = $data->debug;

$token = mysqli_real_escape_string($con, $token);
$debug = mysqli_real_escape_string($con, $debug);




$Sql_Query = "INSERT INTO token (token, debug) values ('$token','$debug')";

if (mysqli_query($con, $Sql_Query)) {
    echo $token;
} else {
    echo 'Something went wrong';
}
mysqli_close($con);


?>
