# Travail Pratique 2
# Base de Données Avancés


## Introduction
Au cours de la session, les travaux auront comme sujet le développement d’une application de
gestion de données, à l’image des projets qui se font en entreprise. Chacun des 4 travaux du cours
portera sur un ou plusieurs concepts vus en classe, et sera effectue ́ en équipe de deux (2) étudiant(e)s
maximum.
Dans ce second TP, votre travail consistera, dans un premier temps, à identifier les règles d’affaires
(contraintes) associées au système présenté dans le document de mise en situation fourni avec le
travail pratique #1. Ensuite, vous devrez créer un script SQL permettant d’implémenter vos tables
ainsi que les contraintes sur la base de données Oracle. De plus, vous vous familiariserez avec les
procédures stockées et l’environnement SQLPlus d’Oracle.


## Méthodologie

## Installation d’Oracle Express
Pour réaliser ce TP, vous devrez installer Oracle Express (10g ou 11g) afin de créer votre
environnement de développement. Ce SGBD se retrouve sur le site d’Oracle et nécessitera la
création d’un compte (gratuit) pour en faire le téléchargement. De plus, c’est une version gratuite
d’Oracle.

## Test de connexion sous SQLPlus
Vous pouvez vous connecter sur votre SGBD en utilisant l’outil « Run SQL Command Line » qui
ouvrira SQLPlus. Vous devrez vous connecter (commande connect, username system et mot de
passe uqac1234) pour ensuite pouvoir réaliser des opérations SQL (par exemple, select sysdate
from dual).


### Tache 1 : Création des tables
Écrire un script SQL nommé « cretab.sql » faisant la cre ́ation de vos tables (CREATE TABLE).
Consigne 1 : Assurez-vous de bien identifier les contraintes de valeur (NOT NULL) dans vos
tables, ainsi que les cle ́s candidates (UNIQUE).
Consigne 2 : Bien que n’eˆtes pas oblige ́ de mettre des commentaires dans votre script, choisissez des
noms simples et descriptifs pour vos tables, colonnes et contraintes, et e ́vitez le plus possible les
acronymes obscurs (ex : PK TB FR). E ́ vitez e ́galement les accents dans les noms.
### Tache 2 : Contraintes et proce ́dures
Pour cette taˆche, vous devrez identifier et imple ́menter les re`gles d’affaires (contraintes) associe ́es
au système. Pour l’imple ́mentation des contraintes identifiées, vous choisirez une des trois approches
suivantes :
1. Contrainte statique dans la table (CHECK);
2. Contrainte de domaine a` l’aide d’une cle ́ e ́trange`re (FOREIGN KEY) ;
3. Contrainte dynamique complexe (TRIGGER).
Ensuite, vous devrez identifier les opérations qui mettent à jour l’état de la BD et encapsuler ces
opérations à l’aide de procédures stockées (CREATE PROCEDURE). Par exemple, une procédure
p.AjoutEtudiant pour la création d’un étudiant.