001- /* Définir le Chiffre d'Affaire par vendeur */
SELECT nomVendeur,vente.matricule,SUM(qtite*prix_unit) AS CA
FROM vente,vendeur
WHERE vente.matricule=vendeur.matricule
GROUP BY vente.matricule,nomVendeur
         /* OU */
WITH test as (
select matricule,SUM(qtite*prix_unit) AS CA
from vente
group by matricule)
select vendeur.matricule,nomVendeur,CA
from test,vendeur
where test.matricule=vendeur.matricule


1- /* Définir le Chiffre d'Affaire par vendeur et par mois */

SELECT nomVendeur,vente.matricule,SUM(qtite*prix_unit) AS CA,mois,annee
FROM vente,vendeur,date
WHERE vente.matricule=vendeur.matricule
GROUP BY vente.matricule,nomVendeur,mois,annee
ORDER BY annee,mois

2- /* Connaitre les ventes par client pour l'année 2012 ayant un CA supérieur à 100000 */

SELECT
FROM
WHERE


3- /* Connaitre les vendeurs (matricule et nom) qui n'ont pas fait de vente en 2013 en utilisant une jointure */

SELECT
FROM
WHERE


4- /* Connaitre les vendeurs (matricule et nom) qui n'ont pas fait de vente en 2013 en utilisant une EXISTS */

SELECT
FROM
WHERE


5- /* Connaitre les vendeurs (matricule et nom) ayant fait une vente en 2013 */

SELECT
FROM
WHERE

6- /* Connaitre le montant par famille */

SELECT famille,SUM(Montant)
FROM produit,achat
WHERE produit.Id_Produit=Achat.Id_Produit
GROUP BY famille

7- /* Procedure stockee pour charger des infor;ations de la table vendeur  a la table SAS */
IF OBJECT_ID ('Stocker','p') IS NOT NULL
DROP PROCEDURE Stocker;
GO

CREATE PROCEDURE Stocker1
AS
	DECLARE @i int, @Nb_lignes int;
	SET @i=1;
	SET @Nb_lignes= ( SELECT COUNT (ID_vendeur) FROM vendeur )
	WHILE (@Nb_lignes>=@i)
	BEGIN							
		INSERT INTO SAS 
			SELECT DISTINCT matricule, nom
			FROM vendeur
			WHERE Id_vendeur=@i	
		SET @i=@i+1;		
	END
	        /* OU */
	
CREATE PROCEDURE Stocker2
AS
	DECLARE @i int, @Nb_lignes int, @j int;
	SET @j=1;
	SET @i=1;
	WHILE (@j>0)
	BEGIN
		/* Insertions dans la table SAS*/								
		INSERT INTO SAS 
			SELECT DISTINCT matricule, nom //pour ne pas mettre de doublons dans la table SAS
			FROM vendeur
			WHERE Id_vendeur=@i	
			SET @j=@@ROWCOUNT
		SET @i=@i+1;		
END
