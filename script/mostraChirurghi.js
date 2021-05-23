function mostraChirurghi(json){

  const sect = document.createElement('section');
  sect.className = 'container';
  const currentDiv2 = document.getElementById("op");
  document.body.insertBefore(sect, currentDiv2);
    
   const content = json;

  for (const a of content) {
    
    contentObj[content.indexOf(a)] = {};
    contentObj[content.indexOf(a)]["id_chirurgo"] = a.id_chirurgo;
    contentObj[content.indexOf(a)]["nomeC"] = a.nomeC;
    contentObj[content.indexOf(a)]["imageC"] = a.imageC;
    contentObj[content.indexOf(a)]["email"] = a.email;
    contentObj[content.indexOf(a)]["nomeR"] = a.nomeR;
    contentObj[content.indexOf(a)]["ospedale"] = a.nome;
    contentObj[content.indexOf(a)]["citta"] = a.citta;
    contentObj[content.indexOf(a)]["indirizzo"] = a.indirizzo;

    console.log(a);

    const div3 = document.createElement("div");
    div3.className = 'griglia';
    div3.id = content.indexOf(a);
    const span = document.createElement('span');
    div3.appendChild(span);
    const chirurgo = document.createElement('a');
    chirurgo.textContent = a.nomeC;
    const add = document.createElement("img");
    add.className = 'aggiungi';
    add.src = './images/'+'aggiungi.png';
    add.addEventListener('click', aggiungi);
    const newIm = document.createElement("img");
    newIm.className = 'chirurgo'; 
    newIm.src = './images/'+ a.imageC;
    span.appendChild(chirurgo);
    span.appendChild(add);
    
    div3.appendChild(newIm);
    const currentDiv3 = document.getElementById("p");
    document.body.insertBefore(div3, currentDiv3);
    const t = document.createElement('p');
    t.addEventListener('click', mostra);
    t.textContent = 'Clicca per dettagli';
    t.className = 'vista';
    t.id = content.indexOf(a);
    const t2 = document.createElement('p1');
    t2.textContent = 'email: ' +a.email;
    t2.className = 'hidden2';
    t2.id = json.indexOf(a);
    const t3 = document.createElement('p2');
    t3.textContent = 'Reparto: ' +a.nomeR;
    t3.className = 'hidden2';
    t3.id = content.indexOf(a);
    const t4 = document.createElement('p1');
    t4.textContent = 'Ospedale: ' +a.nome;
    t4.className = 'hidden2';
    t4.id = content.indexOf(a);
    sect.appendChild(div3);
    div3.appendChild(t);
    div3.appendChild(t2);
    div3.appendChild(t3);
    div3.appendChild(t4);
  }

  

}


function mostra(event) {
	const testo = event.currentTarget;
	
	if (testo.textContent === 'Clicca per dettagli'){
		testo.textContent = 'Nascondi Dettagli';
	} else {
		testo.textContent = 'Clicca per dettagli';
	}

	const ele = document.querySelectorAll('.hidden2');
	
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
	
	if (testo.textContent === 'Clicca per dettagli'){
		testo.textContent = 'Nascondi Dettagli';
	} else {
		testo.textContent = 'Clicca per dettagli';
	}

	const elem = document.querySelectorAll('.mostra');
	
	for (const e of elem){
		if (e.id === testo.id){
			e.classList.remove('mostra');
			e.classList.add('hidden2');
		}
	}
	event.currentTarget.addEventListener('click', mostra);
	event.currentTarget.removeEventListener('click', togli);
}


let contentObj ={};



function aggiungi(event){
	const element = event.currentTarget;
  element.removeEventListener('click', aggiungi);
  console.log(contentObj)
	const id = document.getElementById(element.parentNode.parentNode.id);
  id1= id.id;
  console.log(id)
  console.log(contentObj[id.id])
  fetch('aggiungi_preferiti.php?id=' +id+ '&id_chirurgo=' +contentObj[id1].id_chirurgo+ '&nomeC=' +contentObj[id1].nomeC+ '&email=' +contentObj[id1].email+ '&imageC=' +contentObj[id1].imageC+ '&nomeR=' +contentObj[id1].nomeR+ '&nome=' +contentObj[id1].ospedale+ '&citta=' +contentObj[id1].citta+ '&indirizzo=' +contentObj[id1].indirizzo).then(onResponse);
  avvisa();
}


function avvisa() {
  const span = document.createElement('span');
  aggiunto.appendChild(span);
  const testo = document.createElement('h1');
	testo.textContent = 'Aggiunto in rubrica';
  const testo2 = document.createElement('p');
	testo2.textContent = 'Premi ESC per rimuovere avviso';
	span.appendChild(testo);
  span.appendChild(testo2);
	aggiunto.classList.remove('hidden');
	document.body.classList.add('no-scroll');
}


