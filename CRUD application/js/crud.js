window.addEventListener("load",init)

var niz_clanova = []

var prvi_clan = {
    "id" : "1203",
    "ime_prezime" : "Nevena Pesic",
    "godina_rodjenja" : 2003,
    "email" : "nevena.pesic2003@gmail.com",
    "vrsta_clana" : "regularan",
    "clanarina" : 3000

}
var drugi_clan = {
    "id" : "0412",
    "ime_prezime" : "Filip Milutinovic",
    "godina_rodjenja" : 2003,
    "email" : "filip.m2003@gmail.com",
    "vrsta_clana" : "regularan",
    "clanarina" : 3000

}
var treci_clan = {
    "id" : "1104",
    "ime_prezime" : "Mina Maricic",
    "godina_rodjenja" : 2003,
    "email" : "minam03@gmail.com",
    "vrsta_clana" : "povlascen",
    "clanarina" : 3000

}

niz_clanova = JSON.parse(localStorage.getItem("clanovi")) || [prvi_clan,drugi_clan,treci_clan]

console.log(niz_clanova)

var tabela_div  = document.getElementById("tabela_div")

var update = document.getElementById("desno")

function tip_clanarine (niz_clanova){
    for(var clan of niz_clanova){
        if(clan.vrsta_clana == "povlascen"){
            clan.clanarina = 3000-3000*0.2
        }
    }

}

function init(){
    tip_clanarine(niz_clanova)
    napravi_tabelu()
    var dodaj = document.getElementById("dodaj_clana")
    dodaj.addEventListener("click",dodaj_novog)

}
var novi_clan

