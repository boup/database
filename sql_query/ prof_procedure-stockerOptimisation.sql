use Evaluation
select * from Vente

DROP TABLE SAS
DROP TABLE REJTECH


CREATE TABLE SAS ([Colonne 0] DATETIME, [Colonne 1] VARCHAR(20), [Colonne 2] VARCHAR(20))
CREATE TABLE REJTECH ([Colonne 0] VARCHAR(30), [Colonne 1] VARCHAR(20), [Colonne 2] VARCHAR(20))


IF OBJECT_ID ('Stocker','p') IS NOT NULL
DROP PROCEDURE Stocker;
GO

CREATE PROCEDURE Stocker
AS
	DECLARE @i int, @Nb_lignes int, @j int;
	SET @j=1;
	SET @i=2;
	WHILE (@j>0)
	BEGIN
		/* Cette requete nous renvoie chaque fois une ligne*/
				BEGIN TRY
					/* Insertions dans la table SAS*/								
					INSERT INTO SAS 
							SELECT [Colonne 0], [Colonne 1], [Colonne 2]
							FROM Vente
							WHERE Id=@i	
							SET @j=@@ROWCOUNT
				END TRY
		/* On regarde si la ligne renvoyée contient des informations manquantes pour les mettre dans la table REJTECH */		
				BEGIN CATCH
					/* Insertions dans la table REJTECH*/								
					INSERT INTO REJTECH 
							SELECT [Colonne 0], [Colonne 1], [Colonne 2]
							FROM Vente	
							WHERE Id=@i	
							SET @j=@@ROWCOUNT
				END CATCH
		SET @i=@i+1;		
	END
	
	EXEC Stocker
	GO
	
	SELECT * FROM SAS
	SELECT * FROM REJTECH