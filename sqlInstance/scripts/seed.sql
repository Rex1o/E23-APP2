-- Creation campus
INSERT INTO campus(nom)
VALUES ('Principale'),
('Longeuil'),
('Santé');

--Creation de faculté
INSERT INTO faculte(nom)
VALUES ('Droit')
     ,('École de gestion')
     ,('Éducation')
     ,('Génie')
     ,('Lettres et sciences humaines')
     ,('École de musique')
     ,('Sciences')
     ,('Sciences de l''activité physique');

-- On répète de l'information, est-ce que c'est si grave que ça?
-- Certains noms de pavillons ont plus que un numéro
-- Certaines facultés on plus que un numéro
INSERT INTO pavillon(pav_id, nom, camp_id, fac_id)
VALUES ('A8','Albert-Leblanc', 1, null)
,('A9','Albert-Leblanc',1, 1)
,('J1','Centre sportif Yvon-Lamarche',1, null)
,('J2','Centre sportif Yvon-Lamarche',1, null)
,('B1','George-Cabana',1, null)
,('B2','George-Cabana',1, null)
,('B6','Irené-Pinard', 1, null)
,('C1','J.-Armand-Bombardier',1, 4)
,('C2','J.-Armand-Bombardier',1,4)
,('C4','Studio de création',1,4)
,('F1','John-S.-Bourque',1,null)
,('D6','Marie-Victorin',1, 7)
,('D7','Marie-Victorin',1, 7)
,('B5','Multifonctionnel',1, null)
,('A10','Recherche en sciences humaines et sociales',1, null)
,('D8','Science de la vie',1, 7)
,('E5','Vie étudiante',1, null)
,('H15','Pavillon des gens pas cool',2, null);

-- Creation des fonctions
INSERT INTO fonction(fonc_id, description)
VALUES ('0110', 'Salle de classe générale')
,('0111', 'Salle de classe spécialisée')
,('0120', 'Salle de séminaire')
,('0121', 'Cubicules')
,('0210', 'Laboratoire informatique')
,('0211', 'Laboratoire d’enseignement spécialisé')
,('0212', 'Atelier')
,('0213', 'Salle à dessin')
,('0214', 'Atelier (civil)')
,('0215', 'Salle de musique')
,('0216', 'Atelier sur 2 étages, conjoint avec autre local')
,('0217', 'Salle de conférence')
,('0372', 'Salle de réunion')
,('0373', 'Salle d’entrevue et de tests')
,('0510', 'Salle de lecture ou de consultation')
,('0620', 'Auditorium')
,('0625', 'Salle de concert')
,('0640', 'Salle d’audience')
,('0930', 'Salon du personnel')
,('1030', 'Studio d’enregistrement')
,('1260', 'Hall d’entrée');

-- Creation des caractéristiques
INSERT INTO caracteristique(carac_id, desciption)
VALUES (0 , 'Connexion à Internet')
,(1 , 'Tables fixes en U et chaises mobiles')
,(2 , 'Monoplaces')
,(3 , 'Tables fixes et chaises fixes')
,(6 , 'Tables pour 2 ou + et chaises mobiles')
,(7 , 'Tables mobiles et chaises mobiles')
,(8 , 'Tables hautes et chaises hautes')
,(9 , 'Tables fixes et chaises mobiles')
,(11, 'Écran')
,(14, 'Rétroprojecteur')
,(15, 'Gradins')
,(16, 'Fenêtres')
,(17, 'piano')
,(19, 'Autres instruments')
,(20, 'Système de son')
,(21, 'Salle réservée (spéciale)')
,(22, 'Ordinateurs PC')
,(23, 'Ordinateurs SUN pour génie électrique')
,(25, 'Ordinateurs (oscillomètre et multimètre)')
,(26, 'Ordinateurs modélisation des structures')
,(28, 'Équipement pour microélectronique')
,(29, 'Équipement pour génie électrique')
,(30, 'Ordinateurs et équipement pour mécatroni')
,(31, 'Équipement métrologie')
,(32, 'Équipement de machinerie')
,(33, 'Équipement de géologie')
,(34, 'Équipement pour la caractérisation')
,(35, 'Équipement pour la thermodynamique')
,(36, 'Équipement pour génie civil')
,(37, 'Télévision')
,(38, 'VHS')
,(39, 'Hauts parleurs')
,(40, 'Micro')
,(41, 'Magnétophone à cassette')
,(42, 'Amplificateur audio')
,(43, 'Local barré')
,(44, 'Prise réseau');

--Creation des prévilèges
INSERT INTO privilege(description)
VALUES ('Peut réserver plus de 24 heures')
,('Peut seulement voir les réservations mais pas en créer')
,('Peut effacer les réservations d’un autre usager');

--Creation statu
INSERT INTO statut(description, privi_id)
VALUES ('Étudiants',null)
     ,('Enseignants',1)
     ,('Personnel de soutien',2)
     ,('Administrateurs',3);

