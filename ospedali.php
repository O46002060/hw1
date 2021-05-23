<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
        <title>Ospedali</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Chango&family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
        <link rel='stylesheet' href='./ospedale.css'>
        <script src= './script/mostraOspedali.js' defer></script>
</head>
<body>
<header>
                <nav>
                 <div id='logo'>
                 <h1>Ospedali</h1>
                 </div>
                 <div id='links'>
                     <a href='home.php'>Home</a>
                     <a href='chirurghi.php'>Chirurgo</a>
                     <a href='logout.php'>Logout</a>
                 </div>
                 <div id='menu'>
                     <div></div>
                     <div></div>
                     <div></div>
                 </div>
                </nav>
            </header>
            <article id="modale" class="hidden"> 
            
            </article>

            <section class='elementi'><h1>Lista Ospedali</h1>
        <p>Cerca: <input type="text" id='cerca' onekeyup='ricerca()' placeholder="ospedale o città"></p>
    </section> 
            <section class='operazioni' id='op'><h1>Alcune informazioni sugli ospedali</h1>
    <div>
    <ul class='elenco'>
    <li class='op1'><p>Chirurghi che hanno cambiato sede</p></li>
    </ul>
</section> 
            <footer id='footer'>
            <address>Di Bella Danilo O46002060</address>
            <p>Progetto di Web Programming A.A. 2020/2021</p>
        </footer>
</body>
</html>
