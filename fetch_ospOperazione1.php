<?php
require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

$conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);

$userid = mysqli_real_escape_string($conn, $userid);

$res= mysqli_query($conn,"SELECT nomeC, imageC, nome, citta, indirizzo, image, dataInizio, dataFine from lavorava l join chirurgo c on l.chirurgo=c.id_chirurgo join ospedale o on o.id_ospedale=l.ospedale;");

$postArray = array();
while($entry = mysqli_fetch_assoc($res)) {
    $postArray [] = $entry;
}

mysqli_free_result($res);
mysqli_close($conn);

echo json_encode($postArray);

exit;


?>