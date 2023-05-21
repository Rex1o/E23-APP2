
CREATE TABLE Faculte
(
  nom VARCHAR NOT NULL,
  fac_id INT NOT NULL,
  PRIMARY KEY (fac_id)
);

CREATE TABLE Departement
(
  dep_id INT NOT NULL,
  nom INT NOT NULL,
  fac_id INT NOT NULL,
  PRIMARY KEY (dep_id),
  FOREIGN KEY (fac_id) REFERENCES Faculte(fac_id)
);

CREATE TABLE Status
(
  status_id INT NOT NULL,
  description VARCHAR NOT NULL,
  PRIMARY KEY (status_id)
);

CREATE TABLE Campus
(
  camp_id INT NOT NULL,
  nom VARCHAR NOT NULL,
  PRIMARY KEY (camp_id)
);

CREATE TABLE Pavillon
(
  pav_id CHAR(3) NOT NULL,
  nom VARCHAR NOT NULL,
  camp_id INT NOT NULL,
  PRIMARY KEY (pav_id),
  FOREIGN KEY (camp_id) REFERENCES Campus(camp_id)
);

CREATE TABLE Fonction
(
  fonc_id INT NOT NULL,
  description VARCHAR NOT NULL,
  PRIMARY KEY (fonc_id)
);

CREATE TABLE Caracteristique
(
  carac_id INT NOT NULL,
  desciption VARCHAR NOT NULL,
  PRIMARY KEY (carac_id)
);

CREATE TABLE Categorie
(
  cat_id INT NOT NULL,
  description INT NOT NULL,
  PRIMARY KEY (cat_id)
);

CREATE TABLE Membre
(
  cip CHAR(8) NOT NULL,
  status_id INT NOT NULL,
  dep_id INT NOT NULL,
  PRIMARY KEY (cip),
  FOREIGN KEY (status_id) REFERENCES Status(status_id),
  FOREIGN KEY (dep_id) REFERENCES Departement(dep_id)
);

CREATE TABLE Local
(
  numero_local INT NOT NULL,
  cat_id INT NOT NULL,
  pav_id CHAR(3) NOT NULL,
  fonc_id INT NOT NULL,
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