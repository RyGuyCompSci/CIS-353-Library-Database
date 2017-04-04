/*
CIS 353 Team 2 Project: Library Database

Team Members:
	Cameron Sprowls
	Dustin Thurston
	Josh Eldridge
	Ryan Jones
*/


------------------------------------------
-- TODO:
--          -Phone not null
--          -Email not null
--          -Constraints   (pls remember to add commas to existing Constraints when adding new ones <3)
------------------------------------------




-- DROP EXISTING TABLES
-------------------------------------------
SET ECHO ON 
DROP TABLE BRANCH CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE BOOK CASCADE CONSTRAINTS;
DROP TABLE GENRES CASCADE CONSTRAINTS;
DROP TABLE BALANCES CASCADE CONSTRAINTS;
DROP TABLE TRANSACTION CASCADE CONSTRAINTS;
SET ECHO OFF



-- CREATING THE TABLES
-------------------------------------------
CREATE TABLE Branch
(
    branchID    INTEGER,
    brName      CHAR(15)    NOT NULL,

--  CbranchID: BranchID is unique
    CONSTRAINT CbranchID PRIMARY KEY (branchID)
-- TODO: I think there's another constraint here 
--       based on manager, but I'm not sure
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
    custID      INTEGER
    phoneNum    INTEGER     NOT NULL,
    email       CHAR(50),
    age         NUMBER(3,1) NOT NULL,
    numBooks    INTEGER     NOT NULL,
    memExpDate  DATE        NOT NULL,

-- CcustID: Customer ID is unique
    CONSTRAINT CcustID PRIMARY KEY (custID)
);

CREATE TABLE SECTION
(
    secName     CHAR(15),
    branchID    INTEGER,
    maxBooks    INTEGER     NOT NULL,
    currNumBooks INTEGER    NOT NULL,

-- CsecName: section Name is unique
    CONSTRAINT secName PRIMARY KEY (secName),
);

CREATE TABLE BOOK
(
    bookID      INTEGER,
    author      CHAR(20)    NOT NULL,
    title       CHAR(30)    NOT NULL,
    secName     CHAR(15)    NOT NULL,

-- CbookID: bookID is unique
    CONSTRAINT bookID PRIMARY KEY (bookID)

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
    dueDate     DATE
    --ahhhhhhh help pls
);