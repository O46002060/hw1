<?php

require_once 'auth.php';

if(!checkAuth()) exit;

header('Content-Type: application/json');

search();

function search(){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL,'https://neurovault.org/api/images/');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    
    $data = curl_exec($ch);
    $json = json_decode($data, true);
    curl_close($ch);
    

    echo json_encode($json);
}

?>