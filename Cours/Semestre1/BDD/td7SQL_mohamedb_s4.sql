Exo3

3.1:

1)
Insert into produit values(20, 'Cahier', 'Blanc',100);

2)
Insert into produit (np,lib,qs) values(21, 'Gomme',500);

3)
erreur: primary key non NULL
INSERT INTO produit(lib, coul ,qs) VALUES ('trombone','Gris',180)
*
ERREUR à la ligne 1 :
ORA-01400: impossible dinsérer NULL dans ("MOHAMEDB"."PRODUIT"."NP")

4)
erreur: doublons primary key interdit
Insert into produit values(20, 'Cahier', 'Blanc',100)
*
ERREUR à la ligne 1 :
ORA-00001: violation de contrainte unique (MOHAMEDB.PK_PRODUIT)

5)
insert into achat values(101,20,12)
*
ERREUR à la ligne 1 :
ORA-02291: violation de contrainte dintégrité (MOHAMEDB.FK_ACHAT_NP) - clé parent introuvable

3.2:

1)
DELETE FROM produit 
WHERE np= 21 ;

2)
DELETE FROM produit WHERE np= 20 ;
*
ERREUR à la ligne 1 :
ORA-02292: violation de contrainte (MOHAMEDB.FK_ACHAT_NP) d intégrité - enregistrement fils existant

3)
DELETE FROM achat 
WHERE qa< 5 ;

4)
DELETE FROM achat 
WHERE ncli in(
Select ncli
From client
where nom='Ullman'
)

3.3:

1)
UPDATE achat SET qa = qa+2 
WHERE ncli IN (
	SELECT ncli 
	FROM client 
	WHERE nom='Defrere'
	)
And np in (
	Select np
	from produit
	where lib='Agrafeuse'
	)

2)
 UPDATE produit 
 SET qs = qs+10, coul='Jaune' 
 WHERE np IN (
 	SELECT np 
 	FROM produit 
 	WHERE lib='Crayon Luxe')

3)
UPDATE achat SET qa = qa+2 
WHERE ncli IN (
	SELECT ncli 
	FROM client 
	WHERE nom='Defrere'
	)

4)*
UPDATE produit SET NP=30
* WHERE NP=20
ERREUR à la ligne 1 :
ORA-02292: violation de contrainte (MOHAMEDB.FK_ACHAT_NP) dintégrité - enregistrement fils existant

5)
 UPDATE achat 
 SET np = 13
 WHERE ncli = 101
 and np=9

0 ligne(s) mise(s) à jour.
achat(101,9) non existant

4.1:

1)
Alter Table client ADD adr Varchar(40);

2)
Alter Table client MODIFY adr Varchar(80);

3)
UPDATE client set adr='Montpellier';

4)*
Alter table client MODIFY adr DEFAULT 'Mende';

5)
Insert into client (ncli,nom)values (2,'yoshy');

4.2:

1)
Create Table fournisseur
(nf Integer,
nom Varchar(10) not null,
adr Varchar (40) not null,
Constraint pk_fournisseur primary KEY (nf));

2)
insert into fournisseur values (1001,'Bureau Valle','Les Sables d Olonne');
insert into fournisseur values (1002,'BIC','Montpellier');
insert into fournisseur values (1003,'NADA','Mende');


3)
a:insert into fournisseur (nf, nom)values (1004, 'Clairefontaine')
	*
ERREUR à la ligne 1 :
ORA-01400: impossible dinsérer NULL dans ("MOHAMEDB"."FOURNISSEUR"."ADR") 



b:insert into fournisseur values (1002, 'Epson', 'Paris')
	*
ERREUR à la ligne 1 :
ORA-00001: violation de contrainte unique (MOHAMEDB.PK_FOURNISSEUR) 


4)
Create table REAP(
	nf Integer,
	np Integer,
	date_reap Date DEFAULT current_date,
	qr Integer not null,
	CONSTRAINT stock check (qr>0),
	Constraint pk_reap primary key (nf,np,date_reap),
	Constraint pk_nf_reap foreign key (nf) References fournisseur(nf),
	Constraint pk_np_reap foreign key (np) References produit(np)
	);


5)
insert into REAP (nf,np,qr)values (1001,1,51);
insert into REAP (nf,np,qr)values (1001,4,100);
insert into REAP (nf,np,qr)values (1001,5,100);
insert into REAP (nf,np,qr)values (1001,6,100);
insert into REAP (nf,np,qr)values (1001,7,100);
insert into REAP values (1001,7,'01/01/2020',100);
insert into REAP values (1002,7,'01/01/2020',500);	
insert into REAP values (1003,1,'01/01/2020',49);
insert into REAP values (1003,9,'01/01/2020',100);
insert into REAP values (1003,9,'01/02/2020',50);
insert into REAP values (1003,10,'01/01/2020',200);

6)

insert into reap (nf,np) values (1002,1);

insert into REAP values (1001,7,'01/01/2020',101)
*

ERREUR à la ligne 1 :
ORA-00001: violation de contrainte unique (MOHAMEDB.PK_REAP)

insert into REAP (nf,np,qr) values (1004,4,3)
*

ERREUR à la ligne 1 :
ORA-02291: violation de contrainte dintégrité (MOHAMEDB.PK_NF_REAP) - clé parent introuvable 


4.3:
Q1-
SELECT distinct nf
from reap
join produit on reap.np=produit.np
where lib='Lampe'
or
lib='Agrafeuse'

Q2-
SELECT nom
from fournisseur
where nf in (
SELECT distinct nf
from reap
join produit on reap.np=produit.np
where lib='Lampe'

intersect

SELECT distinct nf
from reap
join produit on reap.np=produit.np
where lib='Agrafeuse')

q3-
Select nom
from fournisseur
where nf in(

select nf
from fournisseur

minus
SELECT distinct nf
from reap
join produit on reap.np=produit.np
where lib='Lampe')

Q4-
Select nom
from fournisseur
join reap on fournisseur.nf=reap.nf

minus
Select nom
from fournisseur
join reap on fournisseur.nf=reap.nf
where date_reap>'02/02/2020'

q5-
SELECT DISTINCT r.nf 
FROM reap r 
JOIN reap r2 ON r.nf = r2.nf 
WHERE r.np !=r2.np;

q6-
SELECT DISTINCT r.np
FROM reap r 
JOIN reap r2 ON r.np = r2.np 
WHERE r.nf !=r2.nf
or r.date_reap!=r2.date_reap

q7-
SELECT DISTINCT r.np
FROM reap r 
JOIN reap r2 ON r.np = r2.np 
WHERE r.nf !=r2.nf
and r.qr>50
and r2.qr>50

q8-
SELECT NF FROM FOURNISSEUR
MINUS
SELECT NF FROM (
    SELECT REAP.NF, PRODUIT.NP FROM REAP, PRODUIT
MINUS
    SELECT REAP.NF, PRODUIT.NP FROM REAP JOIN PRODUIT ON REAP.NP = PRODUIT.NP);

q9

SELECT NF FROM FOURNISSEUR
MINUS
SELECT NF FROM (
    SELECT REAP.NF, PRODUIT.NP FROM REAP, PRODUIT
    where lib='Lampe'
MINUS
    SELECT REAP.NF, PRODUIT.NP FROM REAP JOIN PRODUIT ON REAP.NP = PRODUIT.NP where lib='Lampe');



SELECT nss FROM Personne
MINUS
SELECT nss FROM (
SELECT p.nss, v.marq FROM personne p, voiture v
MINUS
SELECT nss, marq FROM possede JOIN voiture ON possede.imm = voiture.imm) ;