--Creation catégories
INSERT INTO categorie(description)
VALUES ('GEGI - Salle de tutorat')
,('GEGI - Salle de projet')
,('GEGI - Laboratoire')
,('GEGI - Laboratoire spécialisé')
,('GEGI - Salle de réunion')
,('Génie - Amphithéatre (40 places et -)')
,('Génie - Amphithéatre (81 places et +)')
,('Génie - Laboratoire informatique')
,('GCGB - Laboratoire informatique')
,('Cubicule - 3035')
,('Cubicule - 3041')
,('Cubicule - 4103')
,('Cubicule - 4113')
,('Cubicule - 4115')
,('Cubicule - Bureau Chargé de cours');


--Creation des départements
INSERT INTO departement(nom, fac_id)
VALUES ('Génie électrique et Génie informatique',4)
,('Génie mécanique',4)
,('Génie chimique et biotechnologie',4)
,('Génie civil et du bâtiment',4)
,('Biologie',7)
,('Chimie',7)
,('Informatique',7)
,('Mathématiques',7)
,('Physique',7);

--Creation des membres
INSERT INTO membre(cip, statut_id, dep_id)
VALUES ('hluv5927', 4, 8)
,('nnhe9875', 4, 5)
,('dcwt8838', 1, 4)
,('zumo7081', 2, 2)
,('eigy7463', 3, 4)
,('wmkw5636', 1, 3)
,('vhbj6237', 2, 3)
,('zhxm5663', 3, 4)
,('yzpp0272', 4, 4)
,('oagr2020', 1, 8);

--Creation des locaux
INSERT INTO Local(numero_local, cat_id, pav_id, fonc_id, id_local_parent, id_pav_parent)
VALUES
(3007, 7, 'C1', '0372', NULL, NULL)
,(4008, 3, 'C1', '0372', NULL, NULL)
,(4016, 7, 'C1', '0372', NULL, NULL)
,(4023, 7, 'C1', '0372', NULL, NULL)
,(5001, 4, 'C1', '0372', NULL, NULL)
,(5006, 7, 'C1', '0372', NULL, NULL)
,(3016, 1, 'D7', '0372', NULL, NULL);

INSERT INTO reservation(debut, fin, commentaire, cip, numero_local, pav_id)
VALUES
(make_timestamp(2023, 5, 23, 9, 30, 0), make_timestamp(2023, 5, 23, 12, 30, 0), 'Faculte Genie activite pedagogiques de lhivers - GCI756-01 - Magistral', 'vhbj6237', 3007, 'C1')
,(make_timestamp(2023, 5, 23, 8, 30, 0), make_timestamp(2023, 5, 23, 11, 30, 0), 'Faculte Genie session 7 - IMC500-01 - Magistral', 'vhbj6237', 4008, 'C1')
,(make_timestamp(2023, 5, 23, 13, 30, 0), make_timestamp(2023, 5, 23, 17, 0, 0), 'Departement GEGI session 5 genie electrique - APP 7 - Examen sommatif - Theorique', 'vhbj6237', 4008, 'C1')
,(make_timestamp(2023, 5, 23, 9, 30, 0), make_timestamp(2023, 5, 23, 12, 30, 0), 'Faculte Genie session 5 - IMC450-01 - Magistral', 'vhbj6237', 4016, 'C1')
,(make_timestamp(2023, 5, 23, 13, 30, 0), make_timestamp(2023, 5, 23, 16, 30, 0), 'Faculte Genie session 2 - GCI190-01 - Magistral', 'vhbj6237', 4016, 'C1')
,(make_timestamp(2023, 5, 23, 8, 30, 0), make_timestamp(2023, 5, 23, 11, 30, 0), 'Faculte Genie session 4 - IMC310-01 - Magistral', 'vhbj6237', 4023, 'C1')
,(make_timestamp(2023, 5, 23, 11, 30, 0), make_timestamp(2023, 5, 23, 12, 30, 0), 'Faculte Genie session 4 - IMC310-02 - Magistral', 'vhbj6237', 4023, 'C1')
,(make_timestamp(2023, 5, 23, 9, 0, 0), make_timestamp(2023, 5, 23, 10, 30, 0), 'Departement GEGI session 2 genie electrique', 'vhbj6237', 5001, 'C1')
,(make_timestamp(2023, 5, 23, 10, 30, 0), make_timestamp(2023, 5, 23, 12, 30, 0), 'Faculte Genie session 2 - GCH323-01 - Exercices', 'vhbj6237', 5001, 'C1')
,(make_timestamp(2023, 5, 23, 12, 30, 0), make_timestamp(2023, 5, 23, 16, 30, 0), 'France Jacques ING260-', 'vhbj6237', 5001, 'C1')
,(make_timestamp(2023, 5, 23, 8, 30, 0), make_timestamp(2023, 5, 23, 13, 30, 0), 'Faculte Genie activites pedagogiques de lhiver - MEC002', 'vhbj6237', 5006, 'C1')
,(make_timestamp(2023, 5, 23, 9, 30, 0), make_timestamp(2023, 5, 23, 12, 30, 0), 'Faculte Genie session 5 GCI320-01 - Magistral', 'vhbj6237', 3016, 'D7')
,(make_timestamp(2023, 5, 23, 12, 30, 0), make_timestamp(2023, 5, 23, 13, 30, 0), 'Faculte Genie session 5 GCI002-01 - Magistral', 'vhbj6237', 3016, 'D7');



