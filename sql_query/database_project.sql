-- ==========================
--    Manager Database
-- =========================

-- -------------------------
-- Database - create

-- -------------------------
USE master
GO
IF DB_ID('manager') IS NOT NULL
DROP DATABASE manager
GO
IF DB_ID('manager') IS NULL
CREATE DATABASE manager
  GO

  USE manager;

-- ------------------------------------------------------
-- Tables - deleting 
-- ------------------------------------------------------
IF OBJECT_ID('trader', 'U') IS NOT NULL
DROP TABLE trader

IF OBJECT_ID('orders', 'U') IS NOT NULL
DROP TABLE orders

IF OBJECT_ID('schedule', 'U') IS NOT NULL
DROP TABLE schedule

IF OBJECT_ID('client', 'U') IS NOT NULL
DROP TABLE client

IF OBJECT_ID('accounter', 'U') IS NOT NULL
DROP TABLE accounter

IF OBJECT_ID('cash_journal', 'U') IS NOT NULL
DROP TABLE cash_journal

IF OBJECT_ID('bank_journal', 'U') IS NOT NULL
DROP TABLE bank_journal

IF OBJECT_ID('invoice', 'U') IS NOT NULL
DROP TABLE invoice


-- --------------------------------
-- Tables - creating
-- --------------------------------
IF OBJECT_ID('trader', 'U') IS NULL
CREATE TABLE trader (
  id     INT          NOT NULL PRIMARY KEY ,
  name   VARCHAR(100) NOT NULL,
  surname varchar(100) NOT NULL,
  status  varchar(100) NOT NULL,
  gender VARCHAR(7)   NOT NULL CHECK (gender IN ('MALE', 'FEMALE', 'UNKNOWN'))
)
  GO


IF OBJECT_ID ('orders', 'U') IS NULL
CREATE TABLE orders (
  id             INT          NOT NULL PRIMARY KEY,
  type_order varchar(50) NOT NULL,
   reception varchar(50) NOT NULL,
   quantity varchar(50) NOT NULL,
   trader_id INT NOT NULL FOREIGN KEY REFERENCES trader(id)
 
)
  GO

IF OBJECT_ID ('schedule', 'U') IS NULL
CREATE TABLE schedule (
  id   INT   NOT NULL PRIMARY KEY,
  date_sche Date   not null,
   place varchar(8000) not null,
  participation varchar(8000) not null,
  trader_id INT NOT NULL FOREIGN KEY REFERENCES trader(id)
)
  GO

IF OBJECT_ID ('client', 'U') IS NULL
CREATE TABLE client (
    id   INT      NOT NULL PRIMARY KEY,
    name_c varchar(50),
	surname_c varchar(50),
	localisation varchar(50),
   trader_id INT NOT NULL FOREIGN KEY REFERENCES trader(id)
)
  GO
IF OBJECT_ID('accounter', 'U') IS NULL
CREATE TABLE accounter (
  id     INT          NOT NULL PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  surname varchar(100) NOT NULL,
  status  varchar(100) NOT NULL,
  gender VARCHAR(7)   NOT NULL CHECK (gender IN ('MALE', 'FEMALE', 'UNKNOWN'))
)
GO
IF OBJECT_ID ('cash_journal', 'U') IS NULL
CREATE TABLE cash_journal (
  id     INT    NOT NULL PRIMARY KEY,
  date_cash Date,
  spent int,
  reception varchar(50),
  account_id INT NOT NULL FOREIGN KEY REFERENCES accounter(id)
)
  GO
IF OBJECT_ID ('bank_journal', 'U') IS NULL
CREATE TABLE bank_journal (
  id     INT    NOT NULL  PRIMARY KEY,
   name_bank varchar(50),
  recette int,
  date_bank Date,
  spent int,
  reception varchar(50),
  account_id INT NOT NULL FOREIGN KEY REFERENCES accounter(id)
)
GO
IF OBJECT_ID ('invoice', 'U') IS NULL
CREATE TABLE invoice (
  id     INT    NOT NULL  PRIMARY KEY,
   date_in date,
  wording varchar(50),
  amount varchar(50),
  contrat varchar(8000),
  account_id INT NOT NULL FOREIGN KEY REFERENCES accounter(id)
)

