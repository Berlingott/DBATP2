--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier de creation de la base de données
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
-----------------------------------------------------------------------------------------------------------------------
--                                      DROP ALL SECTION
-----------------------------------------------------------------------------------------------------------------------
--SEQUENCE
drop sequence DEPARTEMENT_SEQUENCE
/
drop sequence GROUPE_IDGROUPE_SEQUENCE
/
--TABLE
drop table DEPARTEMENT
/
drop table DONNEESPROFESSIONEL
/
drop table SESSIONECOLE
/
drop table STATUS
/
drop table ETUDIANT
/
drop table LOCAL
/
drop table PLAGEHORAIRE
/
drop table GROUPE
/
drop table PREALABLE
/
drop table COURS
/
drop table ENSEIGNANT
/
drop table PERSONNE
/
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Personne
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Personne(
    numTelephone        varchar(30)     NOT NULL,
    Nom                 varchar(255)    NOT NULL,
    Prenom              varchar(255)    NOT NULL,
    numAdressSocial     varchar(255)    NOT NULL,
    DateDeNaisssance    date            NOT NULL
);
ALTER TABLE Personne
    ADD CONSTRAINT PK_numTelephone
    PRIMARY KEY (numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Etudiant
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Etudiant(
    numTelephone        VARCHAR(30)     NOT NULL,
    CodePermanent       VARCHAR(255)    NOT NULL,
    AdresseCivique      VARCHAR(255)    NOT NULL,
    Courriel            VARCHAR(255)    NOT NULL,
    CourrielUqac        VARCHAR(255)    NOT NULL,
    etat                CHAR            NOT NULL
);
ALTER TABLE Etudiant
    ADD CONSTRAINT FK_Etudiant_Personne
    FOREIGN KEY (numTelephone)
    REFERENCES Personne(numTelephone);
ALTER TABLE Etudiant
    ADD CONSTRAINT etat_in_domain_check
    CHECK ( etat IN ('C','A','T','P') );
ALTER TABLE Etudiant
    ADD PRIMARY KEY (numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Enseignant
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Enseignant(
    numTelephone        VARCHAR(255)    NOT NULL,
    dateEmbauche        DATE            DEFAULT CURRENT_TIMESTAMP,
    AdresseCivique      VARCHAR(255)    NOT NULL,
    statut              CHAR            NOT NULL
);
ALTER TABLE Enseignant
    ADD CONSTRAINT FK_Enseignant_Personne
    FOREIGN KEY (numTelephone)
    REFERENCES Personne(numTelephone);
ALTER TABLE Enseignant
    ADD CONSTRAINT etat_of_Etudiant_in_domain_check
    CHECK ( statut IN ('C','A','T','P') );
ALTER TABLE Enseignant ADD PRIMARY KEY (numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Departement
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Departement(
    iDdepartement               INTEGER,
    nom                         VARCHAR(255)    NOT NULL,
    numDepartement              INTEGER         NOT NULL,
    numTelDuDirecteur           VARCHAR(255)    NOT NULL
);
ALTER TABLE Departement
    ADD CONSTRAINT PK_Departement
    PRIMARY KEY (iDdepartement);
ALTER TABLE Departement
    ADD CONSTRAINT FK_Departement_Enseignant
    FOREIGN KEY (numTelDuDirecteur)
    REFERENCES Enseignant(numTelephone);
------
-- Auto increment of Departement for idDepartement
------
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
    numTelephone            VARCHAR(255),
    telephoneProfessionel   INTEGER         NOT NULL,
    localBureau             INTEGER         NOT NULL,
    courriel                VARCHAR(255)    NOT NULL
);
ALTER TABLE DonneesProfessionel
    ADD CONSTRAINT FK_DonneesProfessionel_Enseignant
    FOREIGN KEY (numTelephone)
    REFERENCES Enseignant(numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table DonneesProfessionel
--                      Ne peut pas être Session, Session est un mot réservé.
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE SessionEcole(
    annee   INTEGER     NOT NULL,
    saison  VARCHAR(7)  NOT NULL
);
ALTER TABLE SessionEcole
    ADD CONSTRAINT sessionEcoleCheck
    CHECK ( saison IN ('Hiver','Été','Automne'));
ALTER TABLE SessionEcole
    ADD CONSTRAINT PK_SessionEcole
    PRIMARY KEY (Annee,saison);

-----------------------------------------------------------------------------------------------------------------------
--                                      Table Cours
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Cours(
    sigleDuCours                VARCHAR(255),
    titreCours                  VARCHAR(255)    NOT NULL,
    enseignantResponsable       VARCHAR(30)     NOT NULL,
    nombreCredit                INTEGER         NOT NULL,
    heureTotalCours             INTEGER         NOT NULL,
    heureLab                    INTEGER         NOT NULL,
    heurePerso                  INTEGER         NOT NULL,
    sessionDuCours              VARCHAR(8)      NOT NULL
);
ALTER TABLE Cours
    ADD CONSTRAINT PK_Cours
    PRIMARY KEY (sigleDuCours);
ALTER TABLE Cours
    ADD CONSTRAINT FK_Cours_Enseignant_EnseignantResponsable
    FOREIGN KEY (enseignantResponsable)
    REFERENCES Enseignant(numTelephone);
ALTER TABLE Cours
    ADD CONSTRAINT Cours_sessionDuCours_CHECK
    CHECK ( sessionDuCours IN ('Hiver','Été','Automne'));
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Groupe
-- Primary key: (idGroupe)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Groupe(
  idGroupe              INTEGER,
  numGroupe             VARCHAR(15)     NOT NULL,
  etat                  VARCHAR(8)      NOT NULL,
  sigleDuCoursGroupe    VARCHAR(255)    NOT NULL
);
ALTER TABLE Groupe
    ADD PRIMARY KEY (idGroupe);
ALTER TABLE Groupe
    ADD CONSTRAINT FK_Groupe_sigleDuCours
    FOREIGN KEY ( sigleDuCoursGroupe)
    REFERENCES Cours(sigleDuCours);
------
-- Auto increment of Departement for idGroupe
------
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
    cote            CHAR(1),
    idGroupe        INTEGER, -- reference idGtoupe.groupe
    numTelephone    VARCHAR(30) --Reference numTelephone.Etudiant
);
ALTER TABLE Status
    ADD CHECK (cote IN ('A','B','C','D','E','S','I','X','Y','Z') );
ALTER TABLE Status ADD
    FOREIGN KEY (idGroupe)
    REFERENCES Groupe(idGroupe);
ALTER TABLE Status
    ADD FOREIGN KEY (numTelephone)
    REFERENCES Etudiant(numTelephone);
ALTER TABLE Status
    ADD PRIMARY KEY (idGroupe, numTelephone);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Local
-- Primary key (numero.Local,aile.Local,etage.Local)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Local(
    numero  INTEGER,
    aile    CHAR(1),
    etage   INTEGER
);
ALTER TABLE Local
    ADD CONSTRAINT PK_lodal
    PRIMARY KEY (numero,aile,etage);
AlTER TABLE Local
    ADD CONSTRAINT Local_aile_check
    CHECK (aile IN ('D','V','P','K','G','A','H','S','F','M','B','T','R','U'));

-----------------------------------------------------------------------------------------------------------------------
--                                      Table PlageHoraire
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE PlageHoraire(
    typeDeCours     VARCHAR(16),
    jourEtHeure     DATE,
    idGroupe        INTEGER, -- reference Groupe
    numero          INTEGER, --reference Local
    aile            CHAR(1), --reference Local
    etage           INTEGER--reference Local
);
ALTER TABLE PlageHoraire
    ADD CONSTRAINT PlageHoraire_typeDeCours_check
    CHECK (typeDeCours IN ('Laboratoire','Travaux Dirigés','Cours'));
AlTER TABLE PlageHoraire ADD CONSTRAINT FK_PlageHoraire_idGroupe
    FOREIGN KEY (idGroupe)
    REFERENCES Groupe(idGroupe);
-----------------------------------------------------------------------------------------------------------------------
--                                      Table Prealable
--                      Table de relation d'un Cours à Cours, (1 1..n)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE Prealable(
    coursPrincipal  VARCHAR(255),
    coursPrealable  VARCHAR(255)
);
ALTER TABLE Prealable
    ADD CONSTRAINT PK_Prealable
    PRIMARY KEY (coursPrealable, coursPrincipal);
Alter TABLE Prealable
    ADD CONSTRAINT FK_Prealable_Cours_coursprincipale
    FOREIGN KEY (coursPrincipal)
    REFERENCES Cours(sigleDuCours);
Alter TABLE Prealable
    ADD CONSTRAINT FK_Prealable_Cours_coursPrealable
    FOREIGN KEY (coursPrealable)
    REFERENCES Cours (sigleDuCours);