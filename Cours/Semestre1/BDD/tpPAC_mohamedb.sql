Sujet (insertion des tables):
-------------------------------------------------------
-- cas PAC
-------------------------------------------------------
-- chaque requte sera immŽdiatement ŽxŽcutŽe comme une transaction unitaire
SET AUTOCOMMIT ON

------------------------------------------
--On supprime les tables 
------------------------------------------
DROP TABLE achat;
DROP TABLE client;
DROP TABLE produit;

--Attention ˆ la premire execution du script les tables n'existent pas
--Ces 3 lignes provoqueront 3 erreurs (sans consŽquence sur le reste du script).

------------------------------------------
--On cree les tables et leurs contraintes 
------------------------------------------
CREATE TABLE client
       (ncli 	INTEGER ,
        nom 	VARCHAR(10),
	CONSTRAINT pk_client PRIMARY KEY(ncli));
   
CREATE TABLE produit
	(np 	INTEGER ,
 	 lib 	VARCHAR(20),
 	 coul 	VARCHAR(10),
 	 qs 	INTEGER ,
	 CONSTRAINT pk_produit PRIMARY KEY(np)); 

CREATE TABLE achat
	(ncli 	INTEGER ,
	 np 	INTEGER ,
	 qa 	INTEGER check (qa>=0),
	 CONSTRAINT pk_achat PRIMARY KEY (ncli,np),
	 CONSTRAINT fk_achat_ncli FOREIGN KEY (ncli) REFERENCES client(ncli),
	 CONSTRAINT fk_achat_np FOREIGN KEY (np) REFERENCES produit(np));

------------------------------------------
--On insère des données
------------------------------------------
INSERT INTO client VALUES (60,'Marchand');
INSERT INTO client VALUES (101,'Defrere');
INSERT INTO client VALUES (102,'Rifflet');
INSERT INTO client VALUES (103,'Ullman');
INSERT INTO client VALUES (104,'Garey');
INSERT INTO client VALUES (105,'Johnson');
INSERT INTO client VALUES (106,'Vilarem');
INSERT INTO client VALUES (107,'Jacob');
INSERT INTO client VALUES (108,'Jamar');
INSERT INTO client VALUES (109,'Smith');

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
INSERT INTO achat VALUES (107,8,4);
INSERT INTO achat VALUES (108,11,2);
INSERT INTO achat VALUES (108,14,10);
INSERT INTO achat VALUES (108,7,10);


Q1
select distinct  lib 
From produit

Q2

Select nom
From CLIENT

Q3
Select *
From PRODUIT
Where QS>50

Q4

Select * 
From ACHAT
Where QA >12

Q5

Select QS, coul
From Produit
Where lib='Lampe'

Q6

Select NP
From Produit
Where lib ='Crayon Luxe'
AND QS>30

Q7

Select distinct ncli 
From ACHAT
Where QA >10

Q8
 Select distinct ncli
from achat
join produit on achat.NP=produit.np 
where lib='Lampe'

Q9
 Select distinct ncli
from achat
join produit on achat.NP=produit.np 
where lib='Lampe'
AND coul ='Rouge'

Q10
Select distinct lib
From Produit
join ACHAT on produit.np=achat.np
where QA>10

Q11
Select distinct lib
From Produit
join achat on produit.np=achat.np
join client ON achat.ncli = client.ncli
where nom='Vilarem'

Q12

Select distinct nom
From client
join achat on client.ncli=achat.ncli
join produit on achat.np=produit.np
where QA>10
And lib ='Crayon Luxe'

Q13

Select np
from PRODUIT

MINUS

select NP
From ACHAT

Q14
&achatQ
Select ncli
from Client

MINUS

 Select distinct ncli
from achat
join produit on achat.NP=produit.np 
where lib='Lampe'

Q15

SELECT DISTINCT NCLI
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Lampe' 

INTERSECT 

SELECT NCLI 
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Agrafeuse';

Q16

SELECT DISTINCT NCLI
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Lampe' 

UNION 

SELECT NCLI 
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Agrafeuse';

ou


SELECT DISTINCT NCLI
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Lampe' 
or lib='Agrafeuse'

Q17

SELECT DISTINCT NCLI 
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Lampe' 

INTERSECT 

SELECT NCLI 
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP 
WHERE LIB='Agrafeuse';


Q18

(SELECT DISTINCT NCLI
 FROM ACHAT
 JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP
 WHERE LIB='Lampe'
 OR LIB='Agrafeuse')

 MINUS 

(SELECT DISTINCT NCLI FROM ACHAT
 JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP
 WHERE LIB='Lampe'

 INTERSECT
 SELECT DISTINCT NCLI 
FROM ACHAT 
JOIN PRODUIT ON ACHAT.NP = PRODUIT.NP
 WHERE LIB='Agrafeuse')

Q20
Select distinct a.ncli
From achat a
join achat a2 on a.ncli=a2.ncli
where a.np=a2.np
 on 
Schéma des relations :
PRODUIT(NP, LIB, COUL, QS)
ACHAT(NCLI, NP, QA)
CLIENT(NCLI, NOM, ADR)