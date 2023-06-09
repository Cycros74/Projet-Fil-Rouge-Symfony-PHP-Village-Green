-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : Dim 25 avr. 2023 à 16:40
-- Version du serveur :  5.7.24
-- Version de PHP : 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `village_green`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delai_moyen` (IN `commande` INT)  BEGIN

SELECT ROUND(AVG(DATEDIFF(cmd_fact_date,cmd_date))) AS "Délai moyen de livraison en jours"
FROM commande
WHERE cmd_id = commande;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `etat_commande` (IN `livr` VARCHAR(250))  BEGIN

SELECT liv_id, liv_date, liv_cmd_id, liv_etat AS "Commandes en cours de livraison"
FROM livraison
WHERE liv_etat = livr;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

CREATE TABLE `adresse` (
  `id` int(11) NOT NULL,
  `adr_cli_id` int(11) NOT NULL,
  `adr_num_rue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adr_ville` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adr_pays` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adr_cp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id`, `adr_cli_id`, `adr_num_rue`, `adr_ville`, `adr_pays`, `adr_cp`) VALUES
(9, 32, '2 rue des Louvels', 'Amiens', 'FR', '80000'),
(14, 39, '13 rue des Platanes', 'Boves', 'FR', '80480'),
(15, 39, '45 rue des Plantes', 'Amiens', 'FR', '80000'),
(16, 39, '12 rue de la Liberté', 'Amiens', 'FR', '80000');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `cli_id` int(11) NOT NULL,
  `cli_nom` varchar(50) DEFAULT NULL,
  `cli_prenom` varchar(50) DEFAULT NULL,
  `cli_email` varchar(250) NOT NULL,
  `cli_password` varchar(250) NOT NULL,
  `cli_adresse` varchar(250) DEFAULT NULL,
  `cli_cp` char(5) DEFAULT NULL,
  `cli_ville` varchar(50) DEFAULT NULL,
  `cli_regl` varchar(50) DEFAULT NULL,
  `cli_categ` varchar(50) DEFAULT NULL,
  `cli_coeff` decimal(5,2) DEFAULT NULL,
  `cli_com_id` int(11) DEFAULT NULL,
  `cli_role` varchar(255) NOT NULL,
  `cli_reset_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`cli_id`, `cli_nom`, `cli_prenom`, `cli_email`, `cli_password`, `cli_adresse`, `cli_cp`, `cli_ville`, `cli_regl`, `cli_categ`, `cli_coeff`, `cli_com_id`, `cli_role`, `cli_reset_token`) VALUES
(1, 'Morel', 'Jacques', 'jacques@morel.fr', '', '12 rue de la République', '80000', 'Amiens', 'Immédiat', 'Particulier', '1.00', 1, 'utilisateur', NULL),
(2, 'Guérin', 'Charles', 'charles@guerin.fr', '', '5 Impasse des Lilas', '80250', 'Ailly-sur-Noye', 'Immédiat', 'Particulier', '1.00', 5, 'utilisateur', NULL),
(3, 'Boyer', 'Caroline', 'caroline@boyer.fr', '', 'Rue de l’Eglise', '80330', 'Longueau', 'Différé', 'Professionnel', '1.00', 3, 'utilisateur', NULL),
(4, 'Perrin', 'Clément', 'clement@perrin.fr', '', '56 rue Saint Fuscien', '80700', 'Roye', 'Différé', 'Professionnel', '1.00', 2, 'utilisateur', NULL),
(5, 'Duval', 'Pascal', 'pascal@duval.fr', '', '79 rue Delpech', '80450', 'Camon', 'Différé', 'Professionnel', '1.00', 4, 'utilisateur', NULL),
(32, 'Potelle', 'Caroline', 'caro@afpa.fr', '$2y$12$RV6oOrSpQp7ptLBwdI/R8.fn/AIhCxC2RtxK8pRa7ryvueNw70ztu', '2 rue de la République', '80090', 'Amiens', 'A définir', 'A définir', '1.00', NULL, 'administrateur', NULL),
(39, 'Dumas', 'Clément', 'clement@afpa.fr', '$2y$12$7Uc4j2kwFWsbMx74ucYOpectd4SxcOpVi1z9lcmp9BTArXdXLiPju', '12 rue des Platanes', '80090', 'Amiens', 'A définir', 'A définir', '1.00', NULL, 'utilisateur', NULL),
(40, 'Legrand', 'Fred', 'fred@afpa.fr', '$2y$12$BgaRwa.7QfCdOreF2kiKDeCunVyuTdyRJ4AUN2wh58aLJ7lU3rMuO', '2 rue de la citadelle', '80000', 'Amiens', 'A définir', 'A définir', '1.00', NULL, 'utilisateur', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `cmd_id` int(11) NOT NULL,
  `cmd_date` date DEFAULT NULL,
  `cmd_reduc` decimal(5,2) DEFAULT NULL,
  `cmd_cli_adresse_fact` varchar(50) DEFAULT NULL,
  `cmd_cli_cp_fact` char(5) DEFAULT NULL,
  `cmd_cli_ville_fact` varchar(50) DEFAULT NULL,
  `cmd_cli_adresse_liv` varchar(50) DEFAULT NULL,
  `cmd_cli_cp_liv` char(5) DEFAULT NULL,
  `cmd_cli_ville_liv` varchar(50) DEFAULT NULL,
  `cmd_cli_coeff` decimal(5,2) DEFAULT NULL,
  `cmd_payer` tinyint(1) NOT NULL,
  `cmd_liv_nom` varchar(255) NOT NULL,
  `cmd_liv_prix` double NOT NULL,
  `cmd_reference` varchar(255) NOT NULL,
  `cmd_strip_id_session` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`cmd_id`, `cmd_date`, `cmd_reduc`, `cmd_cli_adresse_fact`, `cmd_cli_cp_fact`, `cmd_cli_ville_fact`, `cmd_cli_adresse_liv`, `cmd_cli_cp_liv`, `cmd_cli_ville_liv`, `cmd_cli_coeff`, `cmd_payer`, `cmd_liv_nom`, `cmd_liv_prix`, `cmd_reference`, `cmd_strip_id_session`) VALUES
