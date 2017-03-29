/*
CIS 353 Team 2 Project: Library Database

Team Members:
	Cameron Sprowls
	Dustin Thurston
	Josh Eldridge
	Ryan Jones
*/

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
    startDate   CHAR(15)    NOT NULL,
    endDate     CHAR(15),
    branchID    INTEGER     NOT NULL, -- keep track of branch they worked at

    --TODO: add constraints
);