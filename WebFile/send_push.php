//
//  send_push.php
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

<?php

include 'db_config.php';

define('AUTH_KEY_PATH', '<your .p8 key>');
define('AUTH_KEY_ID', '<key id>');
define('TEAM_ID', '<team id>');
define('BUNDLE_ID', 'snnafi.PushNotificationExample');

$payload = [
    'notification' => [
        'title' => 'Forest Trees',
        'image' => 'https://images.pexels.com/photos/957024/forest-trees-perspective-bright-957024.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        ],
    'background' => [
        'title' => 'Sea Boat',
        'image' => 'https://images.pexels.com/photos/2249602/pexels-photo-2249602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        ],
  'aps' => [
    'alert' => [
      'title' => 'Hellp',
       'body' => 'iOS Push Notification',
    ],
    'category' => 'proposal',
    'sound'=> 'default',
  ],
];


function generateAuthenticationHeader()
{
 
  $header = base64_encode(json_encode([
                 'alg' => 'ES256',
                 'kid' => AUTH_KEY_ID
            ]));
            
  
  $claims = base64_encode(json_encode([
                 'iss' => TEAM_ID,
                 'iat' => time()
            ]));

  
  $fp = fopen(AUTH_KEY_PATH, "r");
  $privKey = fread($fp, 8192);
  fclose($fp);
  $pkey = openssl_get_privatekey($privKey);
  openssl_sign("$header.$claims", $signature, $pkey, 'sha256');

  
  $signed = base64_encode($signature);
  
 
  return "$header.$claims.$signed";
}


function sendNotification($debug, $token) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($GLOBALS['payload']));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'apns-topic: ' . BUNDLE_ID,
        'authorization: bearer ' . generateAuthenticationHeader(),
    'apns-push-type: background'
    ]);
    $server = $debug ? 'api.development' : 'api';
   

    
        
        $url = "https://$server.push.apple.com/3/device/$token";
        curl_setopt($ch, CURLOPT_URL, "{$url}");
        
       
        $response = curl_exec($ch);
        
        if ($response === false) {
            echo("curl_exec failed: " . curl_error($ch));
            return;
        }
        
        
        $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        if ($code === 400 || $code === 410) {
            $json = @json_decode($response);
            echo 'Reason: ' . $json->reason . "<br>";
            if ($json->reason === 'BadDeviceToken') {
             //  echo 'BadDeviceToken';
            }
        }
    
    
    curl_close($ch);
}


$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

mysqli_set_charset($con, 'utf8');


$Sql_Query = "SELECT DISTINCT token  FROM token where debug = 1";

$result = $con->query($Sql_Query);

if ($result->num_rows >0) {

    while($row = $result->fetch_assoc()) {
        echo "For Token: " . $row['token']."<br>";
        sendNotification(true, $row['token']);
        
    }
} else {
    echo "No Results Found.";
}
  
mysqli_close($con);

?>




