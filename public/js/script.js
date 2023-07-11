// Affichage produits avec filtre

$(document).ready(function(){

    let $card = $('.instru');

    $card.click(function (e){

        let selector = $(e.target).attr('data-filter');
        $('.grid').isotope({
            filter : selector
        }).css({ margin : '20px' });

        return false;
    })
});

//  Voters edit et delete produits ok + personnalisation 
// pages d'erreurs 403 et 404 + retrait accès bouton modifier 
// et supprimer produits pour utilisateur