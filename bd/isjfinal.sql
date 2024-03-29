-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  jeu. 23 mai 2019 à 09:53
-- Version du serveur :  10.1.31-MariaDB
-- Version de PHP :  7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `isjfinal`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AFFICHER_NOTE` (IN `type_evaluation.libelle` VARCHAR(255), IN `code_ue` VARCHAR(255), IN `code_authentification` VARCHAR(255))  BEGIN
	select DISTINCT valeur_note, ue.code_ue as code_ue, type_evaluation.libelle as examen
from etudiant, filiere, note, type_evaluation, module, est_inscrit, candidat, evaluation, enseignement, ue, niveau, classe, specialite
where note.est_inscrit=est_inscrit.code
and est_inscrit.enseignement=enseignement.code
and enseignement.ue=ue.`code`
and est_inscrit.candidat_inscrit=candidat.`code`
and evaluation.type_evaluation=type_evaluation.`code`
and ue.module=module.`code`
and note.evaluation=evaluation.`code`
and candidat.code=etudiant.code_authentification
and ue.code_ue=code_ue
and type_evaluation.libelle=type_evaluation.libelle
and etudiant.code_authentification=code_authentification
and candidat.classe=classe.`code`
and classe.specialite=specialite.`code`
and specialite.filiere=filiere.`code`
and type_evaluation.enseignement=enseignement.`code`
and niveau.`code`=ue.niveau
and ue.module=module.`code`;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inf_etud` (IN `mat` VARCHAR(255))  NO SQL
SELECT nom,prenom,date_naissance,sexe,matricule,filiere.libelle as filiere,niveau.numero as niveau
from candidat,filiere,classe,niveau,specialite,etudiant
where candidat.code=etudiant.code
AND candidat.classe=classe.code
AND classe.specialite=specialite.code
AND specialite.filiere=filiere.code
AND classe.niveau=niveau.code
AND etudiant.matricule=mat$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `annee_academique`
--

