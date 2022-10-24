--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier de creation d'ecapsulation d'operation régulières
--REF exemple https://www.c-sharpcorner.com/UploadFile/rohatash/select-insert-update-delete-using-stored-procedure-in-sql/
--********************************************************************************************
ALTER SESSION SET CURRENT_SCHEMA="SIMONDUCHESNE1";

--********************************************************************************************
-- Enregistrement d'une  Personne sans role --todo
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
/
--********************************************************************************************
-- Enregistrement d'une nouvelle personne étudiante--todo
--********************************************************************************************
CREATE PROCEDURE process_nouveau_etudiant (
    PnumTelephone        varchar(30)    ,
    PNom                 varchar(255)   ,
    PPrenom              varchar(255)   ,
    PnumAdressSocial     varchar(255)   ,
    PCodePermanent       VARCHAR(255)   ,
    PAdresseCivique      VARCHAR(255)   ,
    PCourriel            VARCHAR(255)   ,
    PCourrielUqac        VARCHAR(255)   ,
    Petat                CHAR
)
AS
   BEGIN
      INSERT INTO Personne
          ( numTelephone,
            Nom,
            Prenom  ,
            numAdressSocial
            )
       VALUES
        (PnumTelephone,
        PNom   ,
        PPrenom  ,
        PnumAdressSocial
        );
      INSERT INTO Etudiant
          (
            numTelephone,
            CodePermanent ,
            AdresseCivique   ,
            Courriel     ,
            CourrielUqac  ,
            etat
    )
       VALUES
        (PnumTelephone,
        PCodePermanent ,
        PAdresseCivique,
        PCourriel,
        PCourrielUqac,
        Petat);
   END;
/
--********************************************************************************************
-- Enregistrement d'une nouvelle personne Enseignant--todo
--********************************************************************************************
--********************************************************************************************
-- Ajout Departement sans directeur--todo
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