(1, '2020-08-03', NULL, '12 rue de la République', '80000', 'Amiens', '12 rue de la République', '80000', 'Amiens', '1.00', 0, 'DHL', 1230, '', NULL),
(2, '2020-08-10', NULL, '56 rue Saint Fuscien', '80700', 'Roye', '56 rue Saint Fuscien', '80700', 'Roye', '1.00', 0, 'UPS', 950, '', NULL),
(3, '2020-08-15', NULL, 'Rue de l\'Eglise', '80330', 'Longueau', 'Rue de l\'Eglise', '80330', 'Longueau', '1.00', 0, 'TNT', 1000, '', NULL),
(4, '2020-09-02', NULL, '56 rue Saint Fuscien', '80700', 'Roye', '56 rue Saint Fuscien', '80700', 'Roye', '1.00', 0, 'UPS', 950, '', NULL),
(5, '2020-09-05', NULL, '79 rue Delpech', '80450', 'Camon', '79 rue Delpech', '80450', 'Camon', '1.00', 0, 'FEDEX', 1550, '', NULL),
(6, '2020-10-11', NULL, '12 rue de la République', '80000', 'Amiens', '12 rue de la République', '80000', 'Amiens', '1.00', 0, 'DHL', 1230, '', NULL),
(7, '2020-11-23', NULL, '12 rue de la République', '80000', 'Amiens', '12 rue de la République', '80000', 'Amiens', '1.00', 0, 'UPS', 950, '', NULL),
(8, '2020-11-28', NULL, '5 Impasse des Lilas', '80250', 'Ailly-sur-Noye', '5 Impasse des Lilas', '80250', 'Ailly-sur-Noye', '1.00', 0, 'TNT', 1000, '', NULL),
(20, '2021-04-08', NULL, '2 rue des Louvels', '80000', 'Amiens', '2 rue des Louvels', '80000', 'Amiens', '1.00', 1, 'FEDEX', 1550, '080421-606ed9ccedf2d', 'cs_test_b1oTo5aCBZ9imot7kZm0rSGG195USSGkxcbuQvJfiYZNxrQACm7BQMUxqL'),
(21, '2021-04-09', NULL, '2 rue des Louvels', '80000', 'Amiens', '2 rue des Louvels', '80000', 'Amiens', '1.00', 1, 'DHL', 1230, '090421-60702c445c2d6', 'cs_test_b1UIspvCqZb78VpKgeghGVyFKPaqB5Xh3Mxyvoq9bnEldIYMZ0ezWDGct9');

-- --------------------------------------------------------

--
-- Structure de la table `commercial`
--

