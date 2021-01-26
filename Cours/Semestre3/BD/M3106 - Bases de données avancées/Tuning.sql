-- a. Nombre de lignes de commande passées par chaque client (attention, l’exécution de la requête suivante peut prendre un certain de temps – plus de 3 minutes) :

SELECT nomClient, prenomClient, (SELECT COUNT(*)
                                 FROM Commandes co 
                                 JOIN LignesCommande lc ON
                                        co.idCommande = lc.idCommande 
                                 WHERE co.idClient = cl.idClient)
FROM Clients cl


-- b. Liste des commandes qui n’ont pas à la fois un portable, un écran et une souris :

SELECT /*+ no_query_transformation */ DISTINCT idCommande, dateCommande
FROM Commandes
WHERE idCommande NOT IN (SELECT DISTINCT idCommande
                         FROM LignesCommande
                         WHERE idProduit IN (SELECT idProduit
                                             FROM Produits
                                             WHERE categorieProduit = 'Portable')
                          INTERSECT
                         SELECT DISTINCT idCommande
                         FROM LignesCommande
                         WHERE idProduit IN (SELECT idProduit
                                             FROM Produits
                                             WHERE categorieProduit = 'Ecran')
                          INTERSECT
                         SELECT DISTINCT idCommande
                         FROM LignesCommande
                         WHERE idProduit IN (SELECT idProduit
                                             FROM Produits
                                             WHERE categorieProduit = 'Souris'));


-- c. Les dates auxquelles ont été passées une ou des commandes de moins de 9 000 € qui ont été payées en CB, et qui comprennent plus de 3 produits de la catégorie ‘Portable’ et plus de deux produits de la catégorie ‘Disque’.

SELECT DISTINCT dateCommande
FROM (SELECT co.idCommande, dateCommande, sexeClient, categorieProduit, montantCommande, etatCommande
      FROM Clients cl
      JOIN Commandes co ON cl.idClient = co.idClient
      JOIN LignesCommande lc ON co.idCommande = lc.idCommande
      JOIN Produits p ON p.idProduit = lc.idProduit
      GROUP BY co.idCommande, dateCommande, sexeClient, categorieProduit, montantCommande, etatCommande
      HAVING COUNT(*) > 3
      AND sexeClient = 'H'
      AND categorieProduit = 'Portable'
      AND montantCommande < 10000
      AND etatCommande = 'Payée CB'
      ORDER BY montantCommande)
INTERSECT
SELECT DISTINCT dateCommande
FROM (SELECT co.idCommande, dateCommande, sexeClient, categorieProduit, montantCommande, etatCommande
      FROM Clients cl
      JOIN Commandes co ON cl.idClient = co.idClient
      JOIN LignesCommande lc ON co.idCommande = lc.idCommande
      JOIN Produits p ON p.idProduit = lc.idProduit
      GROUP BY co.idCommande, dateCommande, sexeClient, categorieProduit, montantCommande, etatCommande
      HAVING COUNT(*) > 2
      AND sexeClient = 'H'
      AND categorieProduit = 'Disque'
      AND montantCommande < 10000
      AND etatCommande = 'Payée CB'
      ORDER BY cl.idClient);
