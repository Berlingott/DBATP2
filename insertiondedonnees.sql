--********************************************************************************************
-- Simon Duchesne
-- 24 Oct. 2022
-- Fichier d'insertion de données exemples dans la base de données.
--*******************************************************************************************
INSERT INTO PERSONNE(numtelephone, nom, prenom, numadresssocial)
    VALUES ('58123412348','Duchesne','Simon','3495012835');

CALL PROCESS_NOUVEAU_ETUDIANT (
    '+1(581)234-1486'  ,
   'Duchesne'  ,
   'Simon' ,
    '123456789',
    'DUCS20069507'      ,
    '353345 desrosier'     ,
    'CeciEstUnCourriel@gmail.com'        ,
    'simon.duchesne1@uqac.ca'       ,
    'P')
