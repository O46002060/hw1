<?php
require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);

    $userid = mysqli_real_escape_string($conn, $userid);
    $query = mysqli_query($conn, " SELECT nomeC, email, imageC, nomeR, nome FROM chirurgo c, lavora l, ospedale o, reparto r WHERE l.chirurgo=c.id_chirurgo 
    AND l.ospedale= o.id_ospedale AND c.id_chirurgo=r.chirurgo");

    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));

    $postArray = array();

    while($entry = mysqli_fetch_assoc($res)){
        $postArray [] = $entry;
    }

    mysqli_free_result($res);
    echo json_encode($postArray);
    
    exit;

?>