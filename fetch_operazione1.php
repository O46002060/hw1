<?php
require_once 'auth.php';
if (!$userid = checkAuth()) exit;

header('Content-Type: application/json');

$conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']);

$userid = mysqli_real_escape_string($conn, $userid);

$res= mysqli_query($conn,"SELECT p.nomeP, ch.nomeC, o.data_operazione, o.sala_operatoria, r.nomeR FROM paziente p, camera c, opera o, chirurgo ch, reparto r where p.id_paziente = c.paziente and o.chirurgo=ch.id_chirurgo and ch.id_chirurgo=r.chirurgo and o.chirurgo in(SELECT o.chirurgo from opera o where o.paziente = p.id_paziente) group by nomeP");

$postArray = array();
while($entry = mysqli_fetch_assoc($res)) {
    $postArray [] = $entry;
}

mysqli_free_result($res);
mysqli_close($conn);

echo json_encode($postArray);

exit;


?>