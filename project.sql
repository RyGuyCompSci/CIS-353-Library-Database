
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
DROP TABLE Transactionz CASCADE CONSTRAINTS;


CREATE TABLE Employee
(
    empID       INTEGER,--		PRIMARY KEY,
    startDate   DATE        NOT NULL,
    endDate     DATE NULL,
    name        CHAR(15)    NOT NULL,
    branchID    INTEGER     NOT NULL, 
-- keep track of branch they work at
-- CempID: employee id is unique
    CONSTRAINT CempID PRIMARY KEY (empID)        
);

-- CREATING THE TABLES
-------------------------------------------
CREATE TABLE Branch
(
	branchID    INTEGER,
	brName      CHAR(200)    NOT NULL,
	managerID   INTEGER     NOT NULL,
--  CbranchID: BranchID is unique
	CONSTRAINT branchIC1 PRIMARY KEY (branchID),
-- ManagerID is a Foreign Key
    CONSTRAINT branchIC2 FOREIGN KEY (ManagerID) REFERENCES Employee(empID)
);

CREATE TABLE Customer
(
    custID      INTEGER,
    name        CHAR(50)    NOT NULL,
    age         NUMBER(3,1) NOT NULL,
    phoneNum    INTEGER,
    email       CHAR(50),
--
-- CcustID: Customer ID is unique
    CONSTRAINT CcustID PRIMARY KEY (custID),
--
--Customer must supply a phone number or an email to be valid
    CONSTRAINT custIC1 CHECK ((phoneNum is not null) or (email is not null)),
--
--Email must have at sign and a period to be valid
    CONSTRAINT cutsIC2 CHECK (email like '%@%' and email like '%.%')
);

CREATE TABLE Section
(
    secName     CHAR(15),
    branchID    INTEGER,
    maxBooks    INTEGER     NOT NULL,
    currNumBooks INTEGER    NOT NULL,
-- CsecName: section Name is unique
    CONSTRAINT secName PRIMARY KEY (secName),
--
--Branch id is a key, cannot be null
    CONSTRAINT sectionIC1 CHECK (branchID is not null)
);

CREATE TABLE Book
(
    bookID      INTEGER,
    author      CHAR(20)    NOT NULL,
    title       CHAR(30)    NOT NULL,
    secName     CHAR(15)    NOT NULL,
--
-- CbookID: bookID is unique
    CONSTRAINT bookID PRIMARY KEY (bookID),
--
--Book must belong to a valid section
    CONSTRAINT bookIC1 FOREIGN KEY (secName) REFERENCES SECTION(secName)
);

CREATE TABLE Genres
(
    bookID      INTEGER,
    genre       CHAR(20),
	CONSTRAINT genresIC1 FOREIGN KEY (bookID) REFERENCES Book(bookID)
);

CREATE TABLE Balances
(
    branchID    INTEGER,
    custID      INTEGER,
    balance     NUMBER(*,2) NOT NULL,
	CONSTRAINT balancesIC1 PRIMARY KEY (branchID, custID)
);

CREATE TABLE Transactionz
(
    custID      INTEGER,
    checkOutDate DATE,
    dueDate     DATE,
    bookID      INTEGER,
	CONSTRAINT transactionsIC1 PRIMARY KEY (custID, checkOutDate)
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


--Sections--
insert into Section values ('Fiction', 10, 100, 50);
insert into Section values ('Nonfiction', 10, 100, 50);


--Customer----------------------------------------------------------
INSERT INTO Customer VALUES (1234, 'Bob Mad', 47, 9062825555, 'bobm@gmail.com');
INSERT INTO Customer VALUES (1235, 'Henry Ford', 47, 6162829999, 'inventor100@yahoo.com');
INSERT INTO Customer VALUES (1236, 'Thomas Hamilton', 25, 1231231234, null);

--Books-------------------------------------------------------------
insert into Book values (0123456, 'Al Fred', 'Give it All', 'Nonfiction');
insert into Book values (0123457, 'Bat Erry', 'Team is Total', 'Nonfiction');
insert into Book values (0123458, 'Car Fone', '2 is Too Much', 'Nonfiction');
insert into Book values (0123459, 'Doll Perry', 'An Houly Diary of a Poor Man', 'Nonfiction');
insert into Book values (0123455, 'Josh Eldridge', 'A Study in Overused Phrases', 'Nonfiction');


SET FEEDBACK ON
COMMIT;

--QUERIES-----------------------------------------------------------
/*
Select *
from Employee;

Select *
from Branch;

Select *
from Customer;

Select *
from Section;
*/
Select title
from Book
where like ('% ')
order by author;

COMMIT;
SPOOL OFF 
