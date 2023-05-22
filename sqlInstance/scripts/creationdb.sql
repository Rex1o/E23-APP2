
CREATE TABLE Faculte
(
  fac_id SERIAL PRIMARY KEY ,
  nom VARCHAR NOT NULL
);

CREATE TABLE Departement
(
  dep_id SERIAL PRIMARY KEY,
  nom VARCHAR NOT NULL,
  fac_id INT NOT NULL,
  FOREIGN KEY (fac_id) REFERENCES Faculte(fac_id)
);

CREATE TABLE Previlege
(
  previ_id SERIAL PRIMARY KEY,
  description VARCHAR NOT NULL
);

CREATE TABLE Statut
(
  statut_id SERIAL PRIMARY KEY,
  description VARCHAR NOT NULL,
  previ_id INT NOT NULL,
  FOREIGN KEY (previ_id) REFERENCES Previlege(previ_id)
);

CREATE TABLE Campus
(
  camp_id SERIAL PRIMARY KEY,
  nom VARCHAR NOT NULL
);

CREATE TABLE Pavillon
(
  pav_id CHAR(3) NOT NULL,
  nom VARCHAR NOT NULL,
  camp_id INT NOT NULL,
  fac_id INT,
  PRIMARY KEY (pav_id),
  FOREIGN KEY (camp_id) REFERENCES Campus(camp_id),
  FOREIGN KEY (fac_id) REFERENCES Faculte(fac_id)
);

CREATE TABLE Fonction
(
  fonc_id CHAR(4) NOT NULL,
  description VARCHAR NOT NULL,
  PRIMARY KEY (fonc_id)
);

CREATE TABLE Caracteristique
(
  carac_id SERIAL PRIMARY KEY ,
  desciption VARCHAR NOT NULL
);

CREATE TABLE Categorie
(
  cat_id SERIAL PRIMARY KEY,
  description VARCHAR NOT NULL,
  previ_id INT NOT NULL,
  FOREIGN KEY (previ_id) REFERENCES Previlege(previ_id)
);

CREATE TABLE Membre
(
  cip CHAR(8) NOT NULL,
  statut_id INT NOT NULL,
  dep_id INT NOT NULL,
  PRIMARY KEY (cip),
  FOREIGN KEY (statut_id) REFERENCES Statut(statut_id),
  FOREIGN KEY (dep_id) REFERENCES Departement(dep_id)
);

CREATE TABLE Local
(
  numero_local INT NOT NULL,
  cat_id INT NOT NULL,
  pav_id CHAR(3) NOT NULL,
  fonc_id CHAR(4) NOT NULL,
  FOREIGN KEY (cat_id) REFERENCES Categorie(cat_id),
  FOREIGN KEY (pav_id) REFERENCES Pavillon(pav_id),
  FOREIGN KEY (fonc_id) REFERENCES Fonction(fonc_id),
  PRIMARY KEY (pav_id, numero_local)
);

CREATE TABLE RelationsCaracteristique
(
  carac_id INT NOT NULL,
  numero_local INT NOT NULL,
  pav_id CHAR(3) NOT NULL,
  FOREIGN KEY (carac_id) REFERENCES Caracteristique(carac_id),
  FOREIGN KEY (pav_id, numero_local) REFERENCES Local(pav_id, numero_local)
);

CREATE TABLE Reservation
(
  debut DATE NOT NULL,
  fin DATE NOT NULL,
  commentaire VARCHAR,
  cip CHAR(8) NOT NULL,
  numero_local INT NOT NULL,
  pav_id CHAR(3) NOT NULL,
  FOREIGN KEY (cip) REFERENCES Membre(cip),
  FOREIGN KEY (pav_id, numero_local) REFERENCES Local(pav_id, numero_local)
);