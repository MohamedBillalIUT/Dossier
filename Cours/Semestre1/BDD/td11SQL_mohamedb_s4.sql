TABLE:
-- chaque requÃªte sera immÃ©diatement Ã©xÃ©cutÃ©e comme une transactiON unitaire
SET AUTOCOMMIT ON


DROP TABLE  Demandeur;
DROP TABLE Offre;
DROP TABLE Entreprise;

CREATE TABLE Entreprise (nume NUMBER PRIMARY KEY, nome VARCHAR(30), adre VARCHAR(30));
CREATE TABLE Offre (numo NUMBER PRIMARY KEY, nume NUMBER, cONtrat VARCHAR(20), qualif VARCHAR(20), salaire NUMBER, lieu VARCHAR(30),CONSTRAINT fk_nume FOREIGN KEY (nume) REFERENCES Entreprise(nume));
CREATE TABLE Demandeur (numd NUMBER PRIMARY KEY, nom VARCHAR(20), prenom VARCHAR(20), adresse VARCHAR(30), qualif VARCHAR(20), dateinscrip DATE);



INSERT INTO Entreprise VALUES (1,'CapGemini','Paris (FRANCE)');
INSERT INTO Entreprise VALUES (2,'IBM','ArmONk, New York (USA)');
INSERT INTO Entreprise VALUES (3,'Atos Origin','Courbevoie (France)');
INSERT INTO Entreprise VALUES (4,'Dell','Round Rock, TexAS (USA)');
INSERT INTO Entreprise VALUES (5,'Sopra GROUP','Paris (FRANCE)');
INSERT INTO Entreprise VALUES (6,'HP','Palo-Alto, Californie (USA)');

INSERT INTO Offre VALUES (1,1,'CDI','AdminSys',2000,'Toulouse');
INSERT INTO Offre VALUES (2,2,'Interim','WebmASter',1500,'Paris');
INSERT INTO Offre VALUES (3,3,'CDI','AdminBD',2100,'LyON');
INSERT INTO Offre VALUES (4,5,'Interim','CONsultant',2900,'Paris');
INSERT INTO Offre VALUES (5,5,'CDD','CONsultant',3500,'Paris');
INSERT INTO Offre VALUES (6,2,'CDI','AdminBD',2400,'Toulouse');
INSERT INTO Offre VALUES (7,1,'Interim','WebmASter',1400,'Lille');
INSERT INTO Offre VALUES (8,4,'CDI','Developpeur',1600,'Toulouse');
INSERT INTO Offre VALUES (9,5,'CDD','AdminSys',2000,'Paris');
INSERT INTO Offre VALUES (10,2,'CDI','Developpeur',1700,'Toulouse');
INSERT INTO Offre VALUES (11,2,'CDD','Developpeur',2200,'LyON');
INSERT INTO Offre VALUES (12,3,'Interim','CONsultant',1250,'LyON');
INSERT INTO Offre VALUES (13,5,'CDI','Developpeur',3000,'Paris');
INSERT INTO Offre VALUES (14,1,'CDI','AdminBD',2200,'MONtpellier');
INSERT INTO Offre VALUES (15,1,'Interim','CONsultant',1300,'Nancy');
INSERT INTO Offre VALUES (16,1,'CDI','Developpeur',1600,'Toulouse');

INSERT INTO Demandeur VALUES (1,'DupONt','Mathieu','Toulouse','Developpeur','09-09-2020');
INSERT INTO Demandeur VALUES (2,'Dalors','Homere','Lille','Developpeur','15-10-2020');
INSERT INTO Demandeur VALUES (3,'Kahl','Jean','Toulouse','AdminSys','11-12-2020');
INSERT INTO Demandeur VALUES (4,'Stal','Ingrid','Lille','WebmASter','26-12-2020');
INSERT INTO Demandeur VALUES (5,'DupONd','Matthieu','Paris','AdminBD','02-11-2020');
INSERT INTO Demandeur VALUES (6,'Cleub','Medhi','Paris','WebmASter','18-11-2020');
INSERT INTO Demandeur VALUES (7,'Tylo','Ivan','LyON','WebmASter','13-07-2020');
INSERT INTO Demandeur VALUES (8,'Bathe','Anne','Nancy','Graphiste','07-11-2020');
INSERT INTO Demandeur VALUES (9,'Harem','Colette','Paris','AdminBD','21-11-2020');
INSERT INTO Demandeur VALUES (10,'Manfaud','Gerard','Toulouse','CONsultant','30-06-2020');