-- ---------------------------------
-- Inserting data to tables
-- ---------------------------------
INSERT INTO
  trader (id, name, surname,status, gender)
VALUES
  (1, 'jean', 'gueye', 'trainee','UNKNOWN'),
  (2, 'Armand', 'ndiaye','trainee','MALE'),
  (3, 'Anna', 'dembele','employee','FEMALE'),
  (4, 'khady', 'bengue','employee', 'FEMALE'),
  (5, 'david', 'ndong', 'employee','MALE'),
  (6, 'ermand', 'tony','employee', 'UNKNOWN'),
  (7, 'stephand', 'gomiz','trainee', 'MALE'),
  (8, 'rohani', 'ndour','trainee', 'MALE'),
  (9, 'Toma', 'faye','employee', 'UNKNOWN'),
  (10, 'amal', 'bourne','trainee', 'FEMALE'),
  (11, 'petit', 'mbaye','contractual', 'MALE'),
  (12, 'souley', 'dem', 'contractual','MALE'),
  (13, 'dembel', 'bengue','contractual', 'UNKNOWN'),
  (14, 'pape', 'diouf', 'pole manager','MALE'),
  (15, 'fatou', 'thioye', 'pole manager','FEMALE'),
  (16, 'ibou', 'lo', 'trainee','MALE');

INSERT INTO
  orders (id, type_order, reception, quantity, trader_id)
VALUES
  (1, 'chair', 'two day', 12, 11),
  (2, 'book', 'one day', 10, 9),
  (3, 'computer', 'week', 27,8),
  (4, 'paper', 'three day',24, 14),
  (5, 'stemp compagny','three week', 14,1),
  (6, 'board compagnny', 'two week', 30, 7),
  (7, 'lamp', 'one day', 70,4),
  (8, 'office supplies','four day', 41, 13),
  (9, 'student blouse','five day', 45, 15),
  (10, 'pharmacy box', 'ten day',57, 12),
  (11, 'markers','one month', 317, 5),
  (12, 'class materiel', 'one month',2000, 3),
  (13, 'cleaning office','three day', 115,2),
  (14, 'fixed phones','one day', 130, 10),
  (15, 'car','three month',23,6);
  
 

INSERT INTO
  schedule (id, date_sche, place, participation,trader_id)
VALUES
  (1, '2018-08-10', 'radisson', 'oracle,miscrosoft,primesoft,arvoto,medhub,creatuity', 3),
  (2, '2018-08-12', 'terrou bi', 'wbk,pekao,pko,amica,primesoft,arvoto,medhub,creatuity', 10),
  (3, '2018-08-14', 'mercure hotel', 'advox,biedronkao,racle,miscrosoft,primesoft', 5),
  (4, '2018-08-09', 'sharaton hotel', 'tesco,pearson,advox,oracle,auchan,orange,free', 4),
  (5, '2018-08-07', 'subtella', 'oracle,miscrosoft,ztm,primesoft,amica,wbk,pekao,millenium', 6),
  (6, '2018-08-13', 'NH Poznan', 'oracle,polsat,pesa sa,optimus sa,Netia,wkb,pko', 14),
  (7, '2018-08-15', 'radisson', 'miscrosoft,polsat,peas,neptium,polski bank', 15),
  (8, '2018-10-10', 'terrou bi', 'tesco,bridonka,advox,auchan,oracle,xtm,google', 13),
  (9, '2018-11-17', 'mercure hotel', 'miscrosoft,arvoto,medhub,creatuity,saturn', 1),
  (10, '2018-09-10', 'sharaton hotel', 'oracle,wbk,pekao,pko,amicapesa sa,optimus sa,Netia', 11);

INSERT INTO
  client (id, name_c, surname_c, localisation, trader_id)
