--********************************************************************************************
--                                  Légendes
--********************************************************************************************
--                              Convention de nom
-- NomDeTable
-- attributDUneTable
--
--********************************************************************************************
--                                  Acronymes
--  PK_: Primary key / Clef primaire
--  FK_: Foreign Key / Clef Étrangère
--********************************************************************************************
-- Ensure name are not already used
DROP TABLE Personne;
DROP TABLE Enseignant;
DROP TABLE Etudiant;
DROP TABLE Departement;
DROP TABLE Session;
DROP TABLE Groupe;
DROP TABLE Status;
DROP TABLE DonneesPrefessionel;
DROP TABLE Local;
DROP TABLE PlageHoraire;
DROP TABLE Cours;
DROP TABLE Prealable;
--table: Personne
CREATE TABLE Personne(
    --Attributes
    numTelephone varchar(30) NOT NULL ,
    Nom varchar(255) NOT NULL ,
    Prenom varchar(255) NOT NULL ,
    numAdressSocial varchar(255) NOT NULL ,
    DateDeNaisssance date NOT NULL,
    --Constraint
    CONSTRAINT PK_persone PRIMARY KEY (numTelephone)
);

--table: Etudiant
CREATE TABLE Etudiant(
    --Attributes
    numTelephone VARCHAR(30),
    CodePermanent VARCHAR(255),
    AdresseCivique VARCHAR(255),
    Courriel VARCHAR(255),
    CourrielUqac VARCHAR(255),
    Statut domain --TODO domaine de statut
    --constraint
    --Foreign key, numTelephone.Personne
);

CREATE TABLE Enseignant(
    numTelephone VARCHAR(255),
    dateEmbauche DATE,
    AdresseCivique VARCHAR(255),
    Statut DOMAIN --TODO domain
);

CREATE TABLE Departement(
    iDdepartement INTEGER,
    nom VARCHAR(255),
    numDepartement INTEGER,
    directeur -- todo liaison vers un enseignant
);

CREATE TABLE DonneesPrefessionel(
    numTelephone VARCHAR(255), --todo foreign key
    telephoneProfessionel INTEGER,
    localBureau INTEGER,
    courriel VARCHAR(255)
);

CREATE TABLE Session(
    iDSession INTEGER,
    annee INTEGER,
    saison,  -- todo domain
);

CREATE TABLE Groupe(
  idGroupe INTEGER,
  numGroupe VARCHAR,
  etat, -- todo domain
);

CREATE TABLE Status(
    cote, -- todo domain
    --todo foreign key
);

CREATE TABLE Local(
    iDLocal INTEGER,
    numero INTEGER,
    aile , --todo domain
    etage INTEGER
);

CREATE TABLE PlageHoraire(
    typeDeCours ,--todo domain
    jourEtHeure
);

CREATE TABLE Cours(
    sigleDuCours VARCHAR(255),
    titreCours VARCHAR(255),
    enseignantResponsable Personne,
    nombreCredit INTEGER,
    heureTotalCours INTEGER,
    heureLab INTEGER,
    heurePerso INTEGER,
    sessionDuCours DOMAIN
);

CREATE TABLE Prealable(
    coursPrincipal, --todo fk
    coursPrealable --todo fk
);


--Foreign keys