
SPOOL project.out 
SET ECHO ON
/*
CIS 353 Team 2 Project: Library Database

Team Members:
	<Cameron Sprowls>
	<Dustin Thurston>
	<Josh Eldridge>
	<Ryan Jones>
*/

------------------------------------------
-- TODO:
--          -Constraints   (pls remember to add commas to existing Constraints when adding new ones <3)
--          -Fill the database with all the goodness
--          -Query the tables so good
------------------------------------------

-- DROP EXISTING TABLES
-------------------------------------------
DROP TABLE Branch CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Section CASCADE CONSTRAINTS;
DROP TABLE Book CASCADE CONSTRAINTS;
DROP TABLE Genres CASCADE CONSTRAINTS;
DROP TABLE Balances CASCADE CONSTRAINTS;
DROP TABLE CheckOut CASCADE CONSTRAINTS;



-- CREATING THE TABLES
-------------------------------------------

CREATE TABLE Employee
(
    empID       INTEGER		PRIMARY KEY,
    startDate   DATE        NOT NULL,
    endDate     DATE,
    name        CHAR(15)    NOT NULL,
    branchID    INTEGER     NOT NULL
);
CREATE TABLE Branch
(
	branchID    INTEGER 	PRIMARY KEY,
	brName      CHAR(200)   NOT NULL,
	managerID   INTEGER     NOT NULL,
-- ManagerID is a Foreign Key
    CONSTRAINT branchIC1 FOREIGN KEY (managerID) REFERENCES Employee(empID)
);
alter table Employee add CONSTRAINT employeeIC1 FOREIGN KEY (branchID) REFERENCES Branch(branchID)
DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE Customer
(
    custID      INTEGER 	PRIMARY KEY,
    name        CHAR(50)    NOT NULL,
    age         INTEGER NOT NULL,
    phoneNum    INTEGER,
    email       CHAR(50) CHECK (email like '%@%' and email like '%.%'),
--Customer must supply a phone number or an email to be valid
    CONSTRAINT custIC1 CHECK ((phoneNum is not null) or (email is not null))
);

CREATE TABLE Section
(
    secName     CHAR(15),
    branchID    INTEGER,
    maxBooks    INTEGER     NOT NULL,
    currNumBooks INTEGER    NOT NULL,
-- CsecName: section Name is unique
-- WHY IS SECNAME THE ONLY PRIMARY KEY
    CONSTRAINT secName PRIMARY KEY (secName),
--
--Branch id is a key, cannot be null
-- IF BRANCH ID IS A KEY WHY ARE YOU DOING JUST A NOT NULL CHECK *Facepalm*
    CONSTRAINT sectionIC1 CHECK (branchID is not null)
);

CREATE TABLE Book
(
    bookID      INTEGER 	PRIMARY KEY,
    author      CHAR(20)    NOT NULL,
    title       CHAR(35)    NOT NULL,
    secName     CHAR(15)    NOT NULL,
--Book must belong to a valid section
    CONSTRAINT bookIC1 FOREIGN KEY (secName) REFERENCES Section(secName)
);

CREATE TABLE Genres
(
    bookID      INTEGER,
    genre       CHAR(20),
	CONSTRAINT genresIC1 PRIMARY KEY(bookID, genre),
	CONSTRAINT genresIC2 FOREIGN KEY (bookID) REFERENCES Book(bookID),
	--CONSTRAINT genresIC3 CHECK (genre = 'Fiction' or genre = 'Non-fiction' or genre = 'Children')
);

CREATE TABLE Balances
(
    branchID    INTEGER,
    custID      INTEGER,
    balance     NUMBER(*,2) NOT NULL,
	CONSTRAINT balancesIC1 PRIMARY KEY (branchID, custID),
	CONSTRAINT balancesIC2 CHECK (NOT balance < 0.00)
);

CREATE TABLE CheckOut
(
    custID      INTEGER,
    checkOutDate DATE,
    dueDate     DATE,
    bookID      INTEGER,
	CONSTRAINT checkOutIC1 PRIMARY KEY (custID, checkOutDate),
	CONSTRAINT checkOutIC2 FOREIGN KEY (bookID) REFERENCES Book(bookID)
);

SET FEEDBACK OFF 

--INSERT STATEMENTS

