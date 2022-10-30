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
-- Enregistrement d'une nouvelle personne Enseignant
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_enseignant(
    "p_numTelephone"            VARCHAR,
    "p_prenom"                  VARCHAR,
    "p_nom"                  VARCHAR,
    "p_numAddressSocial"        VARCHAR,
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
        INSERT INTO Personne(
            numTelephone,
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
            AdresseCivique,
            statut
        )
        VALUES (
                "p_numTelephone",
                "p_AdresseCivique",
                "p_statut"
               );
        INSERT INTO DonneesProfessionel(
                numTelephone,
                telephoneProfessionel,
                localBureau,
                courriel
                    )
        VALUES (
                "p_numTelephone",
                "p_telephoneProfessionel",
                "p_localBureau",
                "p_courriel"
               );
    END;
--********************************************************************************************
-- Ajout Departement AVEC ou SANS sans directeur --todo verif
--********************************************************************************************

CREATE OR REPLACE PROCEDURE process_nouceau_departement(
    "p_nom",
    "p_numDepartement",
    "p_numTelDuDirecteur",
    "p_withorwithoutprincipal"
)
AS
    IF "p_withorwithoutprincipal" = 'with'
        BEGIN
            INSERT Departement(
                    "nom",
                    "numDepartement",
                    "numTelDuDirecteur",
                    "withorwithoutprincipal"
            )
            VALUES(
                    "p_nom",
                    "p_numDepartement",
                    "p_numTelDuDirecteur",
                    "p_withorwithoutprincipal"
                );
        end;
    IF "p_withorwithoutprincipal" = 'without'
        BEGIN
            INSERT Departement(
                    "nom",
                    "numDepartement",
                    "withorwithoutprincipal"
            )
            VALUES(
                    "p_nom",
                    "p_numDepartement",
                    "p_withorwithoutprincipal"
                );
        END;

--********************************************************************************************
-- Ajout d'un cours
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_cours(
    "sigleDuCours"          VARCHAR,
    "titreCours"            VARCHAR,
    "enseignantResponsable" VARCHAR,
    "nombreCredit"          VARCHAR,
    "heureTotalCours"       VARCHAR,
    "heureLab"              VARCHAR,
    "heurePerso"            VARCHAR,
    "sessionDuCours"        VARCHAR
)AS
    BEGIN
        INSERT INTO Cours(
    sigleDuCours,
    titreCours   ,
    enseignantResponsable,
    nombreCredit          ,
    heureTotalCours        ,
    heureLab                ,
    heurePerso               ,
    sessionDuCours
    )
    VALUES (
    "sigleDuCours"          ,
    "titreCours"            ,
    "enseignantResponsable" ,
    "nombreCredit"          ,
    "heureTotalCours"       ,
    "heureLab"              ,
    "heurePerso"            ,
    "sessionDuCours"
    );
    end;

--********************************************************************************************
-- Ajout de préalable à un cours
--********************************************************************************************
CREATE OR REPLACE PROCEDURE process_nouveau_préalable(
    "p_sigleDuCoursConcerner" VARCHAR,
    "p_sigleDuCoursPrealable" VARCHAR
) AS
    BEGIN
        INSERT INTO Prealable(
            coursPrincipal,
            coursPrealable
        )
        VALUES (
            "p_sigleDuCoursConcerner" ,
            "p_sigleDuCoursPrealable"
               );
    END;

--********************************************************************************************
-- View enseignant par ancienneté
--********************************************************************************************
CREATE VIEW view_Enseignant_par_anciennete
    AS
    SELECT Enseignant.numTelephone, Personne.NUMTELEPHONE, Personne.nom, Personne.prenom, ENSEIGNANT.DATEEMBAUCHE
    FROM ENSEIGNANT
    INNER JOIN PERSONNE  on ENSEIGNANT.NUMTELEPHONE = Personne.NUMTELEPHONE
    ORDER BY ENSEIGNANT.DATEEMBAUCHE;
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
-- VIEW Note d'un etudiant
--********************************************************************************************





