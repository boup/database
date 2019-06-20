-- ==========================
--    Manager Database
-- =========================

-- -------------------------
-- Database - create

-- -------------------------
USE master
GO
IF DB_ID('db_project') IS NOT NULL
DROP DATABASE db_project
GO
IF DB_ID('db_project') IS NULL
CREATE DATABASE db_project
  GO

  USE db_project;

-- ------------------------------------------------------
-- Tables - deleting 
-- ------------------------------------------------------
IF OBJECT_ID('university', 'U') IS NOT NULL
DROP TABLE university

IF OBJECT_ID('schedule', 'U') IS NOT NULL
DROP TABLE schedule

IF OBJECT_ID('subject', 'U') IS NOT NULL
DROP TABLE subject

IF OBJECT_ID('personnel', 'U') IS NOT NULL
DROP TABLE personnel

IF OBJECT_ID('years', 'U') IS NOT NULL
DROP TABLE years

IF OBJECT_ID('professor', 'U') IS NOT NULL
DROP TABLE professor

IF OBJECT_ID('student', 'U') IS NOT NULL
DROP TABLE student

IF OBJECT_ID('accounter', 'U') IS NOT NULL
DROP TABLE accounter

IF OBJECT_ID('marks', 'U') IS NOT NULL
DROP TABLE marks



-- --------------------------------
-- Tables - creating
-- --------------------------------
IF OBJECT_ID('university', 'U') IS NULL
CREATE TABLE university (
  id     INT          NOT NULL PRIMARY KEY ,
  name   VARCHAR(100) NOT NULL,
  faculty varchar(100) NOT NULL,
  departement  varchar(100) NOT NULL,
  country VARCHAR(100)   NOT NULL 
)
  GO


IF OBJECT_ID ('schedule', 'U') IS NULL
CREATE TABLE schedule (
  id             INT          NOT NULL PRIMARY KEY,
 begin_hours varchar(50) NOT NULL,
 end_hours varchar(50) NOT NULL,
 day varchar(50) NOT NULL
 )
  GO

IF OBJECT_ID ('subject', 'U') IS NULL
CREATE TABLE subject (
  id   INT   NOT NULL PRIMARY KEY,
  name_sub varchar(50)   not null,
  university_id INT NOT NULL FOREIGN KEY REFERENCES university(id),
  schedule_id INT NOT NULL FOREIGN KEY REFERENCES schedule(id)
)
  GO

IF OBJECT_ID ('personnel', 'U') IS NULL
CREATE TABLE personnel (
    id   INT      NOT NULL PRIMARY KEY,
    name_per varchar(50),
	position varchar(50),
	gender VARCHAR(7)   NOT NULL CHECK (gender IN ('MALE', 'FEMALE', 'UNKNOWN')),
   unversity_id INT NOT NULL FOREIGN KEY REFERENCES university(id)
)
  GO
IF OBJECT_ID('years', 'U') IS NULL
CREATE TABLE years (
  id     INT          NOT NULL PRIMARY KEY,
  semester   VARCHAR(100) NOT NULL,
  year varchar(100) NOT NULL
)
GO
IF OBJECT_ID ('student', 'U') IS NULL
CREATE TABLE student (
  id     INT    NOT NULL PRIMARY KEY,
  name_stu varchar(50),
  nationality varchar(50),
  age varchar(50),
  gender VARCHAR(7)   NOT NULL CHECK (gender IN ('MALE', 'FEMALE', 'UNKNOWN')),
  year_id INT NOT NULL FOREIGN KEY REFERENCES years(id),
  unversity_id INT NOT NULL FOREIGN KEY REFERENCES university(id)
)
  GO
IF OBJECT_ID ('professor', 'U') IS NULL
CREATE TABLE professor (
  id     INT    NOT NULL  PRIMARY KEY,
   name_prof varchar(50),
  nationality varchar(50),
  speciality varchar(50),
  year_id INT NOT NULL FOREIGN KEY REFERENCES years(id),
  unversity_id INT NOT NULL FOREIGN KEY REFERENCES university(id)
)
GO
IF OBJECT_ID ('accounter', 'U') IS NULL
CREATE TABLE accounter (
  id     INT    NOT NULL  PRIMARY KEY,
   date_ac date,
  amount varchar(1000),
  month varchar(50),
  year_id INT NOT NULL FOREIGN KEY REFERENCES years(id),
  unversity_id INT NOT NULL FOREIGN KEY REFERENCES university(id),
  student_id INT NOT NULL FOREIGN KEY REFERENCES student(id)
  
)
GO
IF OBJECT_ID ('marks', 'U') IS NULL
CREATE TABLE marks (
  id     INT    NOT NULL  PRIMARY KEY,
   mark int,
  grade int,
  year_id INT NOT NULL FOREIGN KEY REFERENCES years(id),
  unversity_id INT NOT NULL FOREIGN KEY REFERENCES university(id),
  student_id INT NOT NULL FOREIGN KEY REFERENCES student(id),
   professor_id INT NOT NULL FOREIGN KEY REFERENCES professor(id)
  
)


