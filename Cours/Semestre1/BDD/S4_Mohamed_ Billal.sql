/*
 Repondez a chaque requete juste apres son numero.
 Ne pAS copier le resultat de la requete. UNIQUEMENT la requete.*/


 Exemple:
 
 --Q0
 SELECT *
  FROM *


--Q1

 SELECT nomU, prenomU
 FROM Utilisateurs
 WHERE dateINscription='09/09/2020'
--Q2

SELECT prixDepart
FROM Objets
WHERE titre='VTT'
AND dateAnnonce='09/09/2020'

--Q3

SELECT titre
FROM objets
JOIN Ventes ON Objets.nO=Ventes.nO
WHERE prixDepart = prix;

--Q4

SELECT nomU
FROM Utilisateurs
JOIN ventes on utilisateurs.nu= ventes.nAcheteur
WHERE no IN(
	SELECT no
	FROM Objets
	JOIN Utilisateurs ON objets.nVendeur= utilisateurs.nu
	WHERE nomU='Dupont'
	AND prenomU='Mathieu'
)

--Q5
SELECT DISTINCT nomU, prenomU
FROM utilisateurs
JOIN objets ON Utilisateurs.nu=Objets.nVendeur
order BY nomU, prenomU

--Q6

SELECT nomU, prenomU
FROM utilisateurs
WHERE nu IN(
	SELECT nVendeur
	FROM objets

	mINus 

	SELECT nAcheteur
	FROM Ventes
)

--Q7

SELECT DISTINCT prenomU
FROM utilisateurs
JOIN objets ON Utilisateurs.nu=Objets.nVendeur
WHERE titre='VTT'
or 
titre= 'Kite'

--Q8
SELECT DISTINCT prenomU
FROM utilisateurs
JOIN objets ON Utilisateurs.nu=Objets.nVendeur
WHERE titre='VTT'

INtersect

SELECT DISTINCT prenomU
FROM utilisateurs
JOIN objets ON Utilisateurs.nu=Objets.nVendeur
WHERE titre= 'Kite'

--Q9

SELECT AVG(prixDepart) AS prix_moyen
FROM Objets


--Q10

SELECT titre, categorie, dateAnnonce
FROM (
	SELECT titre, categorie, dateAnnonce, MAX(prixDepart) AS MAXPrixD
	FROM objets
	GROUP BY titre, categorie, dateAnnonce 
)
WHERE MAXPrixD=(SELECT MAX(prixDepart) AS MAXPrixD FROM objets);



--Q11

SELECT categorie, MIN(prixDepart) AS prix_depart_mIN, MAX(prixDepart) AS prix_depart_max
FROM Objets
GROUP BY categorie


--Q12

SELECT nomU, prenomU
FROM ( 
	SELECT nomU, prenomU, COUNT(nO) AS nbObjet
	FROM utilisateurs
	JOIN Ventes ON utilisateurs.nU=ventes.nAcheteur
	GROUP BY nomU, prenomU
)
WHERE nbObjet>=3


--Q13
SELECT nomU, prenomU
FROM ( 
	SELECT nomU, prenomU, COUNT(DISTINCT categorie) AS nbcategorie
	FROM utilisateurs
	JOIN objets ON Utilisateurs.nu=Objets.nVendeur
	GROUP BY nomU, prenomU
)
WHERE nbcategorie=(SELECT COUNT(DISTINCT categorie)FROM objets )

--Q14

UPDATE utilisateurs 
SET villeU='Montpellier' 
WHERE nomU='Dupont'
AND prenomU='Mathieu'
--Q15

DELETE FROM ventes
WHERE no IN( 
		SELECT no
		FROM objets
		JOIN utilisateurs ON objets.nVendeur =utilisateurs.nU
		WHERE nomU='Kahl'
		AND prenomU= 'Jean'
)

DELETE FROM objets
WHERE nVendeur IN( 
		SELECT nU
		FROM utilisateurs
		WHERE nomU='Kahl'
		AND prenomU= 'Jean'
)

DELETE  FROM Utilisateurs
WHERE nomU='Kahl'
AND prenomU='Jean'


--Q16

CREATE TABLE Evaluations(
	nre NUMBER,
	nle NUMBER,
	nO NUMBER,
	note INTEGER not null,
	com varchar(100) not null,
	CONSTRAINT ch_note CHECK (note = -1 OR note = 0 OR note = 1),
	CONSTRAINT pk_Evaluation PRIMARY KEY (nre, nle, no),
	CONSTRAINT fk_Evaluation_nre FOREIGN KEY (nre) REFERENCES Utilisateurs (nU),
	CONSTRAINT fk_Evaluation_nle FOREIGN KEY (nle) REFERENCES Utilisateurs (nU),
	CONSTRAINT fk_Evaluation_nO	FOREIGN KEY (nO) REFERENCES Objets (nO));

--Q17

INSERT INTO evaluations VALUES (101,105 , 5 , 0 , 'lopo' );
INSERT INTO evaluations VALUES (106,109 , 6 , -1 , 'loli' );
INSERT INTO evaluations VALUES (102,101 , 7 , 0 , 'lilo' );
INSERT INTO evaluations VALUES (108,110 , 9 , 1 , 'stitch' );
INSERT INTO evaluations VALUES (109,106 , 7 , 0 , 'Hakuna matata' );