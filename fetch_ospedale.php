<?php
require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

$conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);

$userid = mysqli_real_escape_string($conn, $userid);

$res= mysqli_query($conn,"SELECT nome, citta, indirizzo, image, nomeC, nomeR from ospedale o, lavora l, chirurgo c, reparto r where o.id_ospedale=l.ospedale and l.chirurgo=c.id_chirurgo and c.id_chirurgo=r.chirurgo");
$postArray = array();
while($entry = mysqli_fetch_assoc($res)) {
    $postArray [] = $entry;
}

mysqli_free_result($res);
mysqli_close($conn);
echo json_encode($postArray);

exit;

?>
