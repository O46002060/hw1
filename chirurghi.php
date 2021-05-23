<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Chirurghi</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel='stylesheet' href='./chirurgo.css'>
        <script src='./script/mostraChirurghi.js' defer></script>
    </head>
<body>
  
    <header>
        <nav>
            <h1>Chirurghi</h1>
         <div id='links'>
             <a href='home.php'>Home</a>
             <a href='ospedali.php'>Ospedale</a>
             <a href='rubrica.php'>Rubrica</a>
             <a href='logout.php'>Logout</a>
         </div>
         <div id='menu'>
             <div></div>
             <div></div>
             <div></div>
         </div>
        </nav>
        </header>
        <section class='descrizione'>
            <p>Lista dei chirurghi registrati nel sito, dove è possibile aggiungere ai preferiti per avere un contatto.<br>
               Tra i reparti di appartenenza abbiamo <em>Neurochirurgia</em>, Otorinolaringoiatria, Cardiologia e Ortopedia.</p>
            <p10>Cliccando su Neurochirurgia sarà possibile visualizzare atlanti di mappe caricati su Neurovault</p10>
           <form><input class="submit1" type='submit' value="nascondi atlante"></form><br>
           <article id="album-view">
			
            </article>
            <article id="modale" class="hidden"> 
		
            </article>
        </section>
        <article id="aggiunto" class="hidden"> 
		
            </article>
    <section class='elementi' id='el'><h1>Lista chirurghi</h1>
        <p>Cerca: <input type="text" id='cerca' placeholder="reparto"></p>
    </section> 
    <section class='operazioni' id='op'><h1>Alcune informazioni sui nostri chirurghi</h1>
    <div>
    <ul class='elenco'>
    <li class='op1'><p>Elenco dei pazienti ricoverati</p></li>
    </ul>
</section>
    <footer id='footer'>
            <address>Di Bella Danilo O46002060</address>
            <p>Progetto di Web Programming A.A. 2020/2021</p>
        </footer>
</body>
</html>
