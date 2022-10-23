--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
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


CREATE TABLE Personne(
    --Attributes
    numTelephone        varchar(30)     NOT NULL ,
    Nom                 varchar(255)    NOT NULL ,
    Prenom              varchar(255)    NOT NULL ,
    numAdressSocial     varchar(255)    NOT NULL ,
    DateDeNaisssance    date            NOT NULL ,
    --PRIMARY KEY
   CONSTRAINT PK_numTelephone PRIMARY KEY (numTelephone)
);

CREATE TABLE Etudiant(
    --Attributs
    numTelephone        VARCHAR(30) NOT NULL,
    CodePermanent       VARCHAR(255),
    AdresseCivique      VARCHAR(255),
    Courriel            VARCHAR(255),
    CourrielUqac        VARCHAR(255),
    etat                CHAR,
        --le statut de l’étudiant (le statut correspond à un caractère parmi les suivants : C pour études en cours, A pour
        --abandon du programme, T pour études terminées avec succès, S pour suspendu et P pour pause temporaire
        --autorisée)
    --constraint
    CONSTRAINT FK_Etudiant_Personne
                     FOREIGN KEY (numTelephone)
                     REFERENCES Personne(numTelephone)
);
ALTER TABLE Etudiant
    ADD     CONSTRAINT etat_in_domain_check CHECK ( etat IN ('C','A','T','P') );



CREATE TABLE Enseignant(
    --Attributs
    numTelephone        VARCHAR(255)    UNIQUE,
    dateEmbauche        DATE,
    AdresseCivique      VARCHAR(255),
    statut              CHAR,
    --FOREIGN KEY
    CONSTRAINT FK_Enseignant_Personne
                     FOREIGN KEY (numTelephone)
                     REFERENCES Personne(numTelephone)
);

ALTER TABLE Enseignant
    ADD     CONSTRAINT etat_of_Etudiant_in_domain_check CHECK ( statut IN ('C','A','T','P') );



CREATE TABLE Departement(
    iDdepartement               INTEGER , -- todo autoincrement
    nom                         VARCHAR(255),
    numDepartement              INTEGER,
    numTelDuDirecteur           VARCHAR(255),
    -- Primary key
    CONSTRAINT PK_Departement PRIMARY KEY (iDdepartement),
    -- Foreign key
    CONSTRAINT FK_Departement_Enseignant
                        FOREIGN KEY (numTelDuDirecteur)
                        REFERENCES Enseignant(numTelephone)
);
-- Auto increment of Departement for idDepartement
CREATE SEQUENCE departement_sequence START WITH 1;
CREATE OR REPLACE TRIGGER Departement_trigger_autoincrement
    BEFORE INSERT ON Departement
    FOR EACH ROW
    BEGIN
        SELECT departement_sequence.nextval
        INTO :new.iDdepartement
        FROMdual;
        END;


CREATE TABLE DonneesPrefessionel(
    numTelephone VARCHAR(255), --todo foreign key
    telephoneProfessionel INTEGER,
    localBureau INTEGER,
    courriel VARCHAR(255)

);

CREATE TABLE Session(
    iDSession INTEGER,
    annee INTEGER,
    saison VARCHAR(7),
    CONSTRAINT CHECK ( saison IN ('Hiver','Été','Automne'))
);

CREATE TABLE Groupe(
  idGroupe INTEGER,
  numGroupe VARCHAR(15),
  etat VARCHAR(8),
  CONSTRAINT CHECK (etat IN ('Annulé', 'En Cours', 'Terminé'))
);

CREATE TABLE Status(
    cote CHAR(1),
    --todo foreign key
    CONSTRAINT CHECK ( cote IN ('A','B','C','D','E','S','I','X','Y','Z') )
);

CREATE TABLE Local(
    iDLocal INTEGER,
    numero INTEGER,
    aile CHAR(1),
    etage INTEGER,
    CONSTRAINT CHECK (aile IN ('D','V','P','K','G','A','H','S','F','M','B','T','R','U'))
);

CREATE TABLE PlageHoraire(
    typeDeCours VARCHAR(16),
    jourEtHeure DATE,
    CONSTRAINT CHECK ( typeDeCours IN ('Laboratoire','Travaux Dirigés','Cours') )
);

CREATE TABLE Cours(
    sigleDuCours VARCHAR(255),
    titreCours VARCHAR(255),
    enseignantResponsable Personne, -- todo FK
    nombreCredit INTEGER,
    heureTotalCours INTEGER,
    heureLab INTEGER,
    heurePerso INTEGER,
    sessionDuCours VARCHAR(8),
    CONSTRAINT CHECK ( sessionDuCours IN ('Hiver','Été','Automne'))
    --todo FK
    --todo pk
);

CREATE TABLE Prealable(
    coursPrincipal, --todo fk
    coursPrealable --todo fk
);
--Foreign keys

