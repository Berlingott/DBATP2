--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier de creation d'un utilisateur.
--********************************************************************************************

--********************************************************************************************
--                              Utilisateur
--  rôle: Admin
--  utilisateur: simonduchesne1
--  mot de passe: uqac1234
--********************************************************************************************
alter session set "_oracle_script"=true;
CREATE USER simonduchesne1 IDENTIFIED BY uqac1234;
GRANT SYSOPER TO simonduchesne1;
GRANT CREATE SESSION TO simonduchesne1;
GRANT DBA TO simonduchesne1;
GRANT CREATE ANY TABLE TO simonduchesne1;
GRANT ALTER ANY TABLE TO simonduchesne1;
GRANT DROP ANY TABLE TO simonduchesne1;
GRANT DELETE ANY TABLE TO simonduchesne1;
GRANT create view to simonduchesne1;
GRANT UPDATE ANY TABLE to simonduchesne1;

--********************************************************************************************
--                              Utilisateur
--  rôle: lecture seule
--  utilisateur: lecteur
--  mot de passe: uqac1234
--********************************************************************************************
alter session set "_oracle_script"=true;
CREATE USER lectureseule IDENTIFIED BY "uqac1234";
GRANT CREATE SESSION TO lectureseule;
GRANT READ ANY TABLE TO lectureseule;

--********************************************************************************************
--                              Connexion au schéma
--********************************************************************************************

ALTER SESSION SET CURRENT_SCHEMA="SIMONDUCHESNE1"
