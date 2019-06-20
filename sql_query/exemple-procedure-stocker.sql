
use Evaluation
DROP TABLE SAS
DROP TABLE REJTECH


CREATE TABLE SAS ([Colonne 0] DATETIME, [Colonne 1] VARCHAR(20), [Colonne 2] VARCHAR(20))

CREATE TABLE REJTECH ([Colonne 0] VARCHAR(30), [Colonne 1] VARCHAR(20), [Colonne 2] VARCHAR(20))


IF OBJECT_ID ('Stocker','p') IS NOT NULL
DROP PROCEDURE Stocker;
GO
use Evaluation
CREATE PROCEDURE Stocker
AS
	DECLARE @i int, @Nb_lignes int;
	SET @i=0;
	SET @Nb_lignes= ( SELECT COUNT (*) FROM Vente)
	WHILE (@Nb_lignes>@i)
	BEGIN
		/* Cette requete nous renvoie chaque fois une ligne*/
				BEGIN TRY
					/* Insertions dans la table SAS*/								
					INSERT INTO SAS 
							SELECT TOP 1 [Colonne 0], [Colonne 1], [Colonne 2]
							FROM Vente
							WHERE [Colonne 0] NOT IN (SELECT TOP (@i) [Colonne 0] FROM Vente)	
							
				END TRY
		/* On regarde si la ligne renvoyée contient des informations manquantes pour les mettre dans la table REJTECH */		
				BEGIN CATCH
					/* Insertions dans la table REJTECH*/								
					INSERT INTO REJTECH 
						SELECT TOP 1 [Colonne 0], [Colonne 1], [Colonne 2]
						FROM Vente
						WHERE [Colonne 0] NOT IN (SELECT TOP (@i) [Colonne 0] FROM Vente)
					
				END CATCH
		SET @i=@i+1;		
	END
	
	EXEC Stocker
	GO
	
	SELECT * FROM SAS
	SELECT * FROM REJTECH