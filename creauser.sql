--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier de creation d'un utilisateur.
--********************************************************************************************

alter session set "_oracle_script"=true;
CREATE USER simonduchesne1 IDENTIFIED BY uqac1234;
GRANT CREATE SESSION TO simonduchesne1;
GRANT CREATE ANY TABLE TO simonduchesne1;
GRANT DROP ANY TABLE TO simonduchesne1;
GRANT DELETE ANY TABLE TO simonduchesne1;
GRANT create view to simonduchesne1;
GRANT UPDATE ANY TABLE to simonduchesne1;