function dodaj_novog(){
    var id_input = document.getElementById("id")
    var ime_prezime_input = document.getElementById("ime_prezime")
    var godina_rodjenja_input = document.getElementById("godina_rodjenja")
    var email_input = document.getElementById("email")
    var regularan_vrsta_input = document.getElementById("vrsta_regularan")
    var povlascen_vrsta_input = document.getElementById("vrsta_povlascen")

    var id = id_input.value
    var ime_prezime = ime_prezime_input.value
    var godina_rodjenja = godina_rodjenja_input.value
    var email = email_input.value

    var vrsta = ""
    var clanarina

    if(regularan_vrsta_input.checked){
        vrsta = "regularan"
        clanarina = 3000
    }
    else if(povlascen_vrsta_input.checked){
        vrsta = "povlascen"
        clanarina = 2400
    }

    console.log("ID: ",id)
    console.log("IME I PREZIME: ",ime_prezime)
    console.log("GODINA RODJENJA: ",godina_rodjenja)
    console.log("EMAIL: ",email)
    console.log("VRSTA CLANA: ",vrsta)
    console.log("CLANARINA: ",clanarina)

    var greska_id = document.getElementById("greska_id")
    var greska_ime_prezime = document.getElementById("greska_ime_prezime")
    var greska_godina_rodjenja = document.getElementById("greska_godina_rodjenja")
    var greska_email = document.getElementById("greska_email")

    greska_id.innerHTML = validiraj_id(id)
    greska_ime_prezime.innerHTML = validiraj_ime_prezime(ime_prezime)
    greska_godina_rodjenja.innerHTML = validiraj_godinu_rodjenja(godina_rodjenja)
    greska_email.innerHTML = validiraj_email(email)

    if(greska_id.innerHTML != "" || greska_ime_prezime.innerHTML != "" || greska_godina_rodjenja.innerHTML != "" ||  greska_email.innerHTML != ""){
        console.log("Desila se greska")
        return false

    }
    
    timer()

    postavi_pitanje()

    

    novi_clan = {
        "id" : id,
        "ime_prezime" : ime_prezime,
        "godina_rodjenja" : godina_rodjenja,
        "email" : email,
        "vrsta_clana" : vrsta,
        "clanarina" : clanarina
    }


    id_input.value = ''
    ime_prezime_input.value = ''
    godina_rodjenja_input.value = ''
    email_input.value = ''
    regularan_vrsta_input.cheked = true


}
function validiraj_id(id){
    for(const clan of niz_clanova){
        if(clan.id == id){
            return "ID VEC POSTOJI"
        }
    }
    if(id == ""){
        return "ID NIJE UNET"
    }
    return ""
}
function validiraj_ime_prezime(ime_prezime){
    var space =ime_prezime.split(" ")
    if(space.length < 2){
        return "IME I PREZIME MORAJU IMATI RAZMAK"
    }
    else{
        return ""
    }
    
}
function validiraj_godinu_rodjenja(godina_rodjenja){
    if(godina_rodjenja <0 || godina_rodjenja>2023 || godina_rodjenja == ''){
        return "NEISPRAVAN UNOS GODINE RODJENJA"
    }
    return ""
}
function validiraj_email(email){
    var majmunce = email.split("@")
    if(majmunce.length != 2){
        return "EMAIL MORA DA SADRZI ZNAK @"
    }
    return ""

}
function delete_clana(index){
    niz_clanova.splice(index,1)
    localStorage.setItem("clanovi",JSON.stringify(niz_clanova))
    napravi_tabelu()

    update.innerHTML = ""


}
function update_clana(index){
    console.log("Povezano")
    update.innerHTML = ''
    var stari_clan = niz_clanova[index]

    var stari_clan_vrsta

    if(stari_clan.vrsta_clana =="regularan" ){
        stari_clan_vrsta = `
        <p id="za_centriranje">
        <label>VRSTA CLANA</label>
        <br>
        <input type="radio" name="vrsta_clana_update" id="vrsta_regularan_update" value="regularan" checked>REGULARAN
        <input type="radio" name="vrsta_clana_update" id="vrsta_povlascen_update" value="povlascen">POVLASCEN
    </p>
        `
    }
    else{
        stari_clan_vrsta =  `
        <p id="za_centriranje">
        <label>VRSTA CLANA</label>
        <br>
        <input type="radio" name="vrsta_clana_update" id="vrsta_regularan_update" value="regularan">REGULARAN
        <input type="radio" name="vrsta_clana_update" id="vrsta_povlascen_update" value="povlascen" checked>POVLASCEN
    </p>

        `
    }

    update.innerHTML += `
    <h2>AZURIRAJ</h2>
    <form>
        <p>
            <label>ID</label>
            <input type="text" id="id_update" name="id_update" value="${stari_clan.id}" readonly>
          
        </p>
        <p>
            <label>IME I PREZIME</label>
            <input type="text" id="ime_prezime_update" name="ime_prezime_update" value="${stari_clan.ime_prezime}">
            <span id="greska_ime_prezime_update" ></span>
            
        </p>
        <p>
            <label>GODINA RODJENJA</label>
            <input type="number" id="godina_rodjenja_update" name="godina_rodjenja_update" value="${stari_clan.godina_rodjenja}">
            <span id="greska_godina_rodjenja_update"></span>
        </p>
        <p>
            <label>EMAIL</label>
            <input type="text" id="email_update" name="email_update" value="${stari_clan.email}">
            <span id="greska_email_update"></span>
        </p>
        ${stari_clan_vrsta}
        <p>
            <button type="button" onclick="azuriraj_clana(${index})">AZURIRAJ CLANA</button>
        </p>
    </form>

    `



}
function azuriraj_clana(index){
    var id_input = document.getElementById("id_update")
    var ime_prezime_input = document.getElementById("ime_prezime_update")
    var godina_rodjenja_input = document.getElementById("godina_rodjenja_update")
    var email_input = document.getElementById("email_update")
    var regularan_vrsta_input = document.getElementById("vrsta_regularan_update")
    var povlascen_vrsta_input = document.getElementById("vrsta_povlascen_update")

    var id = id_input.value
    var ime_prezime = ime_prezime_input.value
    var godina_rodjenja = godina_rodjenja_input.value
    var email = email_input.value
    
    var vrsta = ""
    var clanarina

    if(regularan_vrsta_input.checked){
        vrsta = "regularan"
        clanarina = 3000

    }
    else if(povlascen_vrsta_input.checked){
        vrsta = "povlascen"
        clanarina = 2400
    }
    console.log("ID: ",id)
    console.log("IME I PREZIME: ",ime_prezime)
    console.log("GODINA RODJENJA: ",godina_rodjenja)
    console.log("EMAIL: ",email)
    console.log("VRSTA CLANA: ",vrsta)
    console.log("CLANARINA: ",clanarina)

    
    var greska_ime_prezime = document.getElementById("greska_ime_prezime_update")
    var greska_godina_rodjenja = document.getElementById("greska_godina_rodjenja_update")
    var greska_email = document.getElementById("greska_email_update")

    
    greska_ime_prezime.innerHTML = validiraj_ime_prezime(ime_prezime)
    greska_godina_rodjenja.innerHTML = validiraj_godinu_rodjenja(godina_rodjenja)
    greska_email.innerHTML = validiraj_email(email)

    if(greska_ime_prezime.innerHTML != '' || greska_godina_rodjenja.innerHTML != '' || greska_email.innerHTML != ''){
        console.log("Desila se greska")
        return false
    }

    var novi_clan = {
        "id" : id,
        "ime_prezime" : ime_prezime,
        "godina_rodjenja" : godina_rodjenja,
        "email" : email,
        "vrsta_clana" : vrsta,
        "clanarina" : clanarina
    }

    niz_clanova[index] = novi_clan
    localStorage.setItem("clanovi",JSON.stringify(niz_clanova))

    update.innerHTML = ''
    napravi_tabelu()

}
function napravi_tabelu(){
    tabela_div.innerHTML = " "
    var brojac = 0
    var rez = " "

    for(var clan of niz_clanova){
        rez += `
        <tbody>
            <tr>
                <td>${clan.id}</td>
                <td>${clan.ime_prezime}</td>
                <td>${clan.godina_rodjenja}</td>
                <td>${clan.email}</td>
                <td>${clan.vrsta_clana}</td>
                <td>${clan.clanarina}</td>
                <td>
                    <button id="update" onclick="update_clana(${brojac})">UPDATE</button>
                </td>
                <td>
                    <button id="delete" onclick="delete_clana(${brojac})">DELETE</button>
                </td>
            </tr>
        </tbody>

        `
        brojac++

    }
    tabela_div.innerHTML += `
    <table style="border: 1; border-collapse:collapse;">
        <thead>
            <tr>
                <th>ID</th>
                <th>IME I PREZIME</th>
                <th>GODINA RODJENJA</th>
                <th>EMAIL</th>
                <th>VRSTA CLANA</th>
                <th>CLANARINA</th>
                <th colspan="2">OPCIJE</th>
            </tr>
        </thead>
        ${rez}

    `
    tabela_div.innerHTML += `
    </table>
    `


}
console.log(niz_clanova)


