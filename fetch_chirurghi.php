<?php
require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

$conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);

$userid = mysqli_real_escape_string($conn, $userid);
$res = mysqli_query($conn, " SELECT id_chirurgo,nomeC, email, imageC, nomeR, nome, citta, indirizzo FROM chirurgo c, lavora l, ospedale o, reparto r WHERE l.chirurgo=c.id_chirurgo AND l.ospedale= o.id_ospedale AND c.id_chirurgo=r.chirurgo");

$postArray = array();
while($entry = mysqli_fetch_assoc($res)) {
    $postArray [] = $entry;
}

mysqli_free_result($res);
mysqli_close($conn);

echo json_encode($postArray);

exit;

?>