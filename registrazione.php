<?php

require_once 'auth.php';

    if (checkAuth()) {
        header("Location: home.php");
        exit;
    }   

    $_error = array();

if (!empty($_POST["username"]) && !empty($_POST["password"]) && !empty($_POST["email"]) && !empty($_POST["name"]) && 
        !empty($_POST["surname"]) && !empty($_POST["password1"]))
    {

    
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_error($conn));
        $username = mysqli_real_escape_string($conn, $_POST["username"]);
        $query = "SELECT username FROM users WHERE username = '$username'";
        $res = mysqli_query($conn, $query);
        if(mysqli_num_rows($res) > 0){
            $_error[] = "username già utilizzato";
        }
        if(strlen($_POST["password"]) < 8){
            $_error[] = "password troppo corta";
        }
        if(strcmp($_POST["password"], $_POST["password1"]) != 0){
            $_error[] = "le password non coincidono";
        }
        if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            $error[] = "Email non valida";
        } else {
            $email = mysqli_real_escape_string($conn, strtolower($_POST['email']));
            $res = mysqli_query($conn, "SELECT email FROM users WHERE email = '$email'");
            if (mysqli_num_rows($res) > 0) {
                $_error[] = "Email già utilizzata";
            }
        }
    if (count($_error) == 0) {

        $name = mysqli_real_escape_string($conn, $_POST["name"]);
        $surname = mysqli_real_escape_string($conn, $_POST["surname"]);

        $password = mysqli_real_escape_string($conn, $_POST["password"]);
        $password = password_hash($password, PASSWORD_BCRYPT);

        $query = "INSERT INTO users(id, username, password, email, name, surname) VALUES('','$username', '$password', '$email', '$name', '$surname')";
      
        if (mysqli_query($conn, $query)) {
            $_SESSION["username"] = $_POST["username"];
            $_SESSION["id"] = mysqli_insert_id($conn);
            mysqli_close($conn);
            header("Location: home.php");
            exit;
        } else {
            $_error[] = "Errore di connessione al Database";
        }
   }

    mysqli_close($conn);
}
else if (isset($_POST["username"])) {
    $_error = array("Riempi tutti i campi");
}

?>

<html>
    <head>
        <meta charset="utf-8">
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chango&family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
        <link rel='stylesheet' href='./registrazione.css'>
        <script src= './script/registrazione.js' defer></script>
    </head>
    <body>
        <header>
                <nav>
                 <div id='logo'>
                      <img src="./images/icona.png">
                 </div>
                 <div id='links'>
                     <a href="home.php">Home</a>
                     <a href="login.php">Accedi</a>
                 </div>
                 <div id='menu'>
                     <div></div>
                     <div></div>
                 </div>
                </nav>
            </header>
            <main class='main'>
        <section class='signup'>
              <form name='nome_form1' method='post'>
            <h1>Registrati!</h1>
        
            <div class='name'>
            <div class='label'><label>Nome </label></div>
                <div><input type='text' name='name' placeholder='inserisi nome'></div>
                <span>Nome strano</span>
                </div>
                <div class='surname'>
                <div class='label'><label>Cognome </label></div>
                <div><input type='text' name='surname' placeholder='inserisi cognome'></div>
                <span>Cognome strano</span>
                </div>
                <div class='username'>
                <div class='label'><label>Nome utente </label></div>
                <div><input type='text' name='username' placeholder='inserisi nome utente'></div>
                <span>Nome utente non disponibile</span>
                </div>
                <div class='mail'>
                <div class='label'><label>E-mail </label></div>
                <div><input type='text' name='email' placeholder='inserisi mail'></div>
                <span>Indirizzo email non valido</span>
                </div>
                <div class='password'>
                    <div class='label'><label>Password</label></div>
                    <div> <input type='password' name='password' placeholder='inserisi password'></div>
                    <span>Inserisci almeno 8 caratteri</span>
                </div>
                <div class='password1'>
                <div class='label'><label>Conferma password </label></div>
                <div><input type='password' name='password1' placeholder='inserisi password'></div>
                <span>Le password non coincidono</span>
                </div>
                <div>
                    <label>&nbsp;<input input class='submit' type='submit' value='Accedi'></label>
                </div>
            </form>
                <div class='login'> <p class ='verifica'>Già registrato?</p><a class = 'accedi' href='login.php'><em>Accedi</em></a></div>
                </section>
        </main>
        <footer>
            <address>Di Bella Danilo O46002060</address>
            <p>Progetto di Web Programming A.A. 2020/2021</p>
        </footer>
    </body>
</html>