VALUES
 (1, 'modou', 'ciss', 'senegal', 11),
  (2, 'deny', 'diaye', 'ukraine', 9),
  (3, 'peter', 'born', 'france',8),
  (4, 'lewanski', 'ski','poznan', 15),
  (5, 'ola','keryl', 'krow',4),
  (6, 'ola', 'kik', 'krakow', 7),
  (7, 'lamp', 'day', 'warsaw',4),
  (8, 'supplies','ciss','gdank',  13),
  (9, 'studik', 'blou', 'wroclaw', 10),
  (10, 'ola', 'box', 'bordeaux', 12);
 

INSERT INTO
  accounter (id, name, surname,status, gender)
VALUES
  (1, 'khady', 'sall', 'trainee','UNKNOWN'),
  (2, 'modou', 'ndiaye','trainee','MALE'),
  (3, 'wiki', 'dembele','employee','FEMALE'),
  (4, 'kouna', 'bengue','employee', 'FEMALE'),
  (5, 'saliou', 'ndong', 'employee','MALE'),
  (6, 'seydou', 'tony','employee', 'UNKNOWN'),
  (7, 'aladji', 'gomiz','trainee', 'MALE'),
  (8, 'doufi', 'ndour','trainee', 'MALE'),
  (9, 'joel', 'faye','employee', 'UNKNOWN'),
  (10, 'kadia', 'bourne','trainee', 'FEMALE'),
  (11, 'ibou', 'mbaye','contractual', 'MALE'),
  (12, 'baba', 'dem', 'contractual','MALE'),
  (13, 'am', 'bengue','contractual', 'UNKNOWN'),
  (14, 'senghane', 'diouf', 'pole manager','MALE'),
  (15, 'oumou', 'thioye', 'pole manager','FEMALE'),
  (16, 'karim', 'lo', 'trainee','MALE');
  
 INSERT INTO
   bank_journal(id,name_bank,recette,date_bank,spent,reception,account_id)
   VALUES
   (1,  'WBK', 3689, '2016-12-25',  1278, 'check', 4),
  (2, 'PKEAO', 7689, '2018-11-25',  2078, 'virement', 15),
(3,  'PKO', 6689, '2017-12-25',  1268, 'check', 14),
(4,  'MILLENIUM', 7689, '2018-10-25',  5900, 'check', 10),
(5,  'POLSKI', 19089, '2015-12-26',  3456, 'virement',11),
(6,  'BICIS',123689, '2017-09-25',  51278, 'check',7),
(7,  'OTTOWA', 13689, '2018-06-25',  9078, 'check', 3),
(8,  'UBA', 4689, '2018-02-25',  1138, 'virement', 6),
(9,  'GERMAN BANK', 5689, '2017-09-15',  4178, 'check', 9);

INSERT INTO
   cash_journal(
   id,
  date_cash,
  spent,
  reception,
  account_id)
   VALUES
   (1,  '2016-12-25',  4578, 'CENT', 14),
  (2, '2018-11-25',  1078, 'ONE MILLIONS', 5),
(3, '2017-12-25',  6268, 'TWO MILLIONS', 11),
(4,  '2018-10-25',  5900, 'THREE CENT', 1),
(5,  '2015-12-26',  4456, '1000 EURO',10),
(6,  '2017-09-25',  8278, '500 EURO',4),
(7,  '2018-06-25',  9778, '2000 EURO', 7),
(8,  '2018-02-25',  4138, '789 EURO', 3),
(9,  '2017-09-15',  45678, '4000 EURO', 8);

INSERT INTO
 invoice( id,
   date_in,
  wording,
  amount ,
  contrat,
  account_id)
VALUES
(1, '2016-12-30', 'computer', 12222, '28821_LesFormationsInfo.pdf',15),
(2, '2016-12-30', 'chair', 2220000, 'Exos-Sup-DAC.pdf', 1),
(3, '2017-01-14', 'salary', 500000, 'C P S.docx', 11),
(4, '2016-12-25', 'check', 150000, 'Aliko Dangote.docx', 12),
(5, '2017-01-26', 'transport', 15000, 'Autorisation-prelevement-boursiers.pdf',7),
(6, '2017-04-13', 'avion', 1690000, 'How to use the ODA simulator v2.pdf',8);


