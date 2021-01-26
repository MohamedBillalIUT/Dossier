Contexte:

SET AUTOCOMMIT ON

DELETE FROM reap;
DELETE FROM fournisseur;
DELETE FROM achat;
DELETE FROM client;
DELETE FROM produit;

------------------------------------------
INSERT INTO client(ncli,nom) VALUES (60,'Marchand');
INSERT INTO client(ncli,nom) VALUES (101,'Defrere');
INSERT INTO client(ncli,nom) VALUES (102,'Rifflet');
INSERT INTO client(ncli,nom) VALUES (103,'Ullman');
INSERT INTO client(ncli,nom) VALUES (104,'Garey');
INSERT INTO client(ncli,nom) VALUES (105,'Johnson');
INSERT INTO client(ncli,nom) VALUES (106,'Vilarem');
INSERT INTO client(ncli,nom) VALUES (107,'Jacob');
INSERT INTO client(ncli,nom) VALUES (108,'Jamar');
INSERT INTO client(ncli,nom) VALUES (109,'Smith');

INSERT INTO produit VALUES (1,'Agrafeuse','Rouge',180);
INSERT INTO produit VALUES (2,'Calculatrice','Noir',200);
INSERT INTO produit VALUES (3,'Encre','Bleu',21);
INSERT INTO produit VALUES (4,'Lampe','Rouge',99);
INSERT INTO produit VALUES (5,'Lampe','Blanc',100);
INSERT INTO produit VALUES (6,'Lampe','Bleu',105);
INSERT INTO produit VALUES (7,'Lampe','Vert',105);
INSERT INTO produit VALUES (8,'Pese-lettre','Noir',40);
INSERT INTO produit VALUES (9,'Crayon','Rouge',10);
INSERT INTO produit VALUES (10,'Crayon','Bleu',30);
INSERT INTO produit VALUES (11,'Crayon Luxe','Rouge',30);
INSERT INTO produit VALUES (12,'Crayon Luxe','Vert',15);
INSERT INTO produit VALUES (13,'Crayon Luxe','Bleu',40);
INSERT INTO produit VALUES (14,'Crayon Luxe','Noir',50);

INSERT INTO achat VALUES (101,1,13);
INSERT INTO achat VALUES (101,2,2);
INSERT INTO achat VALUES (101,3,15);
INSERT INTO achat VALUES (101,4,15);
INSERT INTO achat VALUES (101,5,12);
INSERT INTO achat VALUES (101,6,12);
INSERT INTO achat VALUES (101,7,12);
INSERT INTO achat VALUES (101,8,12);
INSERT INTO achat VALUES (101,10,12);
INSERT INTO achat VALUES (101,11,12);
INSERT INTO achat VALUES (101,12,12);
INSERT INTO achat VALUES (101,13,12);
INSERT INTO achat VALUES (101,14,12);
INSERT INTO achat VALUES (103,1,4);
INSERT INTO achat VALUES (103,4,3);
INSERT INTO achat VALUES (103,7,6);
INSERT INTO achat VALUES (104,5,7);
INSERT INTO achat VALUES (104,11,1);
INSERT INTO achat VALUES (104,14,10);
INSERT INTO achat VALUES (105,4,4);
INSERT INTO achat VALUES (106,10,3);
INSERT INTO achat VALUES (106,7,3);
INSERT INTO achat VALUES (106,12,11);
INSERT INTO achat VALUES (107,3,10);
INSERT INTO achat VALUES (107,6,11);
INSERT INTO achat VALUES (107,8,8);
INSERT INTO achat VALUES (108,11,2);
INSERT INTO achat VALUES (108,14,10);
INSERT INTO achat VALUES (108,7,10);

INSERT INTO achat VALUES (101,9,1);

INSERT INTO FOURNISSEUR VALUES (1001,'Bureau Valle','Les Sables d Olonne');
INSERT INTO FOURNISSEUR VALUES (1002,'BIC','Montpellier');
INSERT INTO FOURNISSEUR VALUES (1003,'NADA','Mende');

INSERT INTO reap(nf,np,qr) VALUES (1001,1,51);
INSERT INTO reap(nf,np,qr) VALUES (1001,4,100);
INSERT INTO reap(nf,np,qr) VALUES (1001,5,100);
INSERT INTO reap(nf,np,qr) VALUES (1001,6,100);
INSERT INTO reap(nf,np,qr) VALUES (1001,7,100);
INSERT INTO reap(nf,np,date_reap,qr) VALUES (1001,7,'01/01/2020',100);

INSERT INTO reap(nf,np,date_reap,qr) VALUES (1002,7,'01/01/2020',500);