function chiudi(event) {
	console.log(event);
	if(event.key === 'Escape')
	{
		aggiunto.classList.add('hidden');
		testo = aggiunto.querySelector('h1');
		testo.remove();
    testo2 = aggiunto.querySelector('p');
		testo2.remove();
		document.body.classList.remove('no-scroll');
	}
}

window.addEventListener('keydown', chiudi);


function onResponse(response){
    return response.json();
}

fetch('fetch_chirurghi.php').then(onResponse).then(mostraChirurghi);




const input = document.querySelector(".elementi input");
console.log(input)
input.addEventListener('keyup', ricerca);

function ricerca(event){

  const input = document.querySelector('.elementi input').value.toUpperCase();
  const cont = document.querySelectorAll('.container p2')

  for(const c of cont){
    const t = c.textContent.toUpperCase();
    for(let i=0; i<t.length; i++){
      if(t.includes(input)){
   
      c.parentNode.classList.add('griglia')
      c.parentNode.classList.remove('hidden');
    }else{
      c.parentNode.classList.remove('griglia');
      c.parentNode.classList.add('hidden')
    }
    }
  }
}




const em = document.querySelector('.descrizione em');
em.addEventListener('click', search);


function search(event){
  event.preventDefault();
  fetch('neuro.php').then(onResponse).then(onJson);
  const a = event.currentTarget;
  const b = document.querySelector('form .submit1')
  console.log(b)
  b.classList.remove('submit1')
  b.classList.add('submit')

  b.addEventListener('submit', tornaIndietro);
}

function tornaIndietro(event){
  event.preventDefault();
  const a = document.querySelector('#album-view')
  a.innerHTML='';
  const b = event.currentTarget;
  b.classList.remove('submit')
  b.classList.add('submit1');
  const c = document.querySelector('form')
  c.classList.remove('submit1')
  c.classList.add('submit')
}

function onJson(json) {
  console.log('JSON ricevuto');
  console.log(json);
  const library = document.querySelector('#album-view');
  library.innerHTML = '';
  let res = json.count;
  console.log(res);
  if(res > 50) res=30;
  for(let i=0;i<res;i++){
      const doc = json.results[i]
      console.log(doc)
      const title = doc.name;
      const img_url = doc.thumbnail;
      const t = document.createElement('div')
      t.classList.add('mostra');
      const img = document.createElement('img');
      img.src = img_url; 
      img.addEventListener('click', apriModale);
      const y = document.createElement('span');
      y.textContent = title;
      t.appendChild(y)
      t.appendChild(img);
      library.appendChild(t)
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

window.addEventListener('keydown', chiudiModale);

const op1 = document.querySelector('.op1 p');
op1.addEventListener('click', operazione1);


function operazione1(event){
  fetch('fetch_operazione1.php').then(onResponse).then(ope1);
  event.currentTarget.removeEventListener('click', operazione1);
}

function ope1(json){
  const sect = document.createElement('section');
  sect.className = 'opera1';
  const currentDiv2 = document.getElementById("footer");
  document.body.insertBefore(sect, currentDiv2);

 
  for(const op of json){
    const div3 = document.createElement("div");
    div3.className = 'pazienti';
    div3.id = json.indexOf(op);
    sect.appendChild(div3);
    const span= document.createElement('span');
    const p= document.createElement('p');
    p.textContent='Paziente: ';
    span.appendChild(p)
    const paziente= document.createElement('h1');
    paziente.textContent= op.nomeP;
    const span1= document.createElement('span');
    const p1= document.createElement('p');
    p1.textContent='Chirurgo: ';
    span1.appendChild(p1)
    const ch = document.createElement('h1');
    ch.textContent = op.nomeC;
    const span2= document.createElement('span');
    const p2= document.createElement('p');
    p2.textContent='Operazione: ';
    span2.appendChild(p2)
    const opera = document.createElement('h1');
    opera.textContent= op.data_operazione;
    const span3= document.createElement('span');
    const p3= document.createElement('p');
    p3.textContent='Sala operatoria: ';
    span3.appendChild(p3)
    const sala = document.createElement('h1');
    sala.textContent= op.sala_operatoria;
    const span4= document.createElement('span');
    const p4= document.createElement('p');
    p4.textContent='Reparto: ';
    span4.appendChild(p4)
    const rep = document.createElement('h1');
    rep.textContent= op.nomeR;
    div3.appendChild(span);
    div3.appendChild(span1);
    div3.appendChild(span2);
    div3.appendChild(span3);
    div3.appendChild(span4);
    span.appendChild(paziente);
    span1.appendChild(ch);
    span2.appendChild(opera);
    span3.appendChild(sala);
    span4.appendChild(rep);
  }

}

