-- Creating PersonInfo Table 

CREATE TABLE PersonInfo ( 
PersonID INT PRIMARY KEY, 
PersonName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8,2) NOT NULL, 
JoiningDate DATETIME NULL, 
City VARCHAR(100) NOT NULL, 
Age INT NULL, 
BirthDate DATETIME NOT NULL 
);

-- Creating PersonLog Table 

CREATE TABLE PersonLog ( 
PLogID INT PRIMARY KEY IDENTITY(1,1), 
PersonID INT NOT NULL, 
PersonName VARCHAR(250) NOT NULL, 
Operation VARCHAR(50) NOT NULL, 
UpdateDate DATETIME NOT NULL, 
FOREIGN KEY (PersonID) REFERENCES PersonInfo(PersonID) ON DELETE CASCADE 
);

-----------------------------PART-A--------------------------------------------

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display a message “Record is Affected.”



--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 



--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 



--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into uppercase whenever the record is inserted. 



--5. Create trigger that prevent duplicate entries of person name on PersonInfo table. 



--6. Create trigger that prevent Age below 18 years.