CREATE TABLE `annee_academique` (
  `code` bigint(20) NOT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `annee_academique`
--

INSERT INTO `annee_academique` (`code`, `date_cloture`, `date_creation`, `date_debut`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, '2020-05-08 00:00:00', '2019-04-08 13:32:34', '2019-09-02 00:00:00', '2019-04-08 13:32:34', NULL, NULL, 'ACTIVE', 'ACTIVE', 1, 1),
(2, '2021-05-03 00:00:00', '2019-04-08 13:36:43', '2020-09-01 00:00:00', '2019-04-08 13:36:43', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(3, '2022-05-02 00:00:00', '2019-04-08 13:39:37', '2021-09-01 00:00:00', '2019-04-08 13:39:37', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(4, '2020-05-15 00:00:00', '2019-05-20 21:49:15', '2019-06-23 12:00:00', '2019-09-02 16:33:15', 'NULL', 'NULL', 'NULL', 'ACTIVE', 1, 1),
(5, '2020-05-15 00:00:00', '2019-05-20 21:49:15', '2019-06-23 12:00:00', '2019-09-15 16:20:15', 'NULL', 'NULL', NULL, 'ACTIVE', 1, 1),
(6, '2020-05-15 00:00:00', '2019-05-20 21:49:15', '2019-06-23 12:00:00', '2019-09-15 16:20:15', 'NULL', 'NULL', NULL, 'ACTIVE', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `anonymat`
--

CREATE TABLE `anonymat` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `numero_anonymat` int(11) DEFAULT NULL,
  `numero_table` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `evaluation` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL,
  `est_inscrit` bigint(20) DEFAULT NULL,
  `note` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `anonymat`
--

INSERT INTO `anonymat` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `numero_anonymat`, `numero_table`, `signature`, `statut_vie`, `createur`, `evaluation`, `modificateur`, `est_inscrit`, `note`) VALUES
(1, '2019-05-20 21:49:15', '2019-10-20 12:30:15', 'NULL', 'NULL', 1, 1, NULL, 'ACTIVE', 1, NULL, 1, NULL, NULL),
(2, '2019-05-20 21:49:15', '2020-01-02 12:30:00', NULL, NULL, 2, 43, NULL, 'ACTIVE', 1, 6, 1, 3, 1),
(3, '2019-05-20 21:49:15', '2020-01-02 12:30:00', NULL, NULL, 3, 4, NULL, 'ACTIVE', 1, 6, 1, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `candidat`
--

CREATE TABLE `candidat` (
  `code` bigint(20) NOT NULL,
  `DTYPE` varchar(31) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `date_naissance` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `ecole_origine` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `nom` varchar(255) NOT NULL,
  `nom_de_la_mere` varchar(255) DEFAULT NULL,
  `nom_du_pere` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `profession_de_la_mere` varchar(255) DEFAULT NULL,
  `profession_du_pere` varchar(255) DEFAULT NULL,
  `region_origine` varchar(255) DEFAULT NULL,
  `sexe` varchar(255) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `telephone` int(11) NOT NULL,
  `telephone_de_la_mere` int(11) DEFAULT NULL,
  `telephone_du_pere` int(11) DEFAULT NULL,
  `classe` bigint(20) DEFAULT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `candidat`
--

INSERT INTO `candidat` (`code`, `DTYPE`, `date_creation`, `date_modification`, `date_naissance`, `description`, `ecole_origine`, `email`, `libelle`, `nom`, `nom_de_la_mere`, `nom_du_pere`, `prenom`, `profession_de_la_mere`, `profession_du_pere`, `region_origine`, `sexe`, `signature`, `statut`, `statut_vie`, `telephone`, `telephone_de_la_mere`, `telephone_du_pere`, `classe`, `createur`, `modificateur`) VALUES
(1, 'Etudiant', '2019-04-08 13:13:03', '2019-04-08 13:13:03', '1996-04-01 00:00:00', NULL, 'Excellence', 'anthonyfouda@gmail.com', NULL, 'FOUDA', 'GOURIOU', 'FOUDA', 'ANTHONY', NULL, NULL, NULL, 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 691063708, NULL, NULL, 3, 1, 1),
(2, 'Etudiant', '2019-04-08 13:19:18', '2019-04-08 13:19:18', '1995-04-17 00:00:00', NULL, 'NESCAS', 'nsola@gmail.com', NULL, 'nsola', NULL, 'OYANE', 'STAHNN', NULL, NULL, NULL, 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 698745632, NULL, NULL, 4, 1, 1),
(3, 'Etudiant', '2019-04-08 13:23:46', '2019-04-08 13:23:46', '1997-08-16 00:00:00', NULL, 'vogt', 'cena@gmail.com', NULL, 'SONG', 'SONG', NULL, 'JUNIOR', NULL, NULL, NULL, 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 658974121, NULL, NULL, 4, 1, 1),
(4, 'Etudiant', '2019-04-20 12:38:47', '2019-04-20 12:38:53', '1996-02-14 12:39:03', NULL, 'vogt', 'ntonga@gmail.com', NULL, 'ntonga', NULL, 'NTONGA', 'JEANNE', NULL, NULL, NULL, 'FEMININ', NULL, 'ACTIVE', 'ACTIVE', 698959632, NULL, NULL, 5, 1, 1),
(5, 'Etudiant', '2019-04-21 23:20:45', '2019-04-21 23:20:49', '1999-03-17 23:20:53', NULL, 'Saint benoit', 'pie@gmail.com', NULL, 'Mandeng', NULL, 'Mandeng', 'IRENE', NULL, NULL, NULL, 'FEMININ', NULL, 'ACTIVE', 'ACTIVE', 698784512, NULL, NULL, 6, 1, 1),
(6, 'Etudiant', '2019-04-21 23:23:02', '2019-04-21 23:23:06', '1997-10-07 23:23:10', NULL, 'Advantiste', 'anne@gmail.com', NULL, 'Mboa', 'NANDA', 'Mboa', 'ANNE', NULL, NULL, NULL, 'FEMININ', NULL, 'ACTIVE', 'ACTIVE', 632541258, NULL, NULL, 3, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

CREATE TABLE `classe` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `niveau` bigint(20) DEFAULT NULL,
  `specialite` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `classe`
--

INSERT INTO `classe` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`, `niveau`, `specialite`) VALUES
(4, '2019-04-20 12:45:51', '2019-04-20 12:45:55', NULL, NULL, NULL, 'ACTIVE', 1, 1, 2, 2),
(3, '2019-04-20 12:45:16', '2019-04-20 12:45:20', NULL, NULL, NULL, 'ACTIVE', 1, 1, 1, 1),
(5, '2019-04-20 12:46:36', '2019-04-20 12:46:41', NULL, NULL, NULL, 'ACTIVE', 1, 1, 3, 2),
(6, '2019-04-20 12:47:14', '2019-04-20 12:47:18', NULL, NULL, NULL, 'ACTIVE', 1, 1, 4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `discipline`
--

CREATE TABLE `discipline` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `nb_heures_absences` int(11) DEFAULT NULL,
  `nb_retards` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `etudiant` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL,
  `semestre` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `discipline`
--

INSERT INTO `discipline` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `nb_heures_absences`, `nb_retards`, `signature`, `statut_vie`, `createur`, `etudiant`, `modificateur`, `semestre`) VALUES
(1, '2019-04-22 00:00:30', '2019-04-22 00:00:35', NULL, NULL, 10, 7, NULL, 'ACTIVE', 1, 1, 1, 1),
(2, '2019-04-22 00:02:21', '2019-04-22 00:02:21', NULL, NULL, 5, 18, NULL, 'ACTIVE', 1, 1, 1, 2),
(3, '2019-04-22 00:04:00', '2019-04-22 00:04:00', NULL, NULL, 0, 5, NULL, 'ACTIVE', 1, 2, 1, 1),
(4, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 25, 8, NULL, 'ACTIVE', 1, 2, 1, 2),
(5, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 2, 4, NULL, 'ACTIVE', 1, 3, 1, 1),
(6, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 0, 0, NULL, 'ACTIVE', 1, 3, 1, 2),
(7, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 35, 18, NULL, 'ACTIVE', 1, 4, 1, 1),
(8, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 2, 0, NULL, 'ACTIVE', 1, 4, 1, 2),
(9, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 3, 6, NULL, 'ACTIVE', 1, 5, 1, 1),
(10, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 0, 0, NULL, 'ACTIVE', 1, 5, 1, 2),
(11, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 1, 1, NULL, 'ACTIVE', 1, 6, 1, 1),
(12, '2019-04-22 00:07:30', '2019-04-22 00:07:30', NULL, NULL, 0, 21, NULL, 'ACTIVE', 1, 6, 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `droit`
--

CREATE TABLE `droit` (
  `code` bigint(20) NOT NULL,
  `categorie` varchar(255) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `ecriture` tinyint(1) DEFAULT '0',
  `lecture` tinyint(1) DEFAULT '0',
  `libelle` varchar(255) DEFAULT NULL,
  `modification` tinyint(1) DEFAULT '0',
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `suppression` tinyint(1) DEFAULT '0',
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `role` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `droit`
--

INSERT INTO `droit` (`code`, `categorie`, `date_creation`, `date_modification`, `description`, `ecriture`, `lecture`, `libelle`, `modification`, `signature`, `statut_vie`, `suppression`, `createur`, `modificateur`, `role`) VALUES
(1, '', '2019-04-22 02:00:55', '2019-04-22 02:00:55', NULL, 1, 1, NULL, 1, NULL, 'ACTIVE', 1, 1, 1, 2),
(2, '', '2019-04-22 02:01:59', '2019-04-22 02:01:59', NULL, 0, 1, NULL, 0, NULL, 'ACTIVE', 0, 1, 1, 3),
(3, '', '2019-04-22 02:03:51', '2019-04-22 02:03:51', NULL, 1, 1, NULL, 0, NULL, 'ACTIVE', 0, 1, 1, 1),
(4, '', '2019-04-22 02:04:37', '2019-04-22 02:04:37', NULL, 1, 1, NULL, 1, NULL, 'ACTIVE', 0, 1, 1, 4),
(552, 'AnneeAcademique', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-1450658700', 'ACTIVE', 1, 1, 1, 551),
(553, 'Anonymat', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-568103000', 'ACTIVE', 1, 1, 1, 551),
(554, 'Candidat', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-497078883', 'ACTIVE', 1, 1, 1, 551),
(555, 'Classe', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-1282112430', 'ACTIVE', 1, 1, 1, 551),
(556, 'Discipline', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-998044837', 'ACTIVE', 1, 1, 1, 551),
(557, 'Droit', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '113226976', 'ACTIVE', 1, 1, 1, 551),
(558, 'Email', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '475172208', 'ACTIVE', 1, 1, 1, 551),
(559, 'Enseignant', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1057523214', 'ACTIVE', 1, 1, 1, 551),
(560, 'Enseignement', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-985537325', 'ACTIVE', 1, 1, 1, 551),
(561, 'EnvoiMessage', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '238387489', 'ACTIVE', 1, 1, 1, 551),
(562, 'EstInscrit', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '690762011', 'ACTIVE', 1, 1, 1, 551),
(563, 'Etudiant', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '39972146', 'ACTIVE', 1, 1, 1, 551),
(564, 'Evaluation', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-139815438', 'ACTIVE', 1, 1, 1, 551),
(565, 'Filiere', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-892809286', 'ACTIVE', 1, 1, 1, 551),
(566, 'HistoriqueNote', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1553444050', 'ACTIVE', 1, 1, 1, 551),
(567, 'Message', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '333972539', 'ACTIVE', 1, 1, 1, 551),
(568, 'Module', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '466154838', 'ACTIVE', 1, 1, 1, 551),
(569, 'Niveau', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1681150581', 'ACTIVE', 1, 1, 1, 551),
(570, 'Note', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '544830213', 'ACTIVE', 1, 1, 1, 551),
(571, 'Personne', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1172136731', 'ACTIVE', 1, 1, 1, 551),
(572, 'Role', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '924772994', 'ACTIVE', 1, 1, 1, 551),
(573, 'Securite', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1767096408', 'ACTIVE', 1, 1, 1, 551),
(574, 'Semestre', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1499945894', 'ACTIVE', 1, 1, 1, 551),
(575, 'Session', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-1082593358', 'ACTIVE', 1, 1, 1, 551),
(576, 'Specialite', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '1352326792', 'ACTIVE', 1, 1, 1, 551),
(577, 'TypeEvaluation', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '927233907', 'ACTIVE', 1, 1, 1, 551),
(578, 'UE', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '2038624757', 'ACTIVE', 1, 1, 1, 551),
(579, 'Utilisateur', '2019-05-19 11:25:37', '2019-05-19 11:25:37', '', 1, 1, '', 1, '-1316159533', 'ACTIVE', 1, 1, 1, 551);

-- --------------------------------------------------------

--
-- Structure de la table `email`
--

CREATE TABLE `email` (
  `code` bigint(20) NOT NULL,
  `objet` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `email`
--

INSERT INTO `email` (`code`, `objet`) VALUES
(1, 'salutation'),
(151, 'test'),
(2, 'salutation 2'),
(3, 'salution3');

-- --------------------------------------------------------

--
-- Structure de la table `enseignant`
--

CREATE TABLE `enseignant` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `date_naissance` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `sexe` varchar(255) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `telephone` int(11) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `enseignant`
--

INSERT INTO `enseignant` (`code`, `date_creation`, `date_modification`, `date_naissance`, `description`, `email`, `libelle`, `nom`, `prenom`, `qualification`, `sexe`, `signature`, `statut`, `statut_vie`, `telephone`, `createur`, `modificateur`) VALUES
(1, '2019-04-11 08:37:29', '2019-04-11 08:37:29', '1968-04-10 00:00:00', NULL, 'kiampi@gmail.com', NULL, 'Kiampi', NULL, 'Dr', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 699333333, 1, 1),
(2, '2019-04-11 08:38:57', '2019-04-11 08:38:57', '1968-10-04 00:00:00', NULL, 'SAHA@gmail.com', NULL, 'Saha', NULL, 'MASTER', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 699989796, 1, 1),
(3, '2019-04-11 08:40:49', '2019-04-11 08:40:49', '1975-04-09 00:00:00', NULL, 'Tchio@gmail.com', NULL, 'Tchio', 'Corneille', NULL, 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 601063708, 1, 1),
(4, '2019-04-11 08:42:14', '2019-04-11 08:42:14', '1964-03-09 00:00:00', NULL, 'Mballa@gmail.com', NULL, 'Mballa', 'Fabien', 'Pr', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 601043507, 1, 1),
(5, '2019-04-11 08:46:09', '2019-04-11 08:46:09', '1963-08-21 00:00:00', NULL, 'kwamo@gmail.com', NULL, 'Kouamo', 'Georges', 'Dr', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 698451425, 1, 1),
(6, '2019-04-11 08:47:57', '2019-04-11 08:47:57', '1963-08-21 00:00:00', NULL, 'Tchantcho@gmail.com', NULL, 'Tchantcho', 'Hugues', 'Dr', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 658471425, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `enseignement`
--

CREATE TABLE `enseignement` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `heures_de_cours` int(11) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `programme_de_cours` varchar(1020) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `semestre` bigint(20) DEFAULT NULL,
  `ue` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `enseignement`
--

INSERT INTO `enseignement` (`code`, `date_creation`, `date_modification`, `description`, `heures_de_cours`, `libelle`, `programme_de_cours`, `signature`, `statut_vie`, `createur`, `modificateur`, `semestre`, `ue`) VALUES
(1, '2019-04-11 08:20:57', '2019-04-11 08:20:57', NULL, 35, 'ARHITECTURE', NULL, NULL, 'ACTIVE', 1, 1, 1, 2),
(2, '2019-04-11 08:25:20', '2019-04-11 08:25:20', NULL, 35, 'MATH INFO', NULL, NULL, 'ACTIVE', 1, 1, 1, 1),
(3, '2019-04-11 08:25:20', '2019-04-11 08:25:20', NULL, 35, 'JAVA I', NULL, NULL, 'ACTIVE', 1, 1, 2, 5),
(4, '2019-04-11 08:25:20', '2019-04-11 08:25:20', NULL, 35, 'PROG C', NULL, NULL, 'ACTIVE', 1, 1, 2, 6),
(5, '2019-04-11 08:25:20', '2019-04-11 08:25:20', NULL, 35, 'SYSTEME D INFORMATION', NULL, NULL, 'ACTIVE', 1, 1, 1, 1),
(6, '2019-04-11 08:25:20', '2019-04-11 08:25:20', NULL, 35, 'MATH DISCRETES', NULL, NULL, 'ACTIVE', 1, 1, 1, 4);

-- --------------------------------------------------------

--
-- Structure de la table `enseignement_enseignant`
--

CREATE TABLE `enseignement_enseignant` (
  `code_enseignant` bigint(20) NOT NULL,
  `code_enseignement` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

--
-- Déchargement des données de la table `enseignement_enseignant`
--

INSERT INTO `enseignement_enseignant` (`code_enseignant`, `code_enseignement`) VALUES
(1, 2),
(2, 1),
(3, 4),
(4, 5),
(5, 3),
(6, 6);

-- --------------------------------------------------------

--
-- Structure de la table `envoi_message`
--

CREATE TABLE `envoi_message` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_envoi` datetime DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `candidat` bigint(20) DEFAULT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `message` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `envoi_message`
--

INSERT INTO `envoi_message` (`code`, `date_creation`, `date_envoi`, `date_modification`, `description`, `libelle`, `signature`, `statut`, `statut_vie`, `candidat`, `createur`, `modificateur`, `message`) VALUES
(1, '2019-04-22 01:16:49', '2019-04-22 01:16:49', '2019-04-22 01:16:49', NULL, NULL, NULL, 'SUCCES', 'ACTIVE', 1, 1, 1, 1),
(2, '2019-04-22 01:18:05', '2019-04-22 01:18:05', '2019-04-22 01:18:05', NULL, NULL, NULL, 'SUCCES', 'ACTIVE', 2, 1, 1, 2),
(3, '2019-04-22 01:18:05', '2019-04-22 01:18:05', '2019-04-22 01:18:05', NULL, NULL, NULL, 'SUCCES', 'ACTIVE', 3, 1, 1, 3),
(4, '2019-04-22 01:18:05', '2019-04-22 01:18:05', '2019-04-22 01:18:05', NULL, NULL, NULL, 'ECHEC', 'ACTIVE', 4, 1, 1, 4),
(5, '2019-04-22 01:18:05', '2019-04-22 01:18:05', '2019-04-22 01:18:05', NULL, NULL, NULL, 'ECHEC', 'ACTIVE', 5, 1, 1, 5),
(6, '2019-04-22 01:18:05', '2019-04-22 01:18:05', '2019-04-22 01:18:05', NULL, NULL, NULL, 'SUCCES', 'ACTIVE', 6, 1, 1, 6),
(401, '2019-04-26 12:58:26', '2019-04-26 12:58:26', '2019-04-26 12:58:26', 'test', 'test', '31', 'SUCCES', 'ACTIVE', 1, 1, 1, 151);

-- --------------------------------------------------------

--
-- Structure de la table `est_inscrit`
--

CREATE TABLE `est_inscrit` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `candidat_inscrit` bigint(20) DEFAULT NULL,
  `createur` bigint(20) NOT NULL,
  `enseignement` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `est_inscrit`
--

INSERT INTO `est_inscrit` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut`, `statut_vie`, `candidat_inscrit`, `createur`, `enseignement`, `modificateur`) VALUES
(3, '2019-04-22 00:47:36', '2019-04-22 00:47:36', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 1, 1, 3, 1),
(4, '2019-04-22 00:47:36', '2019-04-22 00:47:36', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 1, 1, 4, 1),
(5, '2019-04-22 00:50:11', '2019-04-22 00:50:11', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 2, 1, 1, 1),
(6, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 2, 3, 1, 1),
(7, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 3, 1, 1, 1),
(8, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 4, 1, 2, 1),
(9, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 4, 1, 6, 1),
(10, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 6, 1, 3, 1),
(11, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 6, 1, 4, 1),
(12, '2019-04-22 00:55:17', '2019-04-22 00:55:17', NULL, NULL, NULL, 'VALIDE', 'ACTIVE', 6, 1, 5, 1);

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `code` bigint(20) NOT NULL,
  `code_authentification` varchar(255) DEFAULT NULL,
  `matricule` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`code`, `code_authentification`, `matricule`) VALUES
(1, '1', 'ISJ0001'),
(2, '2', 'ISJ0002'),
(3, '3', 'ISJ0003'),
(4, '4', 'ISJ0004'),
(5, '5', 'ISJ0005'),
(6, '6', 'ISJ0006');

-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

CREATE TABLE `evaluation` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_evaluation` datetime DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `type_evaluation` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `evaluation`
--

INSERT INTO `evaluation` (`code`, `date_creation`, `date_evaluation`, `date_modification`, `description`, `libelle`, `signature`, `statut`, `statut_vie`, `createur`, `modificateur`, `type_evaluation`) VALUES
(1, '2019-04-22 00:14:46', '2019-12-10 07:00:00', '2019-04-22 00:14:46', NULL, NULL, NULL, 'ACTIVE', 'ACTIVE', 1, 1, 1),
(2, '2019-04-22 00:17:57', '2019-12-11 07:00:00', '2019-04-22 00:17:57', NULL, NULL, NULL, 'ACTIVE', 'ACTIVE', 1, 1, 4),
(6, '2019-04-22 00:22:43', '2019-12-13 10:00:00', '2019-04-22 00:22:43', NULL, NULL, NULL, 'ACTIVE', 'ACTIVE', 1, 1, 19),
(5, '2019-04-22 00:22:29', '2019-12-13 08:00:00', '2019-04-22 00:22:29', NULL, NULL, NULL, 'ACTIVE', 'ACTIVE', 1, 1, 16);

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `filiere`
--

INSERT INTO `filiere` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, '2019-04-11 07:53:49', '2019-04-11 07:53:49', NULL, 'LICENCE', NULL, 'ACTIVE', 1, 1),
(3, '2019-04-11 07:54:19', '2019-04-11 07:54:19', NULL, 'INGENIEUR', NULL, 'ACTIVE', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `historique_note`
--

CREATE TABLE `historique_note` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `valeur_note` double NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `note` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `historique_note`
--

INSERT INTO `historique_note` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `valeur_note`, `createur`, `modificateur`, `note`) VALUES
(1, '2019-04-22 01:25:46', '2019-04-22 01:25:46', NULL, NULL, NULL, 'ACTIVE', 17, 1, 1, 1),
(2, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, NULL, 'ACTIVE', 17, 1, 1, 2),
(3, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, NULL, 'ACTIVE', 14, 1, 1, 3),
(4, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, NULL, 'ACTIVE', 8, 1, 1, 4),
(5, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, NULL, 'ACTIVE', 11, 1, 1, 5);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `code` bigint(20) NOT NULL,
  `DTYPE` varchar(31) DEFAULT NULL,
  `contenu` varchar(255) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `destinataire` varchar(255) DEFAULT NULL,
  `emetteur` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`code`, `DTYPE`, `contenu`, `date_creation`, `date_modification`, `description`, `destinataire`, `emetteur`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, 'Email', 'BONjour 1', '2019-04-22 01:20:09', '2019-04-22 01:20:09', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1),
(2, 'Email', 'BONjour 2', '2019-04-22 01:21:05', '2019-04-22 01:21:05', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1),
(3, 'Email', 'BONjour 3', '2019-04-22 01:21:05', '2019-04-22 01:21:05', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1),
(4, 'Sms', 'BONjour 4', '2019-04-22 01:21:05', '2019-04-22 01:21:05', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1),
(5, 'Sms', 'BONjour 5', '2019-04-22 01:21:05', '2019-04-22 01:21:05', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1),
(6, 'Sms', 'BONjour 6', '2019-04-22 01:21:05', '2019-04-22 01:21:05', NULL, NULL, NULL, NULL, NULL, 'ACTIVE', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `module`
--

CREATE TABLE `module` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `module`
--

INSERT INTO `module` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, '2019-04-11 07:44:06', '2019-04-11 07:44:06', NULL, 'SYSTEME D\'INFORMATION ET ARCHITECTURE', NULL, 'ACTIVE', 1, 1),
(2, '2019-04-11 07:44:54', '2019-04-11 07:44:54', NULL, 'MATH APPLIQUEES POUR INFO', NULL, 'ACTIVE', 1, 1),
(3, '2019-04-11 07:45:34', '2019-04-11 07:45:34', NULL, 'JAVA1 ET PROGRAMMATION EN C', NULL, 'ACTIVE', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `niveau`
--

CREATE TABLE `niveau` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `niveau`
--

INSERT INTO `niveau` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `numero`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, '2019-04-11 07:50:44', '2019-04-11 07:50:44', 'NIVEAU 1 LICENCE', '', 1, NULL, 'ACTIVE', 1, 1),
(2, '2019-04-11 07:52:25', '2019-04-11 07:52:25', 'NIVEAU 1 INGENIEUR', '', 1, NULL, 'ACTIVE', 1, 1),
(3, '2019-04-11 07:52:25', '2019-04-11 07:52:25', 'NIVEAU 2 INGENIEUR', '', 2, NULL, 'ACTIVE', 1, 1),
(4, '2019-04-11 07:52:25', '2019-04-11 07:52:25', 'NIVEAU 2 LICENCE', '', 2, NULL, 'ACTIVE', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

CREATE TABLE `note` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `numero_table` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `valeur_note` double NOT NULL,
  `createur` bigint(20) NOT NULL,
  `evaluation` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL,
  `est_inscrit` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `numero_table`, `signature`, `statut_vie`, `valeur_note`, `createur`, `evaluation`, `modificateur`, `est_inscrit`) VALUES
(1, '2019-04-22 01:25:46', '2019-04-22 01:25:46', NULL, NULL, 10, NULL, 'ACTIVE', 17, 1, 1, 1, 6),
(2, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, 10, NULL, 'ACTIVE', 17, 1, 1, 1, 7),
(3, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, 15, NULL, 'ACTIVE', 14, 1, 2, 1, 8),
(4, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, 20, NULL, 'ACTIVE', 8, 1, 5, 1, 12),
(5, '2019-04-22 01:28:03', '2019-04-22 01:28:03', NULL, NULL, 22, NULL, 'ACTIVE', 11, 1, 6, 1, 9);

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `modificateur`) VALUES
(1, '2019-04-21 23:41:21', '2019-04-21 23:41:21', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(2, '2019-04-21 23:42:24', '2019-04-21 23:42:24', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(3, '2019-04-21 23:42:24', '2019-04-21 23:42:24', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(4, '2019-04-21 23:42:24', '2019-04-21 23:42:24', NULL, NULL, NULL, 'ACTIVE', 1, 1),
(551, '2019-05-19 11:25:36', '2019-05-19 11:41:34', '', 'Role Test', '1156087968', 'ACTIVE', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `semestre`
--

CREATE TABLE `semestre` (
  `code` bigint(20) NOT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `annee_academique` bigint(20) DEFAULT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `semestre`
--

INSERT INTO `semestre` (`code`, `date_cloture`, `date_creation`, `date_debut`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `annee_academique`, `createur`, `modificateur`) VALUES
(1, '2020-01-30 00:00:00', '2019-04-08 13:44:32', '2019-09-02 00:00:00', '2019-04-08 13:44:32', NULL, NULL, NULL, 'ACTIVE', 1, 1, 1),
(2, '2020-05-18 00:00:00', '2019-04-08 13:54:54', '2020-01-03 00:00:00', '2019-04-08 13:54:54', NULL, NULL, NULL, 'ACTIVE', 1, 1, 1),
(3, '2021-01-30 00:00:00', '2019-04-21 23:46:20', '2020-09-02 00:00:00', '2019-04-08 13:44:32', NULL, NULL, NULL, 'ACTIVE', 2, 1, 1),
(4, '2021-05-30 00:00:00', '2019-04-21 23:46:20', '2021-01-02 00:00:00', '2019-04-08 13:44:32', NULL, NULL, NULL, 'ACTIVE', 2, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `sequence`
--

CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sequence`
--

INSERT INTO `sequence` (`SEQ_NAME`, `SEQ_COUNT`) VALUES
('SEQ_GEN', '2650');

-- --------------------------------------------------------

--
-- Structure de la table `session`
--

CREATE TABLE `session` (
  `code` bigint(20) NOT NULL,
  `date_connection` datetime DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_deconnection` datetime DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `machine_cliente` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `utilisateur` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `session`
--

INSERT INTO `session` (`code`, `date_connection`, `date_creation`, `date_deconnection`, `date_modification`, `description`, `libelle`, `machine_cliente`, `signature`, `statut`, `statut_vie`, `createur`, `modificateur`, `utilisateur`) VALUES
(1, '2019-04-30 15:33:01', '2019-04-30 15:33:20', '2019-04-30 15:45:24', '2019-04-30 15:33:36', NULL, NULL, 'MA1', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 1),
(2, '2019-04-30 15:35:11', '2019-04-30 15:35:18', '2019-04-30 15:49:22', '2019-04-30 15:35:48', NULL, NULL, 'MA2', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 2),
(3, '2019-04-30 15:36:27', '2019-04-30 15:36:36', '2019-04-30 16:36:42', '2019-04-30 15:36:51', NULL, NULL, 'MA3', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 3),
(4, '2019-04-30 15:37:17', '2019-04-30 15:37:21', '2019-04-30 17:37:25', '2019-04-30 15:37:35', NULL, NULL, 'MA4', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 4),
(601, '2019-05-22 19:56:38', '2019-05-22 19:56:38', NULL, '2019-05-22 19:56:38', NULL, NULL, 'CRUNCH10', '1065256361', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(651, '2019-05-22 20:04:26', '2019-05-22 20:04:26', NULL, '2019-05-22 20:04:26', NULL, NULL, 'CRUNCH10', '-1569648338', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(701, '2019-05-22 20:10:49', '2019-05-22 20:10:49', NULL, '2019-05-22 20:10:49', NULL, NULL, 'CRUNCH10', '1865410461', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(751, '2019-05-22 20:17:39', '2019-05-22 20:17:39', NULL, '2019-05-22 20:17:39', NULL, NULL, 'CRUNCH10', '212184526', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(801, '2019-05-22 20:32:14', '2019-05-22 20:32:14', NULL, '2019-05-22 20:32:14', NULL, NULL, 'CRUNCH10', '21963020', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(851, '2019-05-22 20:35:23', '2019-05-22 20:35:23', NULL, '2019-05-22 20:35:23', NULL, NULL, 'CRUNCH10', '148076679', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(901, '2019-05-22 20:44:45', '2019-05-22 20:44:45', NULL, '2019-05-22 20:44:45', NULL, NULL, 'CRUNCH10', '-1516668111', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(951, '2019-05-22 20:50:27', '2019-05-22 20:50:27', NULL, '2019-05-22 20:50:27', NULL, NULL, 'CRUNCH10', '1465863697', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1001, '2019-05-22 22:28:10', '2019-05-22 22:28:10', NULL, '2019-05-22 22:28:10', NULL, NULL, 'CRUNCH10', '1898312775', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1051, '2019-05-22 22:44:16', '2019-05-22 22:44:16', NULL, '2019-05-22 22:44:16', NULL, NULL, 'CRUNCH10', '77862787', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1101, '2019-05-22 22:52:02', '2019-05-22 22:52:02', NULL, '2019-05-22 22:52:02', NULL, NULL, 'CRUNCH10', '299119551', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1151, '2019-05-22 22:53:10', '2019-05-22 22:53:10', NULL, '2019-05-22 22:53:10', NULL, NULL, 'CRUNCH10', '191662843', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1201, '2019-05-22 22:55:58', '2019-05-22 22:55:58', NULL, '2019-05-22 22:55:58', NULL, NULL, 'CRUNCH10', '-1666910466', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1251, '2019-05-22 22:58:04', '2019-05-22 22:58:04', NULL, '2019-05-22 22:58:04', NULL, NULL, 'CRUNCH10', '-987251049', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1301, '2019-05-22 23:00:09', '2019-05-22 23:00:09', NULL, '2019-05-22 23:00:09', NULL, NULL, 'CRUNCH10', '-2013791438', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1351, '2019-05-22 23:00:51', '2019-05-22 23:00:51', NULL, '2019-05-22 23:00:51', NULL, NULL, 'CRUNCH10', '61131718', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1401, '2019-05-23 04:39:17', '2019-05-23 04:39:17', NULL, '2019-05-23 04:39:17', NULL, NULL, 'CRUNCH10', '-112764396', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1451, '2019-05-23 04:49:28', '2019-05-23 04:49:28', NULL, '2019-05-23 04:49:28', NULL, NULL, 'CRUNCH10', '-169172942', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1501, '2019-05-23 04:55:02', '2019-05-23 04:55:02', NULL, '2019-05-23 04:55:02', NULL, NULL, 'CRUNCH10', '-937214768', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1551, '2019-05-23 04:56:19', '2019-05-23 04:56:19', NULL, '2019-05-23 04:56:19', NULL, NULL, 'CRUNCH10', '-1738070018', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1601, '2019-05-23 04:58:59', '2019-05-23 04:58:59', NULL, '2019-05-23 04:58:59', NULL, NULL, 'CRUNCH10', '1872928910', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1651, '2019-05-23 05:00:52', '2019-05-23 05:00:52', NULL, '2019-05-23 05:00:52', NULL, NULL, 'CRUNCH10', '-169182569', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1701, '2019-05-23 05:03:06', '2019-05-23 05:03:06', NULL, '2019-05-23 05:03:06', NULL, NULL, 'CRUNCH10', '-84545940', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1751, '2019-05-23 05:04:38', '2019-05-23 05:04:38', NULL, '2019-05-23 05:04:38', NULL, NULL, 'CRUNCH10', '1580808750', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1801, '2019-05-23 05:05:28', '2019-05-23 05:05:28', NULL, '2019-05-23 05:05:28', NULL, NULL, 'CRUNCH10', '-1558339174', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1851, '2019-05-23 05:08:24', '2019-05-23 05:08:24', NULL, '2019-05-23 05:08:24', NULL, NULL, 'CRUNCH10', '-199289746', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1901, '2019-05-23 05:10:03', '2019-05-23 05:10:03', NULL, '2019-05-23 05:10:03', NULL, NULL, 'CRUNCH10', '-869397587', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(1951, '2019-05-23 05:11:24', '2019-05-23 05:11:24', NULL, '2019-05-23 05:11:24', NULL, NULL, 'CRUNCH10', '1187230422', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2001, '2019-05-23 05:14:46', '2019-05-23 05:14:46', NULL, '2019-05-23 05:14:46', NULL, NULL, 'CRUNCH10', '-129811705', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2051, '2019-05-23 05:16:07', '2019-05-23 05:16:07', NULL, '2019-05-23 05:16:07', NULL, NULL, 'CRUNCH10', '-885445299', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2101, '2019-05-23 05:17:47', '2019-05-23 05:17:47', NULL, '2019-05-23 05:17:47', NULL, NULL, 'CRUNCH10', '-1637940485', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2151, '2019-05-23 05:18:55', '2019-05-23 05:18:55', NULL, '2019-05-23 05:18:55', NULL, NULL, 'CRUNCH10', '1773133977', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2201, '2019-05-23 05:19:52', '2019-05-23 05:19:52', NULL, '2019-05-23 05:19:52', NULL, NULL, 'CRUNCH10', '-548141960', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2251, '2019-05-23 05:40:25', '2019-05-23 05:40:25', NULL, '2019-05-23 05:40:25', NULL, NULL, 'CRUNCH10', '298013994', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2301, '2019-05-23 05:46:31', '2019-05-23 05:46:31', NULL, '2019-05-23 05:46:31', NULL, NULL, 'CRUNCH10', '-391744929', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2351, '2019-05-23 05:48:12', '2019-05-23 05:48:12', NULL, '2019-05-23 05:48:12', NULL, NULL, 'CRUNCH10', '-413031821', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2401, '2019-05-23 05:49:56', '2019-05-23 05:49:56', NULL, '2019-05-23 05:49:56', NULL, NULL, 'CRUNCH10', '1659694305', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2451, '2019-05-23 05:51:54', '2019-05-23 05:51:54', NULL, '2019-05-23 05:51:54', NULL, NULL, 'CRUNCH10', '-941885863', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2501, '2019-05-23 05:53:22', '2019-05-23 05:53:22', NULL, '2019-05-23 05:53:22', NULL, NULL, 'CRUNCH10', '1246775998', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2551, '2019-05-23 06:01:25', '2019-05-23 06:01:25', NULL, '2019-05-23 06:01:25', NULL, NULL, 'CRUNCH10', '29320510', 'ACTIF', 'ACTIVE', 1, 1, NULL),
(2601, '2019-05-23 06:04:33', '2019-05-23 06:04:33', NULL, '2019-05-23 06:04:33', NULL, NULL, 'CRUNCH10', '1556647731', 'ACTIF', 'ACTIVE', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sms`
--

CREATE TABLE `sms` (
  `code` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

--
-- Déchargement des données de la table `sms`
--

INSERT INTO `sms` (`code`) VALUES
(4),
(5),
(6);

-- --------------------------------------------------------

--
-- Structure de la table `specialite`
--

CREATE TABLE `specialite` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `filiere` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `specialite`
--

INSERT INTO `specialite` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut_vie`, `createur`, `filiere`, `modificateur`) VALUES
(1, '2019-04-11 07:56:37', '2019-04-11 07:56:37', NULL, 'genie logiciel', NULL, 'ACTIVE', 1, 1, 1),
(2, '2019-04-11 07:56:54', '2019-04-11 07:56:54', NULL, 'genie logiciel', NULL, 'ACTIVE', 1, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `type_evaluation`
--

CREATE TABLE `type_evaluation` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `pourcentage` float DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `enseignement` bigint(20) DEFAULT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_evaluation`
--

INSERT INTO `type_evaluation` (`code`, `date_creation`, `date_modification`, `description`, `libelle`, `pourcentage`, `signature`, `statut_vie`, `createur`, `enseignement`, `modificateur`) VALUES
(1, '2019-04-21 23:27:49', '2019-04-21 23:27:52', NULL, 'Controle continu', 30, NULL, 'ACTIVE', 1, 1, 1),
(2, '2019-04-21 23:28:35', '2019-04-21 23:28:37', NULL, 'Session normale', 70, NULL, 'ACTIVE', 1, 1, 1),
(3, '2019-04-21 23:29:18', '2019-04-21 23:29:22', NULL, 'Rattrapage', 70, NULL, 'ACTIVE', 1, 1, 1),
(4, '2019-04-21 23:32:32', '2019-04-21 23:32:32', NULL, 'Controle continu', 30, NULL, 'ACTIVE', 1, 2, 1),
(6, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Session normaale', 70, NULL, 'ACTIVE', 1, 2, 1),
(7, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Rattrapage', 70, NULL, 'ACTIVE', 1, 2, 1),
(8, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Controle continu', 20, NULL, 'ACTIVE', 1, 3, 1),
(9, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Session normale', 40, NULL, 'ACTIVE', 1, 3, 1),
(10, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Travaux pratiques', 40, NULL, 'ACTIVE', 1, 3, 1),
(11, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Rattrapages', 40, NULL, 'ACTIVE', 1, 3, 1),
(12, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Controle continu', 20, NULL, 'ACTIVE', 1, 4, 1),
(13, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Session normale', 40, NULL, 'ACTIVE', 1, 4, 1),
(14, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Travaux pratiques', 40, NULL, 'ACTIVE', 1, 4, 1),
(15, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Rattrapages', 40, NULL, 'ACTIVE', 1, 4, 1),
(16, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Controle continu', 30, NULL, 'ACTIVE', 1, 5, 1),
(17, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Session normale', 70, NULL, 'ACTIVE', 1, 5, 1),
(18, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Rattrapages', 70, NULL, 'ACTIVE', 1, 5, 1),
(19, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Controle continu', 30, NULL, 'ACTIVE', 1, 6, 1),
(20, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Session normale', 70, NULL, 'ACTIVE', 1, 6, 1),
(21, '2019-04-21 23:38:31', '2019-04-21 23:38:31', NULL, 'Rattrapages', 70, NULL, 'ACTIVE', 1, 6, 1);

-- --------------------------------------------------------

--
-- Structure de la table `ue`
--

CREATE TABLE `ue` (
  `code` bigint(20) NOT NULL,
  `code_ue` varchar(255) DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL,
  `module` bigint(20) DEFAULT NULL,
  `niveau` bigint(20) DEFAULT NULL,
  `specialite` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `ue`
--

INSERT INTO `ue` (`code`, `code_ue`, `credits`, `date_creation`, `date_modification`, `description`, `libelle`, `signature`, `statut`, `statut_vie`, `createur`, `modificateur`, `module`, `niveau`, `specialite`) VALUES
(1, 'MATH111', 3, '2019-05-20 21:49:15', '2020-01-02 12:30:00', NULL, 'mathématique', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 2, 3, 1),
(2, 'SECU20', 4, '2019-05-20 21:49:15', '2020-01-02 12:30:00', NULL, 'securité informatique', NULL, 'ACTIVE', 'ACTIVE', 1, 1, 2, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `code` bigint(20) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `date_naissance` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `sexe` varchar(255) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `statut` varchar(255) NOT NULL,
  `statut_vie` varchar(255) NOT NULL,
  `telephone` int(11) NOT NULL,
  `createur` bigint(20) NOT NULL,
  `modificateur` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`code`, `date_creation`, `date_modification`, `date_naissance`, `description`, `email`, `libelle`, `login`, `mot_de_passe`, `nom`, `prenom`, `sexe`, `signature`, `statut`, `statut_vie`, `telephone`, `createur`, `modificateur`) VALUES
(1, '2019-04-08 12:52:09', '2019-05-19 11:51:08', '1990-04-09 00:00:00', NULL, 'channeldonkeng@gmail.com', NULL, 'channel', 'BA-32-53-87-6A-ED-6B-C2-2D-4A-6F-F5-3D-84-6-C6-AD-86-41-95-ED-14-4A-B5-C8-76-21-B6-C2-33-B5-48-BA-EA-E6-95-6D-F3-46-EC-8C-17-F5-EA-10-F3-5E-E3-CB-C5-14-79-7E-D7-DD-D3-14-54-64-E2-A0-BA-B4-13', 'Donkeng', 'Channel', 'FEMININ', '853839448', 'ACTIVE', 'ACTIVE', 656307859, 1, 1),
(2, '2019-04-08 12:55:52', '2019-05-19 11:52:14', '1987-02-10 00:00:00', NULL, 'constantinnitcheu6@gmail.com', NULL, 'constantin', 'DF-6B-9F-B1-5C-FD-BB-75-27-BE-5A-8A-6E-39-F3-9E-57-2C-8D-DB-94-3F-BC-79-A9-43-43-8E-9D-3D-85-EB-FC-2C-CF-9E-E-CC-D9-34-60-26-C0-B6-87-6E-E-1-55-6F-E5-6F-13-55-82-C0-5F-BD-BB-50-5D-46-75-5A', 'Nitcheu', 'Constantin', 'MASCULIN', '442177959', 'ACTIVE', 'ACTIVE', 695585034, 1, 2),
(3, '2019-04-08 12:59:48', '2019-04-08 12:59:48', '1978-06-21 00:00:00', NULL, 'herve@gmail.com', NULL, 'jeanherve', 'isj123', 'JEAN', 'HERVE', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 690548932, 1, 1),
(4, '2019-04-08 13:03:59', '2019-04-08 13:03:59', '1984-04-17 00:00:00', NULL, 'emmamoupo@gmail.com', NULL, 'emmanuel', 'isj456', 'MOUPOJOU', 'EMMANUEL', 'MASCULIN', NULL, 'ACTIVE', 'ACTIVE', 698745621, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_role`
--

CREATE TABLE `utilisateur_role` (
  `code_utilisateur` bigint(20) NOT NULL,
  `code_role` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

--
-- Déchargement des données de la table `utilisateur_role`
--

INSERT INTO `utilisateur_role` (`code_utilisateur`, `code_role`) VALUES
(1, 1),
(1, 551),
(2, 2),
(3, 3),
(4, 4);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `annee_academique`
--
ALTER TABLE `annee_academique`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_annee_academique_createur` (`createur`) USING BTREE,
  ADD KEY `FK_annee_academique_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `anonymat`
--
ALTER TABLE `anonymat`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `signature` (`signature`),
  ADD KEY `FK_anonymat_createur` (`createur`),
  ADD KEY `FK_anonymat_note` (`note`),
  ADD KEY `FK_anonymat_modificateur` (`modificateur`),
  ADD KEY `FK_anonymat_est_inscrit` (`est_inscrit`),
  ADD KEY `FK_anonymat_evaluation` (`evaluation`);

--
-- Index pour la table `candidat`
--
ALTER TABLE `candidat`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`) USING BTREE,
  ADD UNIQUE KEY `telephone` (`telephone`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_candidat_classe` (`classe`) USING BTREE,
  ADD KEY `FK_candidat_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_candidat_createur` (`createur`) USING BTREE;

--
-- Index pour la table `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_classe_createur` (`createur`) USING BTREE,
  ADD KEY `FK_classe_niveau` (`niveau`) USING BTREE,
  ADD KEY `FK_classe_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_classe_specialite` (`specialite`) USING BTREE;

--
-- Index pour la table `discipline`
--
ALTER TABLE `discipline`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_discipline_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_discipline_createur` (`createur`) USING BTREE,
  ADD KEY `FK_discipline_semestre` (`semestre`) USING BTREE,
  ADD KEY `FK_discipline_etudiant` (`etudiant`) USING BTREE;

--
-- Index pour la table `droit`
--
ALTER TABLE `droit`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_droit_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_droit_role` (`role`) USING BTREE,
  ADD KEY `FK_droit_createur` (`createur`) USING BTREE;

--
-- Index pour la table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`code`) USING BTREE;

--
-- Index pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`) USING BTREE,
  ADD UNIQUE KEY `telephone` (`telephone`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_enseignant_createur` (`createur`) USING BTREE,
  ADD KEY `FK_enseignant_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `enseignement`
--
ALTER TABLE `enseignement`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_enseignement_ue` (`ue`) USING BTREE,
  ADD KEY `FK_enseignement_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_enseignement_createur` (`createur`) USING BTREE,
  ADD KEY `FK_enseignement_semestre` (`semestre`) USING BTREE;

--
-- Index pour la table `enseignement_enseignant`
--
ALTER TABLE `enseignement_enseignant`
  ADD PRIMARY KEY (`code_enseignant`,`code_enseignement`) USING BTREE,
  ADD KEY `FK_enseignement_enseignant_code_enseignement` (`code_enseignement`) USING BTREE;

--
-- Index pour la table `envoi_message`
--
ALTER TABLE `envoi_message`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_envoi_message_createur` (`createur`) USING BTREE,
  ADD KEY `FK_envoi_message_candidat` (`candidat`) USING BTREE,
  ADD KEY `FK_envoi_message_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_envoi_message_message` (`message`) USING BTREE;

--
-- Index pour la table `est_inscrit`
--
ALTER TABLE `est_inscrit`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_est_inscrit_candidat_inscrit` (`candidat_inscrit`) USING BTREE,
  ADD KEY `FK_est_inscrit_createur` (`createur`) USING BTREE,
  ADD KEY `FK_est_inscrit_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_est_inscrit_enseignement` (`enseignement`) USING BTREE;

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`code`) USING BTREE;

--
-- Index pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_evaluation_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_evaluation_type_evaluation` (`type_evaluation`) USING BTREE,
  ADD KEY `FK_evaluation_createur` (`createur`) USING BTREE;

--
-- Index pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_filiere_createur` (`createur`) USING BTREE,
  ADD KEY `FK_filiere_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `historique_note`
--
ALTER TABLE `historique_note`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_historique_note_note` (`note`) USING BTREE,
  ADD KEY `FK_historique_note_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_historique_note_createur` (`createur`) USING BTREE;

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_message_createur` (`createur`) USING BTREE,
  ADD KEY `FK_message_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_Module_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_Module_createur` (`createur`) USING BTREE;

--
-- Index pour la table `niveau`
--
ALTER TABLE `niveau`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_Niveau_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_Niveau_createur` (`createur`) USING BTREE;

--
-- Index pour la table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_note_est_inscrit` (`est_inscrit`) USING BTREE,
  ADD KEY `FK_note_createur` (`createur`) USING BTREE,
  ADD KEY `FK_note_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_note_evaluation` (`evaluation`) USING BTREE;

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_role_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_role_createur` (`createur`) USING BTREE;

--
-- Index pour la table `semestre`
--
ALTER TABLE `semestre`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_semestre_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_semestre_createur` (`createur`) USING BTREE,
  ADD KEY `FK_semestre_annee_academique` (`annee_academique`) USING BTREE;

--
-- Index pour la table `sequence`
--
ALTER TABLE `sequence`
  ADD PRIMARY KEY (`SEQ_NAME`) USING BTREE;

--
-- Index pour la table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_Session_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_Session_utilisateur` (`utilisateur`) USING BTREE,
  ADD KEY `FK_Session_createur` (`createur`) USING BTREE;

--
-- Index pour la table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`code`) USING BTREE;

--
-- Index pour la table `specialite`
--
ALTER TABLE `specialite`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_specialite_filiere` (`filiere`) USING BTREE,
  ADD KEY `FK_specialite_modificateur` (`modificateur`) USING BTREE,
  ADD KEY `FK_specialite_createur` (`createur`) USING BTREE;

--
-- Index pour la table `type_evaluation`
--
ALTER TABLE `type_evaluation`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_type_evaluation_enseignement` (`enseignement`) USING BTREE,
  ADD KEY `FK_type_evaluation_createur` (`createur`) USING BTREE,
  ADD KEY `FK_type_evaluation_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `ue`
--
ALTER TABLE `ue`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `signature` (`signature`),
  ADD KEY `FK_UE_niveau` (`niveau`),
  ADD KEY `FK_UE_modificateur` (`modificateur`),
  ADD KEY `FK_UE_specialite` (`specialite`),
  ADD KEY `FK_UE_module` (`module`),
  ADD KEY `FK_UE_createur` (`createur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`) USING BTREE,
  ADD UNIQUE KEY `login` (`login`) USING BTREE,
  ADD UNIQUE KEY `telephone` (`telephone`) USING BTREE,
  ADD UNIQUE KEY `signature` (`signature`) USING BTREE,
  ADD KEY `FK_utilisateur_createur` (`createur`) USING BTREE,
  ADD KEY `FK_utilisateur_modificateur` (`modificateur`) USING BTREE;

--
-- Index pour la table `utilisateur_role`
--
ALTER TABLE `utilisateur_role`
  ADD PRIMARY KEY (`code_utilisateur`,`code_role`) USING BTREE,
  ADD KEY `FK_utilisateur_role_code_role` (`code_role`) USING BTREE;

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `annee_academique`
--
ALTER TABLE `annee_academique`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `anonymat`
--
ALTER TABLE `anonymat`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `candidat`
--
ALTER TABLE `candidat`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `classe`
--
ALTER TABLE `classe`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `discipline`
--
ALTER TABLE `discipline`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `droit`
--
ALTER TABLE `droit`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=580;

--
-- AUTO_INCREMENT pour la table `email`
--
ALTER TABLE `email`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `enseignement`
--
ALTER TABLE `enseignement`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `envoi_message`
--
ALTER TABLE `envoi_message`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=402;

--
-- AUTO_INCREMENT pour la table `est_inscrit`
--
ALTER TABLE `est_inscrit`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `historique_note`
--
ALTER TABLE `historique_note`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT pour la table `module`
--
ALTER TABLE `module`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `niveau`
--
ALTER TABLE `niveau`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `note`
--
ALTER TABLE `note`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=552;

--
-- AUTO_INCREMENT pour la table `semestre`
--
ALTER TABLE `semestre`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `session`
--
ALTER TABLE `session`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2602;

--
-- AUTO_INCREMENT pour la table `sms`
--
ALTER TABLE `sms`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `specialite`
--
ALTER TABLE `specialite`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `type_evaluation`
--
ALTER TABLE `type_evaluation`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `ue`
--
ALTER TABLE `ue`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `code` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
