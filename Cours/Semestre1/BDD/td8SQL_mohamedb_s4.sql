exo 3:


drop table Visite;
drop table Mission;
drop table organisme;
drop table Chercheur;

1)
Create table Chercheur(
	numc Integer,
	nom Varchar(20) NOT NULL,
	prenom Varchar(20) NOT NULL,
	equipe Varchar(20) NOT NULL,
	CONSTRAINT pk_Chercheur PRIMARY KEY (numc));

Create table Mission(
	numis Integer,
	pays Varchar(80) NOT NULL,
	datedeb Date NOT NULL,
	datefin Date NOT NULL,
	objet Varchar(80) NOT NULL,
	numc Integer NOT NULL,
	CONSTRAINT regu_datefin CHECK (datefin>datedeb),
	CONSTRAINT pk_Missions PRIMARY KEY (numis),
	CONSTRAINT fk_Missions FOREIGN KEY (numc) references Chercheur(numc));

Create table Organisme(
	nomorg Varchar(20),
	pays Varchar(80) NOT NULL,
	CONSTRAINT pk_Organisme PRIMARY KEY (nomorg));

Create table Visite(
	numis Integer,
	nomorg Varchar(20),
	datevisite Date NOT NULL,
	CONSTRAINT pk_Visite PRIMARY KEY (numis,nomorg),
	CONSTRAINT fk_numis_Visite FOREIGN KEY (nomorg) references Organisme(nomorg),
	CONSTRAINT fk_nomorg_Visite FOREIGN KEY (numis) references Mission(numis));


2)
INSERT INTO Chercheur VALUES (1,'Roitelet','Martine','BD');
INSERT INTO Chercheur VALUES (2,'Dupont','Jacques','IA');
INSERT INTO Chercheur VALUES (3,'Duvivier','Anne','BD');
INSERT INTO Chercheur VALUES (4,'Rifflet','Jean-Marie','Systeme');

3)
INSERT INTO Organisme VALUES ('LIRMM','France');
INSERT INTO Organisme VALUES ('IRIT','France');
INSERT INTO Organisme VALUES ('MIT','Etats-Unis');
INSERT INTO Organisme VALUES ('4C','Irlande');
INSERT INTO Organisme VALUES ('NICTA','Australie');
INSERT INTO Organisme VALUES ('Cork University','Irlande');

4)
INSERT INTO Mission VALUES (101,'France','08.01.2020','15.01.2020','Contrat ANR',1);
INSERT INTO Mission VALUES (102,'France','08.01.2020','15.01.2020','Contrat ANR',3);
INSERT INTO Mission VALUES (103,'Irlande','08.09.2020','21.09.2020','CP 2020',2);
INSERT INTO Mission VALUES (104,'Australie','07.01.2020','18.01.2020','CPAIOR',2);
INSERT INTO Mission VALUES (105,'Etats-Unis','31.01.2020','08.02.2020','IJCAI',2);
INSERT INTO Mission VALUES (106,'France','01.06.2020','15.06.2020','Coordination ANR',1);
INSERT INTO Mission VALUES (107,'Australie','08.01.2020','18.01.2020','CPAIOR',1);

5)
INSERT INTO Visite VALUES (101,'IRIT','08.01.2020');
INSERT INTO Visite VALUES (102,'IRIT','08.01.2020');
INSERT INTO Visite VALUES (103,'4C','08.09.2020');
INSERT INTO Visite VALUES (103,'Cork University','12.09.2020');
INSERT INTO Visite VALUES (104,'NICTA','07.01.2020');
INSERT INTO Visite VALUES (105,'MIT','31.01.2020');
INSERT INTO Visite VALUES (106,'LIRMM','01.06.2020');
INSERT INTO Visite VALUES (107,'NICTA','08.01.2020');

EXO 4
 
 Q1= 
 select nomorg
 from Visite
 join Mission on Visite.numis=Mission.numis
 join Chercheur on Mission.numc=Chercheur.numc
 where nom='Roitelet'
 and prenom ='Martine'

 Q2=
 Select nom
 from Chercheur
 join Mission on chercheur.numc=Mission.numc
 where pays ='Australie'

 intersect

 Select nom
 from Chercheur
 join Mission on chercheur.numc=Mission.numc
 where pays ='Etats-Unis'

q3=

Select nom
From Chercheur

minus

Select nom
 from Chercheur
 join Mission on chercheur.numc=Mission.numc

q4=


SELECT nom 
FROM chercheur  --tous les clients
 MINUS
   --les clients tel qu'il existe un produit qu'ils n'ont pas acheté 
   SELECT nom FROM
        (SELECT nom,nomorg FROM chercheur,organisme
    MINUS
         SELECT chercheur.nom, organisme.nomorg FROM chercheur 
         join mission on chercheur.numc=mission.numc
         join Visite on mission.numis=visite.numis
         JOIN organisme ON visite.nomorg = organisme.nomorg
);

q5=
SELECT nom 
FROM chercheur  --tous les clients
 MINUS
   --les clients tel qu'il existe un produit qu'ils n'ont pas acheté 
   SELECT nom FROM
        (SELECT nom,nomorg FROM chercheur,organisme
        where pays='France' --tous les couples (nom,np) possibles   
    MINUS
         SELECT chercheur.nom, organisme.nomorg FROM chercheur 
         join mission on chercheur.numc=mission.numc
         join Visite on mission.numis=visite.numis
         JOIN organisme ON visite.nomorg = organisme.nomorg
         where organisme.pays='France' --tous les couples (nom,np) possibles   
);

Tri

q6
select nom, prenom
from Chercheur
order by nom, prenom

q7
select numis
from mission
order by datedeb desc

q8
select pays, nomorg
from organisme
group by pays, nomorg
orber by pays, nomorg

fonctions

q9
select count(numc) as nbChercheur
from chercheur

q10
SELECT COUNT(*)FROM CHERCHEUR
WHERE NUMC IN (SELECT NUMC FROM MISSION);

sele
Chercheur (numc, nom, prenom, equipe)
Mission (numis, pays, datedeb, datefin, objet, numc)
Visite ( numis, nomorg, datevisite)
Organisme (nomorg, pays)