--Employee----------------------------------------------------------
INSERT INTO EMPLOYEE VALUES (100, TO_DATE('10/2/12', 'MM/DD/YY'), NULL, 'Ian Watt', 10);
INSERT INTO EMPLOYEE VALUES (110, TO_DATE('04/12/12', 'MM/DD/YY'), TO_DATE('4/13/12', 'MM/DD/YY'), 'Ian Hall', 10);
INSERT INTO EMPLOYEE VALUES (120, TO_DATE('05/23/96', 'MM/DD/YY'), NULL, 'John Smith', 10);
INSERT INTO EMPLOYEE VALUES (130, TO_DATE('11/21/13', 'MM/DD/YY'), NULL, 'Rick Astley', 20);
INSERT INTO EMPLOYEE VALUES (140, TO_DATE('07/9/12', 'MM/DD/YY'), NULL, 'Bernie Kropp', 20);
INSERT INTO EMPLOYEE VALUES (150, TO_DATE('9/21/11', 'MM/DD/YY'), TO_DATE('10/23/11', 'MM/DD/YY'), 'Bonnie Mitko', 20);

--Branch-----------------------------------------------------------
INSERT INTO BRANCH VALUES (10, 'Grand Rapids Public Library', 100);
INSERT INTO BRANCH VALUES (20, 'Allendale Public Library', 140);
SET CONSTRAINT employeeIC1 IMMEDIATE;

--Sections--
INSERT INTO Section values ('Fiction', 10, 100, 50);
INSERT INTO Section values ('Nonfiction', 10, 100, 50);
INSERT INTO Section values ('Childrens', 10, 100, 50);

--Books-------------------------------------------------------------
-- If you're going to add unnecessary amount of spaces to make the joke, it's not worth it. Stop
INSERT INTO Book values (0123457, 'Bat Erry', 'Team is Total', 'Nonfiction');
INSERT INTO Book values (0123459, 'Doll Perry', 'An Hourly Diary of a Poor Man', 'Nonfiction');
INSERT INTO Book values (0123458, 'Car Fone', '2 is Too Much', 'Nonfiction');
INSERT INTO Book values (0123455, 'Josh Eldridge', 'A Study in Overused Phrases', 'Nonfiction');
INSERT INTO Book values (0123456, 'Al Fred', 'Give it All', 'Nonfiction');

--Customer----------------------------------------------------------
INSERT INTO Customer VALUES (1234, 'Bob Mad', 47, 9062825555, null);
INSERT INTO Customer VALUES (1235, 'Henry Ford', 80, 6162829999, 'inventor100@yahoo.com');
INSERT INTO Customer VALUES (1236, 'Thomas Hamilton', 25, 1231231234, null);
INSERT INTO Customer VALUES (1237, 'Dank Memes', 47, 5555554444, 'magnumdong@gmail.com');

--Balances----------------------------------------------------------
INSERT INTO Balances values (10, 1234, 0.00);
INSERT INTO Balances values (10, 1235, 0.00);
INSERT INTO Balances values (10, 1236, 0.00);
INSERT INTO Balances values (20, 1234, 0.00);
INSERT INTO Balances values (20, 1235, 0.00);
INSERT INTO Balances values (20, 1236, 0.00);
--Genres------------------------------------------------------------
-- What's the point of genres if section hold fiction/nonfiction/children?


--CheckOut------------------------------------------------------
INSERT INTO CheckOut values (1234, TO_DATE('10/2/17', 'MM/DD/YY'), TO_DATE('10/9/17', 'MM/DD/YY'), 0123455);
INSERT INTO CheckOut values (1234, TO_DATE('10/4/17', 'MM/DD/YY'), TO_DATE('10/11/17', 'MM/DD/YY'), 0123458);
INSERT INTO CheckOut values (1235, TO_DATE('10/4/17', 'MM/DD/YY'), TO_DATE('10/11/17', 'MM/DD/YY'), 0123455);
SET FEEDBACK ON
COMMIT;

--QUERIES-----------------------------------------------------------
select * from Employee; 
select * from Branch; 
select * from Customer;
select * from Section;
select * from Book;
select * from Balances;
select * from Checkout;

--Q1--Join involving at least four relations (to determine what customers have checked out a book)
Select distinct Cu.name
from Customer Cu, Section S, CheckOut Co, Book Bo
where Co.custID = Cu.custID and Co.bookID = Bo.bookID and Bo.secName = S.secName;

--Q2--Self-join (to see which customers above the age of 13 have the same age)
SELECT C1.custID, C2.custID
FROM Customer C1, Customer C2
WHERE C1.age > 13 AND
	C1.age = C2.age AND 
	C1.custID < C2.custID;

--Union, Intersect, and/or minus

--Sum, avg, max, and/or min


--GROUP BY, HAVING, and ORDER BY, all appearing in the same query

--A correlated subquery

--A non-correlated subquery

--A relational DIVISION query

--An outer join query

/*A RANK query
Rank Employees by date started only if they actively work there
*/

/* A Top-N query
Find the oldest customer of the library
*/
SELECT *
FROM (SELECT C.name, C.age
      FROM Customer C 
      ORDER BY age)
WHERE rownum = 1

/* BONUS Order By Query
find the title of books ordered by author
*/
Select title
from Book
order by author;

COMMIT;
SPOOL OFF 
