/*
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
DROP TABLE BRANCH CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE BOOK CASCADE CONSTRAINTS;
DROP TABLE GENRES CASCADE CONSTRAINTS;
DROP TABLE BALANCES CASCADE CONSTRAINTS;
DROP TABLE TRANSACTION CASCADE CONSTRAINTS;



-- CREATING THE TABLES
-------------------------------------------
CREATE TABLE Branch
(
    branchID    INTEGER,
    brName      CHAR(15)    NOT NULL,
    managerID   INTEGER     NOT NULL,

--  CbranchID: BranchID is unique
    CONSTRAINT CbranchID PRIMARY KEY (branchID)

-- ManagerID is a Foreign Key
    CONSTRAINT branchIC1 FOREIGN KEY (ManagerID) 
                REFERENCES Employee(empID)
);

CREATE TABLE Employee
(
    empID       INTEGER,
    name        CHAR(15)    NOT NULL,
    startDate   DATE        NOT NULL,
    endDate     DATE,
    branchID    INTEGER     NOT NULL, -- keep track of branch they worked at

-- CempID: employee id is unique
    CONSTRAINT CempID PRIMARY KEY (empID)
                
);

CREATE TABLE CUSTOMER
(
    custID      INTEGER	    PRIMARY KEY,
    phoneNum    INTEGER,
    name        CHAR(15)    NOT NULL,
    email       CHAR(50),
    age         NUMBER(3,1) NOT NULL,
    memExpDate  DATE        NOT NULL,

-- CcustID: Customer ID is unique
    CONSTRAINT CcustID PRIMARY KEY (custID),

--Customer must supply a phone number or an email to be valid
    CONSTRAINT custIC1 CHECK ((phoneNum not (is null)) or (email not (is null))),

--Email must have at sign and a period to be valid
    CONSTRAINT cutsIC2 CHECK (email like '%@%' and email like '%.%')
);

CREATE TABLE SECTION
(
    secName     CHAR(15),
    branchID    INTEGER,
    maxBooks    INTEGER     NOT NULL,
    currNumBooks INTEGER    NOT NULL,

-- CsecName: section Name is unique
    CONSTRAINT secName PRIMARY KEY (secName),
    CONSTRAINT sectionIC1 CHECK (branchID not(is null))
);

CREATE TABLE BOOK
(
    bookID      INTEGER,
    author      CHAR(20)    NOT NULL,
    title       CHAR(30)    NOT NULL,
    secName     CHAR(15)    NOT NULL,

-- CbookID: bookID is unique
    CONSTRAINT bookID PRIMARY KEY (bookID)
    CONSTRAINT bookIC1 CHECK ()
);

CREATE TABLE GENRES
(
    bookID      INTEGER,
    genre       CHAR(20),
    --idk what to do here...
);

CREATE TABLE BALANCES
(
    branchID    INTEGER,
    custID      INTEGER,
    balance     NUMBER(*,2) NOT NULL
    --idk how to deal with two keys, halp

);

CREATE TABLE TRANSACTION
(
    custID      INTEGER,
    checkOutDate DATE,
    dueDate     DATE,
    bookID      INTEGER
    --ahhhhhhh help pls
);

SET FEEDBACK OFF 

--INSERT STATEMENTS

--Branch-----------------------------------------------------------
INSERT INTO BRANCH VALUES (10, 'Grand Rapids Public Library', 100);
INSERT INTO BRANCH VALUES (20, 'Allendale Public Library', 140);



--Employee----------------------------------------------------------
INSERT INTO EMPLOYEE VALUES (100, TO_DATE('10/2/12', 'MM/DD/YY'), NULL, 'Ian Watt', 10);
INSERT INTO EMPLOYEE VALUES (110, TO_DATE('04/12/12', 'MM/DD/YY'), TO_DATE('4/13/12', 'MM/DD/YY', 'Ian Hall', 10);
INSERT INTO EMPLOYEE VALUES (120, TO_DATE('05/23/96', 'MM/DD/YY'), NULL, 'John Smith', 10);
INSERT INTO EMPLOYEE VALUES (130, TO_DATE('11/21/13', 'MM/DD/YY'), NULL, 'Rick Astley', 20);
INSERT INTO EMPLOYEE VALUES (140, TO_DATE('07/9/12', 'MM/DD/YY'), NULL, 'Bernie Kropp', 20);
INSERT INTO EMPLOYEE VALUES (150, TO_DATE('9/21/11', 'MM/DD/YY'), TO_DATE('10/23/11'), 'Bonnie Mitko', 20);

--Customer----------------------------------------------------------
INSERT INTO CUSTOMER VALUES (1234, 9062825555, 'Bob Mad' 'bobm@gmail.com', 47, TO_DATE('10/20/17', 'MM/DD/YY'));
INSERT INTO CUSTOMER VALUES (1235, 6162829999, 'Henry Ford', 'inventor100@yahoo.com', 47, TO_DATE('10/20/17', 'MM/DD/YY'));


SET FEEDBACK ON
COMMIT;

-- Queries

COMMIT;
SPOOL OFF 
