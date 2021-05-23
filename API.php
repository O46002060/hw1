<?php

require_once 'auth.php';

if(!checkAuth()) exit;

header('Content-Type: application/json');

search();

function search(){
    $apikey = '21266017-28ab85e2d83e8ca9d22a76cf0';
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL,'https://pixabay.com/api/?key='.$apikey.'&q='.$_GET["q"]. '&category=health');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    
    $data = curl_exec($ch);
    $json = json_decode($data, true);
    curl_close($ch);
    

    echo json_encode($json);
}

?>