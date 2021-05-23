//API
const form = document.querySelector('form');
form.addEventListener('submit', search)


function search(event){
    event.preventDefault();
    const scrivo = document.querySelector('#content').value;
    if(scrivo){
      const text = encodeURIComponent(scrivo);
          console.log('Eseguo ricerca elementi riguardanti: ' + text);
      fetch("API.php?q=" +text).then(onResponse).then(onJson_img);
     } else {
    alert("Inserisci il testo per cui effettuare la ricerca");

  }
}

  function onJson_img(json) {
    console.log('JSON Img ricevuto');
    console.log(json);
    const library = document.querySelector('#album-view');
    library.innerHTML = '';
    let results = json.totalHits;
    if(results == 0)
    {
      const errore = document.createElement("h1"); 
      const messaggio = document.createTextNode("Nessun risultato!"); 
      errore.appendChild(messaggio); 
      library.appendChild(errore);
    }
    if(results> 20)
    results=15;
    for(let i=0;i<results;i++){
    {
      const doc = json.hits[i]
      console.log(doc)
        const immagine = doc.webformatURL;
  
       const album = document.createElement('div');
      album.classList.add('album');
      const img = document.createElement('img');
      img.src = immagine;
      
      img.addEventListener('click', apriModale);
      album.appendChild(img);
      library.appendChild(album);
    }
  }
  }

  function apriModale(event) {
	const image = document.createElement('img');
	image.id = 'immagine_post';
	image.src = event.currentTarget.src;
	modale.appendChild(image);
	modale.classList.remove('hidden');
	document.body.classList.add('no-scroll');
}


function chiudiModale(event) {
	console.log(event);
	if(event.key === 'Escape')
	{
		modale.classList.add('hidden');
		img = modale.querySelector('img');
		img.remove();
		document.body.classList.remove('no-scroll');
	}
}

function onResponse(response) {
    console.log('Risposta ricevuta');
    return response.json();
  }

  window.addEventListener('keydown', chiudiModale);