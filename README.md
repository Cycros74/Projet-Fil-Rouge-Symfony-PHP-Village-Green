# Projet-Fil-Rouge-Symfony-PHP-Village-Green

C'est un site e-commerce de vente d'instruments et de matériel de musique que j'ai développé via le framework Symfony qui se base sur
un MVC (modèle / vue / controller).


***

## Uml

### Cas d'utilisation

![Class Diagram](http://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/germainsip/projet-village/master/puml/cas_util.puml)

***

### Description des cas d'utilisations

#### Consultation catalogue

> **prérequis:** _Aucun_


- L'utilisateur clique sur "Accès direct à la boutique"
- L'utilisateur peut voir les produits de toutes les catégories
- L'utilisateur peut afficher le détail du produit et son prix HT
- L'utilisateur peut ajouter directement des produits au panier
- L'utilisateur peut consulter son panier

***

#### Effectuer une commande

> **prérequis:** _L'utilisateur possède un compte client_

- L'utilisateur effectue une selection de produits dans son panier
- L'utilisateur enregistre son panier
- L'utilisateur se connecte et valide l'enregistrement du panier
- L'utilisateur vérifie ses coordonnées de livraison et de facturation
- Validation de la commande (cf: Validation commande).

***

### Diagramme de séquence

Sequence utilisateur:

![Sequence Diagram](http://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/germainsip/projet-village/master/puml/sequence_commande.puml)



## Vue de l'accueil: 

![Markdown Logo](https://zupimages.net/up/23/23/iokq.png)


## Vue de la fiche d’inscription: 

![Markdown Logo](https://zupimages.net/up/23/23/1giy.png)


## Vue de la page de sélection de produits: 

![Markdown Logo](https://zupimages.net/up/23/23/jfh5.png)


# Dictionnaire de données - Projet Fil Rouge :Village_Green et Diagramme MPD

> **PK= Primary KEY (clé primaire)**

> **FK = Foreign KEY (clé étrangère)**


![Markdown Logo](https://zupimages.net/up/23/23/txks.png)



 ## Table user

| Code        | Libelle         | Type           | Contrainte|
| -           | -               | -              | -         |
| id          | id              | INT            |           |
| nom         | Nom             | Varchar(255)   |           |
| prenom      | Prenom          | Varchar(255)   |           |
| email       | email           | Varchar(180)   | unique    |
| roles       | roles           | Varchar(255)   |           |
| password    | password        | Varchar(50)    |           |
| isverified | isVerified       | Booleen        |           |



 ## Table Categorie 

| Code            | Libelle           | Type           | Contrainte|
| -----------   | ---------------     | -------------- | --------  |
| Id            | Nom                 |INT             |           |
| CategorieNom  | Categorie Nom       |Varchar(50)     |           |
| CategorieType | Type de Categorie   |Varchar(50)     |           |
| Imagesrc      | Image source        |Varchar(255)    |           |




 ## Table Sous-Catégorie

| Code            | Libelle           | Type           | Contrainte|
| -----------   | ---------------     | -------------- | --------  |
| Id            | Nom                 |INT             |           |
| CategorieNom  | Categorie Nom       |Varchar(50)     |           |
| CategorieType | Type de Categorie   |Varchar(50)     |           |
| Imagesrc      | Image source        |Varchar(255)    |           |


 ## Table produit

| Code          | Libelle         | Type           | Contrainte|
| -             | -               | -              | -         |
| id            | id              | INT |          |           |
| nom           | Nom             | Varchar(50)    |           |
| StockPhysique | Stock Physique  | INT            |           |
| Description   | Description     | Varchar(255)   |           |
| Imagesrc        | Imgsrc          | Varchar(255)   |           |
| Actif         | Actif           | Booleen        |           |
| Prix          | Prix            | FLOAT          |           |

 ## Table Commande

| Code           | Libelle          | Type           | Contrainte|
| -              | -                | -              | -         |
| id             | id               | INT            |           |
| dateCommande   | Date de commande | Date           |           |
| MoyenReglement | MoyenReglement   | Varchar(255)   |           |
| Paye           | Paye             | Booleen        |           |
| StatutCommande | StatutCommande   | Varchar(255)   |           |


## Table Détail Commande

| Code           | Libelle          | Type           | Contrainte|
| -              | -                | -              | -         |
| id             | id               | INT            |           |
| dateCommande   | Date de commande | Date           |           |
| MoyenReglement | MoyenReglement   | Varchar(255)   |           |
| Paye           | Paye             | Booleen        |           |
| StatutCommande | StatutCommande   | Varchar(255)   |           |

## Table Adresse

| Code           | Libelle          | Type           | Contrainte|
| -              | -                | -              | -         |
| adresse1       | adresse1         | Varchar(255)   |           |
| adresse2       | adresse2         | Varchar(255)   |           |
| adresse3       | adresse3         | Varchar(255)   |           |
| CodePostal     | CodePostal       | Varchar(255)   |           |
| Ville          | Ville            | Varchar(255)   |           |
| Pays           | Pays             | Varchar(255)   |           |



## livraison TODO


# Gestion d'un Controller 


![Markdown Logo](https://www.zupimages.net/up/23/09/z1qy.png)

Ici le controller "SecurityController" nous permet de gérer deux routes.
La première 

``` #[Route(path: '/login', name: 'app_login')] ```

permet de lier cette route à notre twig (vue) qui correspond à la page connexion de l'utilisateur.


La seconde vue 

``` #[Route(path: '/logout', name: 'app_logout')] ```

permet de déconnecter l'utilisateur via la ``` public function logout() ````
