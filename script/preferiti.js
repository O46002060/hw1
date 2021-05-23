
fetch('fetch_preferiti.php').then(onResponse).then(addElement);

function addElement(json){
    const sect = document.createElement('section');
    sect.className = 'container';
    const currentDiv2 = document.getElementById("footer");
    document.body.insertBefore(sect, currentDiv2);

    for (const a of json) {
  
      console.log(a);
  
      const div3 = document.createElement("div");
      div3.className = 'griglia';
      div3.id = json.indexOf(a);
      const span = document.createElement('span1');
      span.id= json.indexOf(a);
      div3.appendChild(span);
      const nome = document.createElement('p');
      nome.textContent = a.nome;
      nome.id= json.indexOf(a);
      const remove = document.createElement("img");
      remove.className = 'remove';
      remove.src = './images/'+'rimuovi.png';
      remove.id= json.indexOf(a);
      remove.addEventListener('click', rimuovi);
      const newIm = document.createElement("img");
      newIm.className = 'chirurgo'; 
      newIm.src = './images/'+ a.image;
      span.appendChild(nome);
      span.appendChild(remove);
      
      div3.appendChild(newIm);
      const currentDiv3 = document.getElementById("p");
      document.body.insertBefore(div3, currentDiv3);
      const t = document.createElement('p');
      t.addEventListener('click', mostra);
      t.textContent = 'Clicca per dettagli';
      t.className = 'vista';
      t.id = json.indexOf(a);
      const t2 = document.createElement('p1');
      t2.textContent = 'email: ' +a.email;
      t2.className = 'hidden';
      t2.id = json.indexOf(a);
      const t4 = document.createElement('p1');
      t4.textContent = 'reparto: ' +a.nomeR;
      t4.className = 'hidden';
      t4.id = json.indexOf(a);
      const t5 = document.createElement('p1');
      t5.textContent = 'ospedale: ' +a.ospedale;
      t5.className = 'hidden';
      t5.id = json.indexOf(a);
      const t6 = document.createElement('p1');
      t6.textContent = 'città: ' +a.citta;
      t6.className = 'hidden';
      t6.id = json.indexOf(a);
      const t7 = document.createElement('p1');
      t7.textContent = 'indirizzo: ' +a.indirizzo;
      t7.className = 'hidden';
      t7.id = json.indexOf(a);
      const t3 = document.createElement('p1');
      t3.textContent = 'Aggiunto il: ' +a.date;
      t3.className = 'hidden';
      t3.id = json.indexOf(a);
      sect.appendChild(div3);
      div3.appendChild(t);
      div3.appendChild(t2);
      div3.appendChild(t4);
      div3.appendChild(t5);
      div3.appendChild(t6);
      div3.appendChild(t7);
      div3.appendChild(t3);
    }
}

function onResponse(response){
    return response.json();
}



function mostra(event) {
	const testo = event.currentTarget;
	
	if (testo.textContent === 'Clicca per dettagli'){
		testo.textContent = 'Nascondi Dettagli';
	} else {
		testo.textContent = 'Clicca per dettagli';
	}

	const ele = document.querySelectorAll('.hidden');
	
	for (const e of ele){
        if (e.id === testo.id){
	e.classList.remove('hidden');
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
			e.classList.add('hidden');
		}
	}
	event.currentTarget.addEventListener('click', mostra);
	event.currentTarget.removeEventListener('click', togli);
}

function rimuovi(event){
//    event.preventDefault();
    const element = event.currentTarget;
    const id = document.getElementById(element.parentNode.parentNode.id);
    console.log(element.id)
    console.log(id)
    
	const ele = document.querySelectorAll('.griglia span1');
    console.log(ele)

	for (const e of ele){
        console.log(e.id)
        console.log(element.id)
        const a = e.parentNode.parentNode;
         console.log(a)
        if (e.id === element.id){
            const nome = e.firstChild.textContent;
           console.log(nome);
         const a = e.parentNode.parentNode;
         console.log(a)
          fetch('fetch_rimuovi.php?nome=' +nome).then(onResponse);  
    }
    window.location.reload((fetch('fetch_preferiti.php').then(onResponse).then(addElement)));
    }
}