CREATE TABLE `commercial` (
  `com_id` int(11) NOT NULL,
  `com_nom` varchar(50) DEFAULT NULL,
  `com_prenom` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `commercial`
--

INSERT INTO `commercial` (`com_id`, `com_nom`, `com_prenom`) VALUES
(1, 'Durand', 'Marc'),
(2, 'Dufour', 'Paul'),
(3, 'Legrand', 'Charline'),
(4, 'Gilbert', 'Emma'),
(5, 'Dupont', 'Max');

-- --------------------------------------------------------

--
-- Structure de la table `contient`
--

CREATE TABLE `contient` (
  `contient_pro_id` int(11) NOT NULL,
  `contient_liv_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `detail_commande`
--

CREATE TABLE `detail_commande` (
  `id` int(11) NOT NULL,
  `det_cmd_cmd_id` int(11) NOT NULL,
  `det_cmd_produit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `det_cmd_pro_qte` int(11) NOT NULL,
  `det_cmd_pro_prix` double NOT NULL,
  `det_cmd_total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `detail_commande`
--

INSERT INTO `detail_commande` (`id`, `det_cmd_cmd_id`, `det_cmd_produit`, `det_cmd_pro_qte`, `det_cmd_pro_prix`, `det_cmd_total`) VALUES
(12, 20, 'Harley Benton S-620 TR', 1, 162, 162),
(13, 20, 'Startone CG-851', 2, 102, 204),
(14, 21, 'Startone CG-851', 1, 102.87, 102.87);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20201202100510', '2020-12-02 10:05:28', 4382),
('DoctrineMigrations\\Version20201207160442', '2020-12-07 16:06:02', 124),
('DoctrineMigrations\\Version20201208073819', '2020-12-08 07:38:56', 154),
('DoctrineMigrations\\Version20201228175730', '2020-12-28 17:58:02', 86),
('DoctrineMigrations\\Version20210106080252', '2021-01-06 08:03:36', 192),
('DoctrineMigrations\\Version20210115074726', '2021-01-15 07:47:44', 227),
('DoctrineMigrations\\Version20210117123752', '2021-01-17 12:38:07', 205);

-- --------------------------------------------------------

--
-- Structure de la table `envoie`
--

CREATE TABLE `envoie` (
  `env_four_id` int(11) NOT NULL,
  `env_pro_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `envoie`
--

INSERT INTO `envoie` (`env_four_id`, `env_pro_id`) VALUES
(1, 1),
(1, 3),
(3, 4),
(1, 5),
(2, 10),
(4, 11),
(5, 12),
(5, 15),
(1, 20),
(1, 22),
(5, 28),
(2, 29),
(2, 31),
(3, 35),
(1, 41),
(3, 43),
(4, 55),
(2, 56);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

CREATE TABLE `fournisseur` (
  `four_id` int(11) NOT NULL,
  `four_nom` varchar(50) DEFAULT NULL,
  `four_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`four_id`, `four_nom`, `four_type`) VALUES
(1, 'Hebei Musical Pads', 'Constructeur'),
(2, 'Pontree', 'Constructeur'),
(3, 'Lemca', 'Importateur'),
(4, 'Anatolian Sounds', 'Constructeur'),
(5, 'Key Music', 'Importateur');

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

CREATE TABLE `livraison` (
  `liv_id` int(11) NOT NULL,
  `liv_date` date DEFAULT NULL,
  `liv_cmd_id` int(11) DEFAULT NULL,
  `liv_etat` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `livraison`
--

INSERT INTO `livraison` (`liv_id`, `liv_date`, `liv_cmd_id`, `liv_etat`) VALUES
(1, '2020-08-14', 1, 'Livrée'),
(2, '2020-09-18', 2, 'En cours de livraison'),
(3, '2020-07-09', 3, 'Livrée'),
(4, '2020-08-26', 4, 'Livrée'),
(5, '2020-05-14', 5, 'Livrée'),
(6, '2020-09-17', 6, 'En cours de livraison'),
(7, '2020-09-24', 7, 'En cours de livraison'),
(8, '2020-09-14', 8, 'Expédiée'),
(10, '2021-04-09', 20, 'En cours de preparation'),
(11, '2021-04-10', 21, 'En cours de preparation');

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

CREATE TABLE `livreur` (
  `id` int(11) NOT NULL,
  `liv_nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `liv_description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `liv_prix` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`id`, `liv_nom`, `liv_description`, `liv_prix`) VALUES
(2, 'DHL', 'Profitez de la livraison express avec un colis chez vous le lendemain de votre commande', 1230),
(3, 'UPS', 'Profitez d\'une livraison à prix réduits avec un colis chez vous dans les 7 jours', 950),
(4, 'FEDEX', 'Profitez d\'une livraison premium avec un colis chez vous dans les 72 prochaines heures', 1550),
(6, 'TNT', 'Profitez de nos tarifs intéressants et d\'une livraison à votre domicile le lendemain de votre commande', 1000);

-- --------------------------------------------------------

--
-- Structure de la table `passe`
--

CREATE TABLE `passe` (
  `passe_cmd_id` int(11) NOT NULL,
  `passe_cli_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `passe`
--

INSERT INTO `passe` (`passe_cmd_id`, `passe_cli_id`) VALUES
(1, 1),
(6, 1),
(7, 1),
(8, 2),
(3, 3),
(2, 4),
(4, 4),
(5, 5),
(20, 32),
(21, 32);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `pro_id` int(11) NOT NULL,
  `pro_lib` varchar(50) DEFAULT NULL,
  `pro_descr` varchar(250) DEFAULT NULL,
  `pro_prix_achat` decimal(10,2) DEFAULT NULL,
  `pro_photo` varchar(250) DEFAULT NULL,
  `pro_stock` int(11) DEFAULT NULL,
  `pro_actif` tinyint(1) DEFAULT NULL,
  `pro_s_rub_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`pro_id`, `pro_lib`, `pro_descr`, `pro_prix_achat`, `pro_photo`, `pro_stock`, `pro_actif`, `pro_s_rub_id`) VALUES
(1, 'Harley Benton S-620 TR', 'Série Rock - Corps en tilleul - Table bombée - Manche vissé en érable - Profil du manche: Modern C - Touche en Roseacer - Filet de touche blanc - Repères \"points\" - 24 frettes - Diapason: 648 mm', '162.26', '155044.jpg', 10, 0, 1),
(2, 'Harley Benton ST-20 BK', 'Série Standard - Corps en tilleul - Manche en érable - Profil du manche: Modern C - Touche en Roseacer - Rayon de la touche: 350 mm - Repères \"points\" - 22 frettes - Diapason: 648 mm', '80.55', '135305.jpg', 25, 0, 1),
(3, 'Startone CG-851', 'Taille: 1/8 - Corps en tilleul - Manche en nato - Touche en érable - Diapason: 465 mm - Largeur au sillet: 39 mm - Filet de corps noir - Longueur totale: 762 mm - Cordes en nylon - Couleur: Rose', '102.87', '394726.jpg', 12, 0, 2),
(4, 'Harley Benton GL-2NT', 'Guitare classique 1/8 - Table en épicéa - Fond et éclisses en acajou (Entandrophragma cylindricum) - Manche en nato - Touche en blackwood (Pinus radiata) - Filet noir - 17 frettes - Diapason: 433 mm', '80.65', '371679.jpg', 56, 0, 2),
(5, 'Harley Benton D-120CE', 'Dreadnought - Pan coupé - Table en épicéa - Fond et éclisses en acajou - Manche en acajou - Profil du manche en C - Touche en Roseacer - 20 frettes - Repères \"points\" - Diapason: 650 mm', '79.99', '157819.jpg', 150, 0, 3),
(6, 'Takamine EF341SC', 'Modèle Bruce Springsteen -Dreadnought - Pan coupé - Table en cèdre massif - Fond et éclisses en érable - Touche et chevalet en palissandre - Repères \"flocons de neige\" en nacre', '112.50', '152211.jpg', 13, 0, 3),
(7, 'Harley Benton JB-75MN', '4 cordes - Série Vintage - Corps en frêne américain - Manche vissé en érable avec bande en Roseacer', '159.96', '224321.jpg', 450, 0, 4),
(8, 'Marcus Miller V7 Swamp Ash-4', '4 cordes - Fabriquée par Sire - Corps en frêne des marais - Manche 1 pièce en érable', '500.45', '446264.jpg', 356, 0, 4),
(9, 'Harley Benton Kahuna', 'Electro-acoustique - Série Custom Line Kahuna - Taille Traveller - Table en épicéa', '148.33', '11351477_800.jpg', 28, 0, 5),
(10, 'Harley Benton B-30BK Acoustic', '4 cordes - Série Acoustic Bass - Super Jumbo - Pan coupé - Table en épicéa', '157.67', '165299.jpg', 178, 0, 5),
(11, 'Harley Benton UK-12', 'Corps en tilleul - Manche en tilleul - Touche en Roseacer - 12 frettes - Diapason: 348 mm', '92.55', '14757106_800.jpg', 456, 0, 6),
(12, 'Harley Benton Ukulele UK-11', 'Table laminée - Fond et éclisses en tilleul - Touche en Roseacer - Longueur totale: 520 mm - 12 frettes', '122.48', '15089265_800.jpg', 154, 0, 6),
(13, 'Millenium Youngster Drum Set', 'Idéale pour les enfants à partir de 3 ans - Grosse caisse 16\"x12\" - Tom 08\"x05\" - caisse claire 10\"x04\" - Fûts en bois dur', '100.78', '14593713_800.jpg', 190, 0, 7),
(14, 'Millenium MX Jr. Junior Drumset', 'Pour enfants de 4 à 7 ans - Grosse caisse 16\"x10\"- Tom 08\"x05\" - Tom 10\"x06\"', '148.22', '7536758_800.jpg', 765, 0, 7),
(15, 'Millenium HD-120 E-Drum Set', 'Pour débutants et enfants - Encombrement requis: 1000 x 600 mm - 12 kits de batterie - Métronome 40-240 bpm', '222.39', '14367118_800.jpg', 436, 0, 8),
(16, 'Millenium MPS-150 E-Drum Set', 'Idéale pour les débutants - Batterie complète avec module de sons, rack/supports, pédale de grosse caisse et câblage - Poids total: 18,2 kg', '259.77', '10083900_800.jpg', 643, 0, 8),
(17, 'Zildjian 06\" A-Custom Splash', 'Finition: Brillante - Cymbale martelée à la main', '96.53', '14013887_800.jpg', 763, 0, 9),
(18, 'Zildjian 06\" A-Series Splash', 'Finition: Régulière - Cymbale martelée à la main', '105.51', '10389887_800.jpg', 409, 0, 9),
(19, 'Millenium 7A Drum Sticks Maple -Wood', 'En érable - Olives en bois', '219.84', '1732818_800.jpg', 498, 0, 10),
(20, 'Vic Firth 7AN American Classic Hickory', 'En hickory américain - Longueur: 394 mm - Diamètre: 13,7 mm - Olives en nylon', '111.58', '13297521_800.jpg', 27, 0, 10),
(21, 'Millenium MC890NT Conga Set', 'En bois - Finition: Vernis - Couleur: Naturel/ambre', '220.44', '10805740_800.jpg', 245, 0, 11),
(22, 'LP LPA647-SW 11+12 Conga Set I', 'Série Aspire - Fûts en noyer de Siam', '433.77', '11263498_800.jpg', 46, 0, 11),
(23, 'Yamaha PSR-SX900', '61 touches sensibles à la vélocité - Nouveau clavier FSB', '1891.49', '14616988_800.jpg', 678, 0, 12),
(24, 'Startone MKR 61', '61 touches - 128 sons - 128 rythmes', '91.66', '9980986_800.jpg', 298, 0, 12),
(25, 'Moog Matriarch', 'Générateur de son analogique - Séquenceur 256 pas', '210.53', '14907405_800.jpg', 870, 0, 13),
(26, 'Behringer Poly D', '37 touches sensibles à la vélocité', '719.95', '14923795_800.webp', 465, 0, 13),
(27, 'AKAI Professional MPK mini MK2 white', '25 mini-touches synth-action - Arpégiateur', '90.46', '12313797_800.jpg', 321, 0, 14),
(28, 'AKAI Professional MPK Mini MK3', '25 touches miniatures sensibles à la vélocité - Joystick 4 directions', '100.65', '15420811_800.jpg', 587, 0, 14),
(29, 'Thomann DP-26', '88 touches lestées - Mécanique à marteaux', '310.33', '14120887_800.jpg', 276, 0, 15),
(30, 'Roland FP-30 Bk', '88 touches - Clavier PHA-IV Action Ivory Feel', '622.98', '10722282_800.jpg', 123, 0, 15),
(31, 'Kawai GL 10 E/P Grand Piano', 'Mécaniques ultra-réactives - Marteaux feutrés', '481.36', '10395977_800.jpg', 546, 0, 16),
(32, 'Roth & Junius RJGP 186 WH/P Grand Piano', 'Cordes Röslau - Longueur: 185 cm - Hauteur: 102 cm - Largeur: 151 cm', '840.74', '4661757_800.jpg', 649, 0, 16),
(33, 'Focusrite Scarlett 2i2 3rd Gen', 'Connexion USB-C - Résolution Max 24 Bit / 192 kHz', '145.55', '14226632_800.jpg', 12, 0, 17),
(34, 'Behringer UMC404HD', 'Avec pré-amplis micro MIDAS - Résolution: 24 bit / 192 kHz', '111.46', '13906311_800.jpg', 45, 0, 17),
(35, 'KRK Rokit RP5 G4', 'Montage : haut-parleur en verre aramide de 5\" et tweeter en verre aramide de 1\"', '156.87', '14061542_800.jpg', 976, 0, 18),
(36, 'Rode NT1-A Complete Vocal Recording', 'Microphone rode NT1A - Suspension SM6 deluxe avec filtre anti-pop intégrée', '180.47', '11669583_800.jpg', 345, 0, 19),
(37, 'Image-Line FL Studio Producer Edition', 'Mises à jour gratuites à vie : garantit la dernière version', '186.11', '11338582_800.jpg', 546, 0, 20),
(38, 'Behringer ADA8200 Ultragain', '8x canaux AN / NA, convertisseur 24 bits - 44,1 / 48 kHz', '169.68', '9902170_800.jpg', 658, 0, 21),
(39, 'Soundboks The New Soundboks', 'Amplificateur intelligent 3x 72 Watts Mercus Audio Eximo de Classe D - SPL Max. : 126 dB', '900.92', '14615233_800.jpg', 123, 0, 22),
(40, 'Behringer EPS500MP3', 'Table de mixage 8 canaux avec 4x entrées niveau micro - Embase 35 mm inclus', '344.72', '6598901_800.jpg', 578, 0, 23),
(41, 'Behringer Xenyx X1622USB', 'Faders de 60 mm - 4x entrées micro avec alimentation Phantom +48V avec filtre coupe-bas 75Hz', '176.54', '13760486_800.jpg', 365, 0, 24),
(42, 'Behringer KM1700', 'Puissance RMS: 2x 800 Watt sous 4 Ohm - 2x 500 Watt sous 8 Ohm', '179.82', '11612204_800.jpg', 409, 0, 25),
(43, 'Behringer CX3400 Super X Pro V2', 'Fonctionnement stéréo 2 voies ou mono 3 voies - Sortie caisson de basses supplémentaire', '86.77', '13526696_800.jpg', 254, 0, 26),
(44, 'Stairville PAR 56 Active 300W DMX black', 'Convient pour lampes de PAR56 de 300 Watt et douille GX16D - Contrôle: DMX 512 (1 canal)', '59.64', '11855875_800.webp', 923, 0, 27),
(45, 'Eurolite Rubberlight 1Channel 9 m Clear', 'Longueur: 9 m - Tension: 230V - Couleur: Transparent', '55.58', '11407721_800.jpg', 760, 0, 28),
(46, 'Stairville AF-250 Fog Machine 1300W DMX', 'Interface DMX-512 intégrée - Télécommande inclus', '149.50', '9584365_800.jpg', 215, 0, 29),
(47, 'Stairville LED BossFx-1 Pro Bundle Comple', 'Panneaux lumineux: 12x LEDs RVB de 9 Watt - Derby: total de 12 x LED', '356.88', '14799741_800.jpg', 76, 0, 30),
(48, 'Stairville Wild Wash 132 LED RGB', '4 Effects in one: Floodlight, Wall Wash, Blinder and Strobe', '75.27', '11703403_800.jpg', 214, 0, 31),
(49, 'Native Instruments Traktor S2 MK3', 'Système de performance DJ avec 2 canaux - EQ 3 bandes par canal', '248.79', '13624516_800.jpg', 14, 0, 32),
(50, 'Numark NDX 500', 'Lecture de CD mp3, CD audio et CR-R', '220.43', '9517082_800.jpg', 54, 0, 33),
(51, 'Pro-Ject Debut III matt black', 'Bras de lecture en carbone de 8,6\" - Entraînement de précision par courroie', '232.44', '15403492_800.jpg', 23, 0, 34),
(52, 'Behringer DJX900USB', '5 canaux - Crossfader optique Infinium 45 mm sans contact', '205.18', '13819361_800.jpg', 56, 0, 35),
(53, 'Sennheiser HD-25', 'Successeur du casque Sennheiser suivant: HD-25-1-II Basic Edition - Dynamique', '112.65', '11041266_800.jpg', 789, 0, 36),
(54, 'Gator TSA 61 Keyboard Case', 'Pour clavier - En polyéthylène pratiquement indestructible', '239.59', '14907265_800.jpg', 546, 0, 37),
(55, 'Thomann Elite Case 1335', 'Pour guitare Semi-Hollow - Série Elite', '70.82', '13950381_800.jpg', 32, 0, 38),
(56, 'Millenium SD-180 B StudioDesk', 'Table de travail spacieuse pour les studios de production', '299.66', '13792401_800.jpg', 23, 0, 39),
(57, 'Thomann Cover dB Technologies SUB 612', 'Convient pour dB Technologies SUB 612 - En nylon hydrofuge de haute qualité', '36.58', '15290748_800.jpg', 478, 0, 40),
(58, 'Thomann Smartcart', 'Conçu pour transporter de DJ, de lumière, de sonorisation, de films et de télévision', '52.29', '13879781_800.jpg', 245, 0, 41),
(59, 'Millenium MS 2003', 'Socle en fonte - Trépied pliable', '71.55', '13413261_800.jpg', 879, 0, 42),
(60, 'Millenium MDT4 Drum Throne Round', 'Assise ronde - Diamètre assise: 280 mm - Trépied double embase', '44.29', '15190888_800.jpg', 78, 0, 43),
(61, 'Alpine MusicSafe Pro - Black Edition', 'Édition black - Système avec 2 pièces', '60.59', '351479.jpg', 34, 0, 44),
(62, 'Thomann SD Card 32 Gb Class 10', 'Capacité: 32 GB - Classe 10 - UHS-1', '42.37', '356476.jpg', 45, 0, 45),
(63, 'Seiko WPM1000BE Metronome', 'Seiko WPM1000BE pendulum metronome - color: brown', '98.36', '15265913_800.jpg', 57, 0, 46);

-- --------------------------------------------------------

--
-- Structure de la table `rubrique`
--

CREATE TABLE `rubrique` (
  `rub_id` int(11) NOT NULL,
  `rub_nom` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `rubrique`
--

INSERT INTO `rubrique` (`rub_id`, `rub_nom`) VALUES
(1, 'Guitare / Basse'),
(2, 'Batteries'),
(3, 'Clavier'),
(4, 'Studio'),
(5, 'Sono'),
(6, 'Eclairage'),
(7, 'DJ'),
(8, 'Cases'),
(9, 'Accessoires');

-- --------------------------------------------------------

--
-- Structure de la table `se_compose_de`
--

CREATE TABLE `se_compose_de` (
  `se_compose_de_pro_id` int(11) NOT NULL,
  `se_compose_de_cmd_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sous_rubrique`
--

CREATE TABLE `sous_rubrique` (
  `s_rub_id` int(11) NOT NULL,
  `s_rub_nom` varchar(50) DEFAULT NULL,
  `s_rub_rub_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `sous_rubrique`
--

INSERT INTO `sous_rubrique` (`s_rub_id`, `s_rub_nom`, `s_rub_rub_id`) VALUES
(1, 'Guitares Electriques', 1),
(2, 'Guitares Classiques', 1),
(3, 'Guitares Acoustiques', 1),
(4, 'Basses Electriques', 1),
(5, 'Basses Acoustiques', 1),
(6, 'Ukulélés', 1),
(7, 'Batteries Acoustiques', 2),
(8, 'Batteries Electroniques', 2),
(9, 'Cymbales', 2),
(10, 'Baguettes et Maillets', 2),
(11, 'Percussions', 2),
(12, 'Claviers Arrangeurs', 3),
(13, 'Synthétiseurs', 3),
(14, 'Claviers Maîtres', 3),
(15, 'Pianos de Scènes', 3),
(16, 'Pianos à Queue', 3),
(17, 'Interfaces Audio', 4),
(18, 'Enceinte de Monitoring', 4),
(19, 'Microphones', 4),
(20, 'Logiciels Studio', 4),
(21, 'Préamplificateurs Studio', 4),
(22, 'Sets de Sonorisation Complets', 5),
(23, 'Enceintes de Sonorisation', 5),
(24, 'Tables de Mixage', 5),
(25, 'Amplificateurs de Puissance', 5),
(26, 'Processeurs de Diffusion', 5),
(27, 'Projecteurs', 6),
(28, 'Eclairage', 6),
(29, 'Machine à Fumée', 6),
(30, 'Lasers', 6),
(31, 'Stroboscopes', 6),
(32, 'Contrôleurs DJ', 7),
(33, 'Lecteurs', 7),
(34, 'Platines Vinyles', 7),
(35, 'Tables de Mixage DJ', 7),
(36, 'Casques DJ', 7),
(37, 'Flight Cases', 8),
(38, 'Housses et Etuis', 8),
(39, 'Mobilier de Studio', 8),
(40, 'Housses de Protection', 8),
(41, 'Système de Transport', 8),
(42, 'Pieds et Supports', 9),
(43, 'Sièges', 9),
(44, 'Protections Auditives', 9),
(45, 'Supports de Stockage', 9),
(46, 'Métronomes', 9);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C35F0816C7440455` (`adr_cli_id`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`cli_id`),
  ADD KEY `cli_com_id` (`cli_com_id`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`cmd_id`);

--
-- Index pour la table `commercial`
--
ALTER TABLE `commercial`
  ADD PRIMARY KEY (`com_id`);

--
-- Index pour la table `contient`
--
ALTER TABLE `contient`
  ADD PRIMARY KEY (`contient_pro_id`,`contient_liv_id`),
  ADD KEY `IDX_DC302E56C4B17933` (`contient_liv_id`);

--
-- Index pour la table `detail_commande`
--
ALTER TABLE `detail_commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_98344FA64F5ADF30` (`det_cmd_cmd_id`) USING BTREE;

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `envoie`
--
ALTER TABLE `envoie`
  ADD PRIMARY KEY (`env_four_id`,`env_pro_id`),
  ADD KEY `IDX_4BC1C0028D32B924` (`env_pro_id`);

--
-- Index pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  ADD PRIMARY KEY (`four_id`);

--
-- Index pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD PRIMARY KEY (`liv_id`),
  ADD KEY `liv_cmd_id` (`liv_cmd_id`);

--
-- Index pour la table `livreur`
--
ALTER TABLE `livreur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `passe`
--
ALTER TABLE `passe`
  ADD PRIMARY KEY (`passe_cmd_id`,`passe_cli_id`),
  ADD KEY `IDX_D317EE5F5A8FBB7A` (`passe_cli_id`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`pro_id`),
  ADD KEY `pro_s_rub_id` (`pro_s_rub_id`);

--
-- Index pour la table `rubrique`
--
ALTER TABLE `rubrique`
  ADD PRIMARY KEY (`rub_id`);

--
-- Index pour la table `se_compose_de`
--
ALTER TABLE `se_compose_de`
  ADD PRIMARY KEY (`se_compose_de_pro_id`,`se_compose_de_cmd_id`),
  ADD KEY `IDX_5DF0822DB6C56994` (`se_compose_de_pro_id`),
  ADD KEY `IDX_5DF0822D6369EF3` (`se_compose_de_cmd_id`);

--
-- Index pour la table `sous_rubrique`
--
ALTER TABLE `sous_rubrique`
  ADD PRIMARY KEY (`s_rub_id`),
  ADD KEY `s_rub_rub_id` (`s_rub_rub_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adresse`
--
ALTER TABLE `adresse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `cli_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `cmd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `commercial`
--
ALTER TABLE `commercial`
  MODIFY `com_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `detail_commande`
--
ALTER TABLE `detail_commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  MODIFY `four_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `livraison`
--
ALTER TABLE `livraison`
  MODIFY `liv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `livreur`
--
ALTER TABLE `livreur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `pro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT pour la table `rubrique`
--
ALTER TABLE `rubrique`
  MODIFY `rub_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `sous_rubrique`
--
ALTER TABLE `sous_rubrique`
  MODIFY `s_rub_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD CONSTRAINT `FK_C35F0816C7440455` FOREIGN KEY (`adr_cli_id`) REFERENCES `client` (`cli_id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`cli_com_id`) REFERENCES `commercial` (`com_id`);

--
-- Contraintes pour la table `contient`
--
ALTER TABLE `contient`
  ADD CONSTRAINT `contient_ibfk_1` FOREIGN KEY (`contient_pro_id`) REFERENCES `produit` (`pro_id`),
  ADD CONSTRAINT `contient_ibfk_2` FOREIGN KEY (`contient_liv_id`) REFERENCES `livraison` (`liv_id`);

--
-- Contraintes pour la table `detail_commande`
--
ALTER TABLE `detail_commande`
  ADD CONSTRAINT `FK_98344FA64F5ADF30` FOREIGN KEY (`det_cmd_cmd_id`) REFERENCES `commande` (`cmd_id`);

--
-- Contraintes pour la table `envoie`
--
ALTER TABLE `envoie`
  ADD CONSTRAINT `envoie_ibfk_1` FOREIGN KEY (`env_four_id`) REFERENCES `fournisseur` (`four_id`),
  ADD CONSTRAINT `envoie_ibfk_2` FOREIGN KEY (`env_pro_id`) REFERENCES `produit` (`pro_id`);

--
-- Contraintes pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD CONSTRAINT `livraison_ibfk_1` FOREIGN KEY (`liv_cmd_id`) REFERENCES `commande` (`cmd_id`);

--
-- Contraintes pour la table `passe`
--
ALTER TABLE `passe`
  ADD CONSTRAINT `passe_ibfk_1` FOREIGN KEY (`passe_cmd_id`) REFERENCES `commande` (`cmd_id`),
  ADD CONSTRAINT `passe_ibfk_2` FOREIGN KEY (`passe_cli_id`) REFERENCES `client` (`cli_id`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `produit_ibfk_1` FOREIGN KEY (`pro_s_rub_id`) REFERENCES `sous_rubrique` (`s_rub_id`);

--
-- Contraintes pour la table `se_compose_de`
--
ALTER TABLE `se_compose_de`
  ADD CONSTRAINT `FK_5DF0822D6369EF3` FOREIGN KEY (`se_compose_de_cmd_id`) REFERENCES `commande` (`cmd_id`),
  ADD CONSTRAINT `FK_5DF0822DB6C56994` FOREIGN KEY (`se_compose_de_pro_id`) REFERENCES `produit` (`pro_id`);

--
-- Contraintes pour la table `sous_rubrique`
--
ALTER TABLE `sous_rubrique`
  ADD CONSTRAINT `sous_rubrique_ibfk_1` FOREIGN KEY (`s_rub_rub_id`) REFERENCES `rubrique` (`rub_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
