DROP TABLE Travailler CASCADE CONSTRAINTS;
DROP TABLE EtreAffecte CASCADE CONSTRAINTS;
DROP TABLE Projets CASCADE CONSTRAINTS;
DROP TABLE Equipes CASCADE CONSTRAINTS;
DROP TABLE Salaries CASCADE CONSTRAINTS;

/* CREATION DES TABLES */

CREATE TABLE Salaries
(codeSalarie VARCHAR(5), nomSalarie VARCHAR(25), prenomSalarie VARCHAR(25), nbTotalJourneesTravail NUMBER,
CONSTRAINT pk_Salaries PRIMARY KEY (codeSalarie));

CREATE TABLE Equipes
(codeEquipe VARCHAR(5), nomEquipe VARCHAR(25), codeSalarieChef VARCHAR(5),
CONSTRAINT pk_Equipes PRIMARY KEY (codeEquipe),
CONSTRAINT fk_Equipes_codeSalarieChef FOREIGN KEY (codeSalarieChef) REFERENCES Salaries(codeSalarie));

CREATE TABLE Projets
(codeProjet VARCHAR(5), nomProjet VARCHAR(25), villeProjet VARCHAR(25), codeEquipe VARCHAR(25),
CONSTRAINT nn_Projets CHECK (codeEquipe IS NOT NULL),
CONSTRAINT pk_Projets PRIMARY KEY (codeProjet),
CONSTRAINT fk_Projets_codeEquipe FOREIGN KEY (codeEquipe) REFERENCES Equipes(codeEquipe));

CREATE TABLE EtreAffecte
(codeSalarie VARCHAR(5), codeEquipe VARCHAR(5),
CONSTRAINT pk_EtreAffecte PRIMARY KEY (codeSalarie, codeEquipe),
CONSTRAINT fk_EtreAffecte_codeSalarie FOREIGN KEY (codeSalarie) REFERENCES Salaries(codeSalarie),
CONSTRAINT fk_EtreAffecte_codeEquipe FOREIGN KEY (codeEquipe) REFERENCES Equipes(codeEquipe));

CREATE TABLE Travailler
(codeSalarie VARCHAR(5), dateTravail DATE, codeProjet VARCHAR(5),
CONSTRAINT pk_Travailler PRIMARY KEY (codeSalarie, dateTravail),
CONSTRAINT fk_Travailler_codeSalarie FOREIGN KEY (codeSalarie) REFERENCES Salaries(codeSalarie),
CONSTRAINT fk_Travailler_codeProjet FOREIGN KEY (codeProjet) REFERENCES Projets(codePRojet));

/* INSERTION DE DONNEES */ 

INSERT INTO Salaries (codeSalarie, nomSalarie,prenomSalarie, nbTotalJourneesTravail) (SELECT * FROM Palleja.UNI_Salaries);
INSERT INTO Equipes (codeEquipe, nomEquipe, codeSalarieChef) (SELECT * FROM Palleja.UNI_Equipes);
INSERT INTO PROJETS (codeProjet, nomProjet, villeProjet, codeEquipe) (SELECT * FROM Palleja.UNI_Projets);
INSERT INTO EtreAffecte (codeSalarie, codeEquipe) (SELECT * FROM Palleja.UNI_EtreAffecte);
INSERT INTO Travailler (codeSalarie, dateTravail, codeProjet) (SELECT * FROM Palleja.UNI_Travailler);

COMMIT;