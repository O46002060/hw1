<?php

require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);
   
    $userid = mysqli_real_escape_string($conn, $userid);
  
    $query= "DELETE FROM preferiti WHERE nome= '".$_GET['nome']."'";

    $res = mysqli_query($conn, $query);
     
    $postArray = array();
  
    while($entry = mysqli_fetch_assoc($res)) {
    $postArray [] = $entry;
     } 
     
     mysqli_free_result($res);
     mysqli_close($conn);
     
     echo json_encode($postArray);
     
     exit;
     ?>