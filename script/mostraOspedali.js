function mostraOspedali(json){

  const sect = document.createElement('section');
  sect.className = 'container';
  const currentDiv2 = document.getElementById("op");
  document.body.insertBefore(sect, currentDiv2);
    
  for (const o of json) {

    const div = document.createElement('div');
    div.className = 'lista';
    const span = document.createElement('span');
    const nome = document.createElement('p');
    nome.textContent = o.nome;
    nome.id = json.indexOf(o);
    nome.className= 'nome';
    const citta = document.createElement('p');
    citta.textContent = "Città: " + o.citta;
    const indirizzo = document.createElement('p');
    indirizzo.textContent = "Indirizzo: " + o.indirizzo;
    const img = document.createElement('img');
    img.src = './images/' + o.image;
    img.addEventListener('click', apriModale);
    sect.appendChild(div);
    div.appendChild(span);
    span.appendChild(nome);
    span.appendChild(citta);
    span.appendChild(indirizzo);
    div.appendChild(img);
    const t = document.createElement('p');
    t.addEventListener('click', mostra);
    t.textContent = 'Mostra altro';
    t.className = 'vista';
    t.id = json.indexOf(o)
    t.addEventListener('click', mostra);
    const chirurgo = document.createElement('p');
    chirurgo.textContent = 'Chirurgo: ' +o.nomeC;
    chirurgo.className = 'hidden2';
    chirurgo.id = json.indexOf(o);
    const reparto= document.createElement('p');
    reparto.textContent = 'Reparto: ' +o.nomeR;
    reparto.className = 'hidden2';
    reparto.id = json.indexOf(o);
    div.appendChild(t);
    div.appendChild(chirurgo);
    div.appendChild(reparto);
  }
}


function onResponse(response){
    return response.json();
}

fetch('fetch_ospedale.php').then(onResponse).then(mostraOspedali);

const input = document.querySelector("input");
input.addEventListener('keyup', ricerca);

function ricerca(event){
    const input = document.querySelector('input').value.toUpperCase();
    const cont = document.querySelectorAll('.container span')
    for(const c of cont){
      const t = c.textContent.toUpperCase();
      for(let i=0; i<t.length; i++){
        if(t.includes(input)){
          
        c.parentNode.classList.add('lista')
        c.parentNode.classList.remove('hidden');
      }else{
        c.parentNode.classList.remove('lista');
        c.parentNode.classList.add('hidden')
      }
      }
    }
  }

  function mostra(event) {
    const testo = event.currentTarget;
    const ele = document.querySelectorAll('.hidden2');

    if (testo.textContent === 'Mostra altro'){
      testo.textContent = 'Mostra meno';
    } else {
      testo.textContent = 'Mostra altro';
    }
    for (const e of ele){
      if (e.id === testo.id){
   e.classList.remove('hidden2');
   e.classList.add('mostra');
  }
}

event.currentTarget.addEventListener('click', togli);
event.currentTarget.removeEventListener('click', mostra);
  }
  
  function togli(event) {
    const testo = event.currentTarget;
  
    const elem = document.querySelectorAll('.mostra');

    if (testo.textContent === 'Mostra meno'){
		testo.textContent = 'Mostra altro';
	} 

  for (const e of elem){
		if (e.id === testo.id){
			e.classList.remove('mostra');
			e.classList.add('hidden2');
		}
	}
	event.currentTarget.addEventListener('click', mostra);
	event.currentTarget.removeEventListener('click', togli);
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


window.addEventListener('keydown', chiudiModale);



const op1 = document.querySelector('.op1 p');
op1.addEventListener('click', operazione1);


function operazione1(event){
  fetch('fetch_ospOperazione1.php').then(onResponse).then(ope1);
  event.currentTarget.removeEventListener('click', operazione1);
}

function ope1(json){
  const sect = document.createElement('section');
  sect.className = 'opera1';
  const currentDiv2 = document.getElementById("footer");
  document.body.insertBefore(sect, currentDiv2);

 
  for(const op of json){
    const div3 = document.createElement("div");
    div3.className = 'oper1';
    div3.id = json.indexOf(op);
    sect.appendChild(div3);
    const span= document.createElement('span');
    const ch= document.createElement('h1');
    ch.textContent= op.nomeC;
    const img1= document.createElement('img');
    img1.src= './images/' +op.imageC;
    const span1= document.createElement('span');
    const os = document.createElement('h1');
    os.textContent = op.nome;
    const citta = document.createElement('h1');
    citta.textContent = 'Città: ' +op.citta;
    const img2 = document.createElement('img');
    img2.src = './images/' +op.image;
    const d1 = document.createElement('p');
    d1.textContent = 'Inizio:' + op.dataInizio;
    const d2 = document.createElement('p');
    d2.textContent = 'Fine:' + op.dataFine;
    div3.appendChild(span);
    div3.appendChild(span1);
    span.appendChild(ch);
    span.appendChild(img1);
    span1.appendChild(os);
    div3.appendChild(citta);
    span1.appendChild(img2);
    div3.appendChild(d1);
    div3.appendChild(d2);
  }

}