-- ---------------------------------
-- Inserting data to tables
-- ---------------------------------
INSERT INTO
  university (id, name, faculty,departement, country)
VALUES
  (1, 'university-of-croatia', 'mathematics', 'algebra','croatia'),
  (2, 'university-of-dakar', 'biology','chemistry','senegal'),
  (3, 'university-of-paris13', 'english','litterature','france'),
  (4, 'university-of-london', 'mathematics','analyse', 'UK'),
  (5, 'university-of-adam-mickiwi', 'biology', 'bioinformatics','poland'),
  (6, 'university-of-canada', 'algorithmic-and-robotics','algo', 'canada'),
  (7, 'university-of-bordeaux', 'chemistry','organics', 'france'),
  (8, 'university-of-warsaw', 'physicals','electronics', 'poland'),
  (9, 'university-of-belgium', 'philosophy','platon', 'belgium'),
  (10, 'university-of-nice', 'informatics','operating-system', 'france');
 

INSERT INTO
  schedule (id, begin_hours, end_hours,day)
VALUES
  (1, '12am', '14am','monday'),
  (2, '10am', '12am','wednesday'),
  (3, '09am', '11am','tuesday'),
  (4, '11am', '12am','friday'),
  (5, '08am', '10am','thursday'),
  (6, '08am', '12am', 'monday'),
  (7, '2pm', '4pm', 'friday'),
  (8, '08am', '10am', 'tuesday'),
  (9, '09am', '10am', 'wednesday'),
  (10, '09am', '11am', 'friday');
  

INSERT INTO
  subject (id, name_sub,unversity_id,schedule_id)
VALUES
  (1, 'algebra', 1, 3),
  (2, 'chemistry', 3, 2),
  (3, 'programming', 2, 5),
  (4, 'biology', 3, 4),
  (5, 'operating-system', 6,  6),
  (6, 'physics', 5, 7),
  (7, 'mathematics', 8, 10),
  (8, 'history', 9, 9),
  (9, 'english', 4, 1),
  (10, 'polish', 7, 8);

INSERT INTO
  personnel (id, name_per, position, gender,university_id)
VALUES
 (1, 'khady', 'main_dean','UNKNOWN',1),
  (2, 'modou', 'dean','MALE',6),
  (3, 'wiki', 'dean','FEMALE',5),
  (4, 'kouna', 'employed', 'FEMALE',4),
  (5, 'saliou', 'employed', 'MALE',3),
  (6, 'seydou', 'employed', 'UNKNOWN',7),
  (7, 'aladji', 'dean', 'MALE',8),
  (8, 'doufi', 'dean', 'MALE',2),
  (9, 'joel', 'employed', 'UNKNOWN',9),
  (10, 'kadia', 'administrator','FEMALE',10);

INSERT INTO
  years (id,semester,year)
VALUES
  (1, 'first-semester', '2016'),
  (2, 'fourth-semester', '2018'),
  (3, 'second-semester', '2011'),
  (4, 'third-semester', '2010'),
  (5, 'second-semester', '2003'),
  (6, 'fourth-semester', '2015'),
  (7, 'third-semester', '2013'),
  (8, 'seventh-semester', '2012'),
  (9, 'first-semester', '2018'),
  (10, 'fourth-semester', '2004');
  
  
 INSERT INTO
   student(id,name_stu,age,nationality,gender,year_id,unversity_id)
   VALUES
   (1,  'john', 18, 'gambia',  'MALE', 1, 4),
  (2, 'ado', 20, 'senegalese',  'MALE', 3, 5),
(3,  'wiki', 21, 'polska',  'FEMALE', 2, 4),
(4,  'kinga', 30,'croatia', 'FEMALE',  5, 10),
(5,  'mathieu', 19, 'germany',  'MALE', 4,1),
(6,  'kataruyne',15, 'russia',  'FEMALE', 8,7),
(7,  'OTTOWA', 24, 'france', 'UNKNOWN', 6, 3),
(8,  'karolina', 26, 'belgium',  'FEMALE', 7, 6),
(9,  'wikitoria', 22, 'polska',  'FEMALE', 9, 9),
(10,  'pippi', 28, 'polska',  'UNKNOWN', 10, 2);

INSERT INTO
   professor(id,name_prof,nationality,year_id,unversity_id)
   VALUES
   (1,  'johny', 'gambia', 1, 4),
  (2, 'adoo',  'senegalese', 3, 5),
