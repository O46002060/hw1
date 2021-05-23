<?php

require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);
   
    $userid = mysqli_real_escape_string($conn, $userid);

    $date = date("Y-m-d");

    $query= "INSERT INTO preferiti(id, utente, chirurgo, nome, email, image, nomeR, ospedale, citta, indirizzo, date) VALUES('".$_GET['id']."','".$userid."', '".$_GET['id_chirurgo']."', '".$_GET['nomeC']."', '".$_GET['email']."', '".$_GET['imageC']."', '".$_GET['nomeR']."', '".$_GET['nome']."', '".$_GET['citta']."', '".$_GET['indirizzo']."','".$date."')";
    $res = mysqli_query($conn, $query);
    mysqli_free_result($res);

    mysqli_close($conn);
    exit;

?>