Exo2

Q1:

SELECT distinct lieu
FROM Offre
JOIN Entreprise ON Offre.nume=Entreprise.nume
WHERE nome='CapGemini';

Q2:

SELECT nom
FROM Demandeur
WHERE qualif IN (SELECT  qualif
FROM offre
JOIN Entreprise ON Offre.nume=Entreprise.nume
WHERE nome='Sopra GROUP');

Q3:

SELECT Qualif
FROM demandeur

minus

SELECT  qualif
FROM offre


Q4:

SELECT nome
FROM Entreprise
JOIN Offre on Entreprise.nume=Offre.nume
WHERE qualif='WebmASter'

intersect

SELECT nome
FROM Entreprise
JOIN Offre on Entreprise.nume=Offre.nume
WHERE qualif='AdminBD'

Q5

SELECT Qualif, lieu, salaire
FROM Offre
WHERE contrat='Interim'
order BY qualif, lieu

Q6

SELECT nome
FROM Entreprise
WHERE nume in(
	SELECT nume
	FROM (
		SELECT nume, MAX( distinct salaire) AS nb
		FROM offre
		GROUP BY nume
		)
	WHERE nb =(SELECT MAX( distinct salaire) FROM offre))

Q7

SELECT Qualif, Count(*)
FROM offre
GROUP BY qualif

Q8

SELECT nome, AVG(salaire) AS moyen
FROM Entreprise
JOIN Offre on Entreprise.nume=Offre.nume
GROUP BY nome

Q9

SELECT nome
FROM (
	SELECT e.nome, Count(distinct o.contrat) AS nbType
	FROM Offre o
	JOIN Entreprise e ON o.nume=e.nume
	GROUP BY e.nome
)	WHERE nbType>=2

Q10
SELECT nome
FROM (
	SELECT e.nome, Count(distinct o.lieu) AS nbVille
	FROM Offre o
	JOIN Entreprise e ON o.nume=e.nume
	GROUP BY e.nome
)	WHERE nbVille=(SELECT Count( distinct lieu) FROM offre);
)

Q11
SELECT nome
FROM (
	SELECT e.nome, Count(distinct o.contrat) AS nbVille
	FROM Offre o
	JOIN Entreprise e ON o.nume=e.nume
	GROUP BY e.nome
)	WHERE nbVille=(SELECT Count( distinct contrat) FROM offre);



q12
SELECT Qualif, MIN(salaire) AS MinSal, MAX(salaire) AS MaxSal
FROM offre
GROUP BY qualif

Q13

SELECT qualif FROM
    (SELECT qualif, MIN(salaire) AS MINSAL, MAX(salaire) AS MAXSAL
FROM OFFRE
GROUP BY qualif)
WHERE MINSAL = MAXSAL


Q14

UPDATE Demandeur SET dateinscrip='08-09-2020'
WHERE nom= 'Dupont';

Q15

Delete from Offre
WHERE nume in (
	SELECT nume 
	from  Entreprise
	where nome ='Dell'
)

Q16

CREATE TABLE Entretien(
	numd NUMBER ,
	numo NUMBER ,
	datecondidature DATE not null,

	CONSTRAINT pk_numd_numo_Entretien PRIMARY KEY (numd,numo),
	CONSTRAINT fk_numd_Entretien FOREIGN KEY (numd) references Demandeur(numd),
	CONSTRAINT fk_nomo_Entretien FOREIGN KEY (numis) references Offre(numo));
)

Q17

INSERT INTO Entretien VALUES (1,1, '08-09-2020');
INSERT INTO Entretien VALUES (2,1, '08-04-2020');
INSERT INTO Entretien VALUES (3,1, '10-09-2020');
INSERT INTO Entretien VALUES (4,4, '08-04-2020');
INSERT INTO Entretien VALUES (1,5, '08-09-2020');
INSERT INTO Entretien VALUES (6,5, '13-12-2020');
INSERT INTO Entretien VALUES (6,1, '08-09-2020');
INSERT INTO Entretien VALUES (7,7, '08-09-2020');
INSERT INTO Entretien VALUES (1,7, '30-10-2020');
INSERT INTO Entretien VALUES (10,1, '08-09-2020');

contexte:
Entreprise(nume,nome,adre)
Offre(numo,nume,contrat,qualif,salaire,lieu)
Demandeur(numd,nom,prenom,adresse,qualif,dateinscrip)