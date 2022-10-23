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

ALTER SESSION SET CURRENT_SCHEMA="SIMONDUCHESNE1";
DROP TABLE Personne;
DROP TABLE Enseignant;
DROP TABLE Etudiant;
DROP TABLE Departement;
DROP TABLE SessionEcole;
DROP TABLE Groupe;
DROP TABLE Status;
DROP TABLE DonneesProfessionel;
DROP TABLE Local;
DROP TABLE PlageHoraire;
DROP TABLE Cours;
DROP TABLE Prealable;

-----------------------------------------------------------------------------------------------------------------------
--                                      Table Personne
-----------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Etudiant
-----------------------------------------------------------------------------------------------------------------------
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
ALTER TABLE Etudiant ADD PRIMARY KEY (numTelephone);


-----------------------------------------------------------------------------------------------------------------------
--                                      Table Enseignant
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Enseignant(
    --Attributs
    numTelephone        VARCHAR(255),
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
ALTER TABLE Enseignant ADD PRIMARY KEY (numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Departement
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Departement(
    iDdepartement               INTEGER ,
    nom                         VARCHAR(255),
    numDepartement              INTEGER,
    numTelDuDirecteur           VARCHAR(255),
    -- Primary key
    CONSTRAINT PK_Departement
        PRIMARY KEY (iDdepartement),
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
-----------------------------------------------------------------------------------------------------------------------
--                                      Table DonneesProfessionel
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE DonneesProfessionel(
    numTelephone VARCHAR(255),
    telephoneProfessionel INTEGER,
    localBureau INTEGER,
    courriel VARCHAR(255),
    CONSTRAINT FK_DonneesProfessionel_Enseignant
                                FOREIGN KEY (numTelephone)
                                REFERENCES Enseignant(numTelephone)
);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table DonneesProfessionel
--                      Ne peut pas être Session, Session est un mot réservé.
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE SessionEcole(
    annee INTEGER,
    saison VARCHAR(7),
    CONSTRAINT CHECK ( saison IN ('Hiver','Été','Automne')),
    CONSTRAINT PK_SessionEcole
        PRIMARY KEY (Annee,saison)
);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Groupe
-- Primary key: (idGroupe)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Groupe(
  idGroupe INTEGER,
  numGroupe VARCHAR(15),
  etat VARCHAR(8)
);
ALTER TABLE Groupe ADD PRIMARY KEY (idGroupe);
Alter TABLE Groupe ADD CHECK (etat IN ('Annulé', 'En Cours', 'Terminé'));
CREATE SEQUENCE Groupe_idGroupe_sequence START WITH 1;
CREATE OR REPLACE TRIGGER Groupe_idGroupe_sequence
    BEFORE INSERT ON Groupe
    FOR EACH ROW
    BEGIN
        SELECT Groupe_idGroupe_sequence.nextval
        INTO :new.idGroupe
        FROMdual;
        END;
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Status
--                      Table de relation (0..n-0..n) De étudiant à Groupe.
-- Primary key: (idGrouepe.Groupe, numTelephone.Etudiant)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Status(
    cote CHAR(1),
    idGroupe INTEGER, -- reference idGtoupe.groupe
    numTelephone VARCHAR(30) --Reference numTelephone.Etudiant
);
ALTER TABLE Status ADD CHECK (cote IN ('A','B','C','D','E','S','I','X','Y','Z') );
ALTER TABLE Status ADD FOREIGN KEY (idGroupe)
                     REFERENCES Groupe(idGroupe);
ALTER TABLE Status ADD FOREIGN KEY (numTelephone)
                    REFERENCES Etudiant(numTelephone);
ALTER TABLE Status ADD PRIMARY KEY (idGroupe, numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Local
-- Primary key (numero.Local,aile.Local,etage.Local)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Local(
    numero INTEGER,
    aile CHAR(1),
    etage INTEGER
);
ALTER TABLE Local ADD CONSTRAINT PK_lodal PRIMARY KEY (numero,aile,etage);
AlTER TABLE Local ADD CONSTRAINT Local_aile_check CHECK (aile IN ('D','V','P','K','G','A','H','S','F','M','B','T','R','U'));
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Cours
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Cours(
    sigleDuCours                VARCHAR(255),
    titreCours                  VARCHAR(255),
    enseignantResponsable       VARCHAR(30),
    nombreCredit                INTEGER,
    heureTotalCours             INTEGER,
    heureLab                    INTEGER,
    heurePerso                  INTEGER,
    sessionDuCours              VARCHAR(8)
);
ALTER TABLE Cours ADD CONSTRAINT PK_Cours PRIMARY KEY (sigleDuCours);
ALTER TABLE Cours ADD CONSTRAINT FK_Cours_Enseignant_EnseignantResponsable
    FOREIGN KEY (enseignantResponsable)
    REFERENCES Enseignant(numTelephone);
ALTER TABLE Cours ADD CONSTRAINT Cours_sessionDuCours_CHECK CHECK ( sessionDuCours IN ('Hiver','Été','Automne'));
-----------------------------------------------------------------------------------------------------------------------
--                                      Table PlageHoraire
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE PlageHoraire( --todo add keys
    typeDeCours VARCHAR(16),
    jourEtHeure DATE,
    idGroupe INTEGER,
);
ALTER TABLE PlageHoraire
    ADD CONSTRAINT PlageHoraire_typeDeCours_check
    CHECK (typeDeCours IN ('Laboratoire','Travaux Dirigés','Cours'));
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Prealable
--                      Table de relation d'un Cours à Cours, (1 1..n)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Prealable(
    coursPrincipal, --todo fk
    coursPrealable --todo fk
);
--todo Foreign keys
--todo prim key