(3,  'wikikk', 'polska',  2, 4),
(4,  'kingaaa','croatia', 5, 10),
(5,  'mathieum', 'germany', 4,1),
(6,  'kadia', 'russia', 8,7),
(7,  'manuel', 'france', 6, 3),
(8,  'lissa', 'belgium',  7, 6),
(9,  'kumpa','polska',  9, 9),
(10,  'justyna', 'polska',  10, 2);



INSERT INTO
   accounter(
   id,
   date_ac,
  amount,
  month,
  year_id,
  university_id,
  student_id)
   VALUES
   (1,  '2016-12-25',  '4578zloty', 'june', 1,2,3),
  (2, '2018-11-25',  '1078zloty', 'july', 2,1,2),
(3, '2017-12-25',  '6268zloty', 'may', 3,3,1),
(4,  '2018-10-25',  '5900zloty', 'april', 4,5,4),
(5,  '2015-12-26',  '4456zloty', 'december',10,9,5),
(6,  '2017-09-25',  '8278zloty', 'march',5,6,7),
(7,  '2018-06-25',  '9778zloty', 'january', 7,4,1),
(8,  '2018-02-25',  '4138zloty', 'october', 9,8,7),
(9,  '2017-09-15',  '4678zloty', 'november', 8,7,6),
(10,  '2017-09-15',  '4078zloty', 'february', 6,10,10);

INSERT INTO
 marks( id,
   mark,
  grade,
  year_id ,
  unversity_id,
  student_id,
  professor_id)
VALUES
(1, 60, 3, 2, 2,5,1),
(2, 63, 3, 1, 4,2, 2),
(3, 70, 3.5,5, 3, 1,3),
(4, 75, 4, 6, 5,6,7),
(5, 75, 4, 9, 10,7,8),
(6, 80, 4.5, 10, 9,1,5),
(7, 80, 4.5, 8, 2,4,5),
(8, 80, 4.5, 3, 6,1,2),
(9, 80, 4.5, 7, 8,3,10),
(10, 80, 4.5, 6, 6,7,9);


-- ---------------------------------
-- Views - creating
-- ---------------------------------
GO
IF OBJECT_ID('list_stu', 'V') IS NOT NULL
DROP VIEW list_stu
GO
create view list_stu as
(
   select 
   s.name_stu,m.grade,s.nationality,u.name
	from
	student s ,marks m,university u 
	where 
	 m.student_id=s.id and m.unversity_id=u.id
)
GO
IF OBJECT_ID('list_personel', 'V') IS NOT NULL
DROP VIEW list_personel
GO
CREATE VIEW list_personel AS (
  SELECT
    p.name_per,p.position,u.name
	from personnel p ,university u
	where 
	  p.unversity_id=u.id)
GO	  
IF OBJECT_ID('list_subject', 'V') IS NOT NULL
DROP VIEW list_subject
GO
create view list_subject as
   (
  SELECT
    s.name_sub,u.name,su.begin_hours,su.end_hours
	from subject s , university u,schedule su
	where 
	  s.unversity_id=u.id
	  and
	  s.schedule_id=su.id
   )


GO


-- ---------------------------------------------
-- Procedures - creating
-- ---------------------------------------------



IF OBJECT_ID('testyear', 'P') IS NOT NULL
DROP PROCEDURE testyear
GO

CREATE PROCEDURE testyear (
@semester VARCHAR(50),
@year VARCHAR(50)
) AS (
SELECT @semester AS semester, @year AS year FROM years  
WHERE semester = @semester and year=@year
)
GO
IF OBJECT_ID('testuniversity', 'P') IS NOT NULL
DROP PROCEDURE testuniversity
GO

CREATE PROCEDURE testuniversity (
@name VARCHAR (50),
@faculty varchar(50),
@departement varchar(50),
@pays varchar(50)
) AS (
SELECT @name AS name, @faculty AS faculty,@departement as departement, @pays as pays 
FROM unversity  AS b,accounter a 
WHERE name = @name and faculty=@faculty and departement=@departement 

)
GO


-- ---------------------------------------------
-- Reports - creating
-- ---------------------------------------------

PRINT 'set of   students with their grades and which university they studies'
SELECT *
FROM list_stu;

PRINT 'all the cash thing given by the manager with the acconter and status'
SELECT *
FROM list_subject;

PRINT 'the list of invoice made with the bank partners and accounter who made it'
SELECT *
FROM list_personel;
PRINT 'the university personne '
EXEC testuniversity 'university-dakar', 'informatics', 'algo','poland';

PRINT 'excution proc of semester and year from table years'
EXEC testyear 'first-semester', '2012';

GO

USE master
GO
