<?php
session_start();
if(!isset($_SESSION["username"]))
{
    header("Location: login.php");
    exit;
}
?>

<html>
    <head>
    <meta charset="utf-8">
        <title>mhw1</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chango&family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
        <link rel='stylesheet' href='./home.css'>
        <script src="./script/home.js" defer="true"></script>
</head>
<body>
<header>
                <nav>
                 <div id='logo'>
                 <h1>Benvenuto <?php echo $_SESSION["username"]; ?>!</h1>
                 </div>
                 <div id='links'>
                     <a href='home.php'>Home</a>
                     <a href='chirurghi.php'>Chirurgo</a>
                     <a href='ospedali.php'>Ospedale</a>
                     <a href='rubrica.php'>Rubrica</a>
                     <a href='logout.php'>Logout</a>
                 </div>
                 <div id='menu'>
                     <div></div>
                     <div></div>
                     <div></div>
                     <div></div>
                 </div>
                </nav>
                <div id='overlay'></div>
                <h1>Surgeon's site</h1>
            </header>
    <section>
                <div id='main'>
                    <h1> Sito che dà informazioni su chirurghi.</h1>
                    <p>Qui potrai avere informazioni riguardo alcuni chirurghi di diverse zone d'Italia e non solo</br>
                    In particolare:</p>
               <ul>
                   <li><span class='elenco'>elenco dei <a>chirurghi</a> presenti nel sito</span></li>
                   <li><span class='elenco'>elenco degli <a>ospedali</a> dove lavorano i chirurghi</span></li>
                   <li><span class='elenco'>Potrai trovare <a>immagini</a> aderenti alla salute/cura</span></li>
               </ul>
               
                <div id='image'>
                    <h2>Chirurghi</h2>
                    <div id='chirurgo'>
                        <img src='./images/img1.png'>
                        <p>In questa sezione sarà possibile visualizzare l'elenco dei <b> chirurghi </b> registrati nel sito,</br>
                           con i rispettivi reparti di appartenenza.</br>
                            <br><a href='chirurghi.php'> CHIRURGHI </a></p>
                    </div>
                    <h2>Ospedale</h2>
                    <div id='ospedale'>
                        <img src="./images/img2.png"> <p>In questa sezione sarà possibile visualizzare l'elenco degli <b> ospedali </b> presenti nel database,
                        con i relativi chirurghi in cui hanno e lavorano in quell'ospedale.</br>
                        <br><a href='ospedali.php'> OSPEDALI </a></p>
                    </div>
                
                
                <h2>Immagini da vedere</h2>
                <div class='immagini'>
                    <p>Ricerca di immagini aderenti alla salute/cura.</p>
                </div>
                <form>
                    <label>Categoria: <input type='text' name = 'content' id ='content' placeholder="Inserisci una categoria"></label>
                <input class="submit" type='submit' value='Cerca'>
                </form>
                
                <article id="album-view">
			
                </article>
                <article id="modale" class="hidden"> 
                
                </article>
                </div>
            </div>
            </section>
            <footer>
            <address>Di Bella Danilo O46002060</address>
            <p>Progetto di Web Programming A.A. 2020/2021</p>
        </footer>
</body>
</html>
