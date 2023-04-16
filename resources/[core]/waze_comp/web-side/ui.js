var test = document.getElementsByClassName('test')
var menuoption = document.getElementsByClassName('menuoption');
window.addEventListener('message', function(event){
    if(event.data.test != undefined){
        let status = event.data.test
        if(status){
            $(test).show();
        }else {
            $(test).hide();
        }
    }
    if(event.data.passaporte != undefined){
        let passaporte = event.data.passaporte
        document.getElementById("passaporte").innerHTML = passaporte
    }
    let nomecompleto = ''
    if(event.data.nome != undefined){
        nomecompleto = event.data.nome
        document.getElementById("nome").innerHTML = nomecompleto
    }
    if(event.data.sobrenome != undefined){
        let sobrenome = event.data.sobrenome
        nomecompleto = `${nomecompleto} ${sobrenome}` 
        document.getElementById("nome").innerHTML = nomecompleto
    }
    if(event.data.idade != undefined){
        let idade = event.data.idade
        document.getElementById("idade").innerHTML = idade
    }
    if(event.data.telefone != undefined){
        let telefone = event.data.telefone
        document.getElementById("telefone").innerHTML = telefone
    }
    if(event.data.identidade != undefined){
        let identidade = event.data.identidade
        document.getElementById("identidade").innerHTML = identidade
    }
    if(event.data.set != undefined){
        let set = event.data.set
        document.getElementById("set").innerHTML = set
    }
    if(event.data.set2 != undefined){
        let set2 = event.data.set2
        document.getElementById("set2").innerHTML = set2
    }
    if(event.data.vip != undefined){
        let vip = event.data.vip
        document.getElementById("vip").innerHTML = vip
    }
    if(event.data.carteira != undefined){
        let carteira = event.data.carteira
        document.getElementById("carteira").innerHTML = carteira
    }
    if(event.data.banco != undefined){
        let banco = event.data.banco
        document.getElementById("banco").innerHTML = banco
    }
    if(event.data.relacionamento != undefined){
        let relacionamento = event.data.relacionamento
        document.getElementById("relacionamento").innerHTML = relacionamento
    }
    //if(event.data.paypal != undefined){
    //    let paypal = event.data.paypal
    //    document.getElementById("paypal").innerHTML = paypal
    //}
    if(event.data.bgerente != undefined){
        let bgerente = event.data.bgerente
        document.getElementById("bgerente").innerHTML = bgerente
    }
});