INSERT INTO reap(nf,np,date_reap,qr) VALUES (1003,1,'01/01/2020',49);
INSERT INTO reap(nf,np,date_reap,qr) VALUES (1003,9,'01/01/2020',100);
INSERT INTO reap(nf,np,date_reap,qr) VALUES (1003,9,'01/02/2020',50);
INSERT INTO reap(nf,np,date_reap,qr) VALUES (1003,10,'01/01/2020',200);


Exo2

Q1:
SELECT Count(*)
FROM produit

Q2:
SELECT Count(np) AS nbProduits
FROM Achat
WHERE ncli=103;

q3:
SELECT Count(np) AS nbProduits, ncli
FROM Achat
GROUP BY ncli;

q4:
SELECT ncli FROM(
SELECT ncli, Count(np) AS nbProduits
FROM Achat
GROUP BY ncli)
WHERE nbProduits>=3;

Q5:
SELECT ncli
FROM (
SELECT ncli, Count(*) AS nbProduits
FROM Achat
GROUP BY ncli)
WHERE nbProduits=(SELECT COUNT(*) FROM produit)

q6:
SELECT nom 
FROM client
WHERE ncli in(
SELECT ncli
FROM (SELECT ncli, Count(*) AS nbProduits
FROM Achat
GROUP BY ncli)
WHERE nbProduits=(SELECT COUNT(*) FROM produit))

q7
SELECT lib, min(qa) ,MAX(qa)
FROM Achat
join produit on achat.np=produit.np
GROUP BY lib

Exo3

q8:
SELECT MAX(qr)
FROM reap

q9:
SELECT LIB 
FROM
    (SELECT LIB, MAX(DISTINCT QR) AS maxReap
    FROM REAP 
    JOIN PRODUIT ON REAP.NP = PRODUIT.NP
    GROUP BY LIB)
WHERE maxReap = (SELECT MAX(DISTINCT QR) FROM REAP);

q10

	SELECT lib, Max(qr)
	FROM reap
    JOIN PRODUIT ON REAP.NP = PRODUIT.NP
    GROUP BY lib
    ORDER BY lib

q11

SELECT np
FROM (
	SELECT np, COUNT(nf) AS nbReap
	FROM reap
GROUP BY np
)
WHERE nbReap>=2;

q12
SELECT np
FROM (
	SELECT np, COUNT(nf) AS nbReap
	FROM reap
WHERE qr>50
GROUP BY np
)
WHERE nbReap>=2;


q13
SELECT nf
FROM(SELECT nf, COUNT(distinct reap.np) AS nbProduit
	FROM reap
	JOIN produit on reap.np=produit.np
	GROUP BY nf)
WHERE nbProduit=(SELECT COUNT( NP) FROM produit)

q14
SELECT nf
FROM(SELECT nf, COUNT(distinct reap.np) AS nbProduit
	FROM reap
	JOIN produit on reap.np=produit.np
	WHERE lib='Lampe'
	GROUP BY nf)
WHERE nbProduit=(SELECT COUNT( NP) FROM produit WHERE LIB='Lampe')

Exo 4

Q15
SELECT numis, COUNT(nomorg) as NB
FROM Visite
GROUP by numis

q16
Select Avg(nb) FROM(
Select COUNT(nomorg) AS NB
FROM Visite
GROUP by numis)

Q17

Select nomorg from (

	Select nomorg, Count(nomorg) as nb
	from Visite
	group by nomorg
)
where nb>=2

q18


Select nomorg from (

	Select nomorg, COUNT(datevisite) AS NBR
	from Visite
	group by nomorg
)
where nbR>=2



q19

SELECT nom , COUNT(nomorg) as nb
from Chercheur
join Mission on Chercheur.numc=Mission.numc
		join Visite on Mission.numis=Visite.numis
		GROUP by nom
Q20

SELECT nom from	Chercheur
where numc in(

	Select numc from( 

		select numc, Count(nomorg) as nb
		from Mission
		join Visite on Mission.numis=Visite.numis
		GROUP by numc
		)
	where nb=(SELECT COUNT(nomorg) FROM Organisme)

)

Q21
SELECT nom 
from	Chercheur
where numc in(

	Select numc from( 

		select numc, Count(nomorg) as nb
		from Mission
		join Visite on Mission.numis=Visite.numis
 		where pays='France'
		GROUP by numc
		)
	where nb=(SELECT COUNT(nomorg) FROM Organisme where pays='France'))
Chercheur (numc, nom, prenom, equipe)
Mission (numis, pays, datedeb, datefin, objet, numc)
Visite ( numis, nomorg, datevisite)
Organisme (nomorg, pays)