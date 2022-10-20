-- Ensure name are not used
DROP TABLE Personne;
DROP TABLE Enseignant;
DROP TABLE Etudiant;
DROP TABLE Departement;
--table: Personne
CREATE TABLE Personne(
    --Attributes
    numTelephone varchar(30) NOT NULL ,
    Nom varchar(255) NOT NULL ,
    Prenom varchar(255) NOT NULL ,
    numAdressSocial varchar(255) NOT NULL ,
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
    numTelephone, --todo foreign key
    telephoneProfessionel INTEGER,
    localBureau INTEGER,
    courriel VARCHAR(255)
);


--Foreign keys