<?php
    include 'auth.php';
    if (checkAuth()) {
        header('Location: home.php');
        exit;
    }
  $_error = array();

  if (!empty($_POST["username"]) && !empty($_POST["password"]) )
    {

   
     $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_error($conn));
        $username = mysqli_real_escape_string($conn, $_POST["username"]);
        $password = mysqli_real_escape_string($conn, $_POST["password"]);
        $searchField = filter_var($username, FILTER_VALIDATE_EMAIL) ? "email" : "username";
        $query = "SELECT id, username, password FROM users WHERE $searchField = '$username'";
        $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
        if (mysqli_num_rows($res) > 0) {
         
            $entry = mysqli_fetch_assoc($res);

            if (password_verify($_POST["password"], $entry["password"])) {
            
                $_SESSION["username"] = $entry['username'];
                $_SESSION["id"] = $entry['id'];
                header("Location: home.php");
                mysqli_free_result($res);
                mysqli_close($conn);
                exit;
            }else{
                $_error[] = "Password errata.";
            }
        }
   
        $_error[] = "Username errato.";
    }
    else if (isset($_POST["username"]) || isset($_POST["password"])) {
     
        $error = "Inserisci username e password.";
    }

    
?>

<html>
    <head>
        <meta charset="utf-8">
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chango&family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
        <link rel='stylesheet' href='./login.css'>
        <script src='./script/login.js' defer></script>
    </head>
    <body>
        <header>
                <nav>
                 <div id='logo'>
                      <img src="./images/icona.png">
                 </div>
                 <div id='links'>
                     <a href="homePage.php">Home</a>
                     <a href="login.php">Accedi</a>
                 </div>
                 <div id='menu'>
                     <div></div>
                     <div></div>
                 </div>
                </nav>
            </header>
        <main class='main'>
        <section class='login'>
        <h1>Accedi al tuo account!</h1>
            <form name='login' method='post'>
            <?php
        if($_error){
            echo "<p class ='errore'>";
            echo "<h4>".$_error[0]."</h4>";
            echo "</p>";
        }
        ?>
                <div class='username'>
                <div class='label'><label>Utente </label></div>
                <div><input type='text' name='username' placeholder='inserisi nome utente'></div>
                </div>
                <div class='password'>
                    <div class='label'><label>Password</label></div>
                    <div> <input type='password' name='password' placeholder='inserisi password'></div>
                </div>
                <div>
                    <label>&nbsp;<input input class='submit' type='submit' value='Accedi'></label>
                </div>
            </form>
            <div class='registrati'><p class='verifica'>Non hai un account?</p><a class = 'registra' href='registrazione.php'><em>Registrati</em></a></div>
            </section>
        </main>
        <footer>
            <address>Di Bella Danilo O46002060</address>
            <p>Progetto di Web Programming A.A. 2020/2021</p>
        </footer>
    </body>
</html>