-- ---------------------------------
-- Views - creating
-- ---------------------------------
GO
IF OBJECT_ID('list_bank', 'V') IS NOT NULL
DROP VIEW list_bank
GO
create view list_bank as
(
   select 
    B.name_bank,B.date_bank,B.recette,B.spent,A.name,A.surname,A.status
	from
	bank_journal B,accounter A 
	where 
	 B.account_id=A.id
)
GO
IF OBJECT_ID('list_cash', 'V') IS NOT NULL
DROP VIEW list_cash
GO
CREATE VIEW list_cash AS (
  SELECT
    C.date_cash,C.spent,C.reception,A.name,A.surname,A.status
	from cash_journal C,accounter A
	where 
	  C.account_id=A.id)
GO	  
IF OBJECT_ID('list_invoice', 'V') IS NOT NULL
DROP VIEW list_invoice
GO
create view list_invoice as
   (
  SELECT
    I.date_in,I.amount,I.wording,A.name,A.surname,B.name_bank,B.recette,B.spent,A.status
	from invoice I,accounter A,bank_journal B
	where 
	  I.account_id=A.id
	  and
	  B.account_id=A.id
   )
GO	
IF OBJECT_ID('list_client', 'V') IS NOT NULL
DROP VIEW list_client
GO  
create view list_client as
   (
  SELECT
    c.name_c,c.surname_c,o.type_order,o.reception,t.name,t.surname,t.status
	from client c,orders o,trader t
	where 
	  c.trader_id=t.id
	  and
	  o.trader_id=t.id
   )

GO


-- ---------------------------------------------
-- Procedures - creating
-- ---------------------------------------------



IF OBJECT_ID('testclient', 'P') IS NOT NULL
DROP PROCEDURE testclient
GO

CREATE PROCEDURE testclient (
@name_c VARCHAR (50),
@surname_c VARCHAR(50)
) AS (
SELECT @name_c AS name_c, @surname_c AS surname_c
FROM client  AS c
WHERE name_c = @name_c   and surname_c=@surname_c
)
GO
IF OBJECT_ID('add_bank', 'P') IS NOT NULL
DROP PROCEDURE add_bank
GO

CREATE PROCEDURE add_bank (
@name_bank VARCHAR (50),
@reception varchar(50),
@account_id int
) AS (
SELECT @name_bank AS name_bank, @reception AS reception,@account_id as account_id
FROM bank_journal  AS b,accounter a 
WHERE name_bank = @name_bank and reception=@reception and account_id=@account_id and a.id=b.account_id

)
GO


-- ---------------------------------------------
-- Reports - creating
-- ---------------------------------------------

PRINT 'all the bank partners with the accounter who made the transfert'
SELECT *
FROM list_bank;

PRINT 'all the cash thing given by the manager with the acconter and status'
SELECT *
FROM list_cash;

PRINT 'the list of invoice made with the bank partners and accounter who made it'
SELECT *
FROM list_invoice;
PRINT 'excution of the procedure all the accounter id with the bank name and reception '
EXEC add_bank 'WBK', 'check', '4';

PRINT 'excution of the procedure all the client in the compagny'
EXEC testclient 'modou', 'ciss';

GO
-- ---------------------------------------------
-- trigger - creating
-- ---------------------------------------------
GO
IF OBJECT_ID('tuid_alterTables', 'P') IS NOT NULL
drop trigger tuid_alterTables ON DATABASE
GO
CREATE TRIGGER tuid_alterTables
	on DATABASE 
	FOR 
 Drop_Table, Alter_Table,Create_Table
  AS
		IF(datepart(HOUR,getdate())>7 or datepart(HOUR,getdate())<19)
		begin
			Print  'Impossible for update when during work '
			ROLLBACK
		end  
GO
USE master
GO