function nasumican_broj(){
    return Math.floor(Math.random()* 10) + 1
}

function nasumicna_operacija(){
    const operacija = ['+','-','*','/']

    const pozicija = Math.floor(Math.random()*operacija.length)

    return operacija[pozicija]

}
var interval = null
var vreme = 30
var tajmer = document.getElementById("timer")

function timer(){
    if(interval == null){
        tajmer.classList.add("timer")
        tajmer.style.width = "100%"
        interval = setInterval(otkucaj,20)
    }

}
var sirina_diva = 100
function otkucaj(){
    
    var sirina_tajmera =100/vreme/(1000/20)

    tajmer.style.width = `${sirina_diva}%`

    if(sirina_diva - sirina_tajmera >= 0){
       sirina_diva -= sirina_tajmera
    }
    else{
        obavestenje.innerHTML = "VREME JE ISTEKLO!"

        clearInterval(interval)
        interval = null
        sirina_diva = 100
        tajmer.classList.remove("timer")
        div_odgovor.style.display = "none"
        div_pitanje.classList.remove("pitanje")
        div_pitanje.innerHTML = ""
        document.getElementById("odgovor").value = ""
    }
}
var pitanje
var odgovor
var div_pitanje = document.getElementById("pitanje")

var div_odgovor = document.getElementById("div_odgovor")

var obavestenje = document.getElementById("obavestenje")

function postavi_pitanje(){
    var broj_1 = nasumican_broj()
    var broj_2 = nasumican_broj()
    var operacija = nasumicna_operacija()

    if(operacija == "/" && broj_1 < broj_2){
        while(broj_1 < broj_2 ){
            broj_1 = nasumican_broj()
        }
         
    }
    obavestenje.innerHTML = ""

    pitanje = `${broj_1} ${operacija} ${broj_2}`
    odgovor = Math.floor(eval(pitanje))

   
    div_pitanje.innerText = pitanje

    div_odgovor.style.display = "flex"

    div_pitanje.classList.add("pitanje")


    return pitanje

}
function proveri_odgovor(){
    console.log("Uvezano")

    var uzmi_vrednost = parseInt(document.getElementById("odgovor").value)
    if(!isNaN(uzmi_vrednost)){
        if(uzmi_vrednost == odgovor){
            obavestenje.innerText = "TACAN ODGOVOR!"

            niz_clanova.push(novi_clan)
            localStorage.setItem("clanovi",JSON.stringify(niz_clanova))
            napravi_tabelu()

            clearInterval(interval)
            interval = null
            sirina_diva = 100
            tajmer.classList.remove("timer")
            div_odgovor.style.display = "none"
            div_pitanje.classList.remove("pitanje")
            div_pitanje.innerHTML = ""

            document.getElementById("odgovor").value = ""


        }
        else{
            obavestenje.innerText = `NETACAN ODGOVOR!
            RESENJE: ${odgovor}
            `
            clearInterval(interval)
            interval = null
            sirina_diva = 100
            tajmer.classList.remove("timer")
            div_odgovor.style.display = "none"
            div_pitanje.classList.remove("pitanje")
            div_pitanje.innerHTML = ""
            document.getElementById("odgovor").value = ""
        }
    }
    else{
        obavestenje.innerText = "NEISPRAVAN UNOS"
        clearInterval(interval)
        interval = null
        sirina_diva = 100
        tajmer.classList.remove("timer")
        div_odgovor.style.display = "none"
        div_pitanje.classList.remove("pitanje")
        div_pitanje.innerHTML = ""
        document.getElementById("odgovor").value = ""
    }





}



