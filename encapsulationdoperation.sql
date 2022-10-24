--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier de creation d'ecapsulation d'operation régulières
--REF exemple https://www.c-sharpcorner.com/UploadFile/rohatash/select-insert-update-delete-using-stored-procedure-in-sql/
--********************************************************************************************
ALTER SESSION SET CURRENT_SCHEMA="SIMONDUCHESNE1";

--********************************************************************************************
--                                                  Légende
-- Dans ce fichier, toutes les variables commençant paqr "p_" sont des variables créé pour la manipulation
-- dans les procédures.
--********************************************************************************************


--********************************************************************************************
-- Enregistrement d'une  Personne sans role
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_personne(
            "p_numTelephone" varchar,
            "p_Nom" varchar,
            "p_Prenom" varchar,
            "p_numAdressSocial" varchar
            )
    AS
    BEGIN
        INSERT INTO PERSONNE(
            numTelephone,
            Nom,
            Prenom  ,
            numAdressSocial
            )
        VALUES(
            "p_numTelephone",
            "p_Nom",
            "p_Prenom",
            "p_numAdressSocial"
            );
    END;

--********************************************************************************************
-- Enregistrement d'une nouvelle personne étudiante
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_etudiant (
    "p_numTelephone"        varchar  ,
    "p_Nom"                 varchar ,
    "p_Prenom"              varchar  ,
    "p_numAdressSocial"     varchar   ,
    "p_CodePermanent"       VARCHAR  ,
    "p_AdresseCivique"      VARCHAR   ,
    "p_Courriel"            VARCHAR   ,
    "p_CourrielUqac"        VARCHAR  ,
    "p_etat"                CHAR
)
AS
   BEGIN
      INSERT INTO Personne(
            numTelephone,
            Nom,
            Prenom  ,
            numAdressSocial
            )
       VALUES(
            "p_numTelephone" ,
            "p_Nom",
            "p_Prenom",
            "p_numAdressSocial"
        );
      INSERT INTO Etudiant(
            numTelephone,
            CodePermanent ,
            AdresseCivique   ,
            Courriel     ,
            CourrielUqac  ,
            etat
            )
       VALUES(
            "p_numTelephone",
            "p_CodePermanent",
            "p_AdresseCivique",
            "p_Courriel",
            "p_CourrielUqac" ,
            "p_etat"
            );
   END;

--********************************************************************************************
-- Enregistrement d'une nouvelle personne Enseignant--todo
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_enseignant(
    "p_numTelephone"            VARCHAR,
    "p_CodePermanent"           VARCHAR,
    "p_AdresseCivique"          VARCHAR,
    "p_Courriel"                VARCHAR,
    "p_CourrielUqac"            VARCHAR,
    "p_etat"                    CHAR,
    "p_AdresseCivique"          VARCHAR,
    "p_statut"                  CHAR,
    "p_telephoneProfessionel"   INTEGER,
    "p_localBureau"             INTEGER,
    "p_courriel"                VARCHAR
) AS
    BEGIN
        INSERT INTO Perssonne(
            p_numTelephone,
            Nom,
            Prenom,
            numAdressSocial
        )
        VALUES (
                "p_numTelephone",
                "p_nom",
                "p_prenom",
                "p_numAddressSocial"
            );
        INSERT INTO Enseignant(
            numTelephone,
            "p_AdresseCivique",
            statut
        )
        VALUES
            
    end;

--********************************************************************************************
-- Ajout Departement AVEC ou SANS sans directeur--todo
--********************************************************************************************
--********************************************************************************************
-- Ajout Departement avec directeur--todo
--********************************************************************************************
--********************************************************************************************
-- Ajout d'un cours--todo
--********************************************************************************************
--********************************************************************************************
-- Ajout de préalable à un cours--todo
--********************************************************************************************
--********************************************************************************************
-- Ajout de préalable à un cours--todo
--********************************************************************************************



--********************************************************************************************
-- View enseignant par ancienneté --todo
--********************************************************************************************

--********************************************************************************************
-- View voir tout sur un departement (tout ce qui est relié au département)--todo
--********************************************************************************************

--********************************************************************************************
-- View Tous les cours d'un étudiant--todo
--********************************************************************************************

--********************************************************************************************
-- View Liste de cours donnés dans la session--todo
--********************************************************************************************

--********************************************************************************************
-- Note d'un etudiant
--********************************************************************************************





