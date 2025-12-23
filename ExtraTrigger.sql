use CSE_A5_184

CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
	EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

--1)Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", "Employee record deleted"

CREATE OR ALTER TRIGGER tr_name
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
    print('one row inserted')
END;

CREATE OR ALTER TRIGGER tr_name_2
ON EMPLOYEEDETAILS
AFTER update
AS
BEGIN
    print('one row Updaed')
END;

CREATE OR ALTER TRIGGER tr_name_3
ON EMPLOYEEDETAILS
AFTER delete
AS
BEGIN
    print('one row deleted')
END;

--2)Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.
Create Trigger tr_name_6
on EMPLOYEEDETAILS
After Insert
as begin
	Declare @Id int,@Name varchar(100)
	Select @Id=EmployeeID from inserted
	Select EmployeeName=@Name from inserted
	
	Insert into EmployeeLogs(EmployeeId,EmployeeName,ActionPerformed,ActionDate) values(@Id,@Name,'Inserted',GETDATE())
End

Create Trigger tr_name_7
on EMPLOYEEDETAILS
After Update
as begin
	Declare @Id int,@Name varchar(100)
	Select @Id=EmployeeID from inserted
	Select EmployeeName=@Name from inserted
	
	Insert into EmployeeLogs(EmployeeID,EmployeeName,ActionPerformed,ActionDate) values(@Id,@Name,'Updated',GETDATE())
End

Create Trigger tr_name_8
on EMPLOYEEDETAILS
After Delete
as begin
	Declare @Id int,@Name varchar(100)
	Select @Id=EmployeeID from deleted
	Select @Name=EmployeeName from deleted
	
	Insert into EmployeeLogs(EmployeeID,EmployeeName,ActionPerformed,ActionDate) values(@Id,@Name,'deleted',GETDATE())
End

--3)Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and update a bonus column in the EmployeeDetails table.

Create Trigger tr_name_9
on EMPLOYEEDETAILS
After Insert
as begin
	Declare @Id int,@salary Decimal(5,2),@bn decimal(6,2)
	Select @salary=Salary from inserted
	Select @Id=EmployeeID from inserted
	set @bn = @salary*0.1
	
	Insert into EmployeeLogs(EmployeeId,EmployeeName,ActionPerformed,ActionDate) values(@Id,@salary,@bn,GETDATE())
End

--4)Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.

Create Trigger tr_name_10
on EMPLOYEEDETAILS
After Insert
as begin
	update EMPLOYEEDETAILS
	set JoiningDate=GETDATE()
	where JoiningDate is null and EmployeeID in (select EmployeeID from inserted)
end
insert into EMPLOYEEDETAILS values(18,'bhavy',0239865312,'student',120000,null)
select * from EMPLOYEEDETAILS

--5)Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)

Create Trigger tr_name_13
on EMPLOYEEDETAILS
After Insert,update
as begin
	declare @MOBNUM varchar(100),@Id int
	select @MOBNUM = ContactNo from inserted
	select @Id=EmployeeID from inserted
	if(LEN(@MOBNUM)!=10)
	begin
	print ('invalid')
	end
end





-----------------------------------------------INSTED OF TRIGGER----------------------------------------------

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);

--1.Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.

CREATE OR ALTER TRIGGER tr_1
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    Declare @Id int,@Name varchar(100)
	Select @Id=MovieID from inserted
	Select @Name=MovieTitle from inserted
	
	Insert into MoviesLog(MovieID,MovieTitle,ActionPerformed,ActionDate) values(@Id,@Name,'Inserted',GETDATE())
END;
drop Trigger tr_1
CREATE OR ALTER TRIGGER tr_2
ON Movies
INSTEAD OF update
AS
BEGIN
     Declare @Id int,@Name varchar(100)
	Select @Id=MovieID from inserted
	Select @Name=MovieTitle from inserted
	
	Insert into MoviesLog(MovieID,MovieTitle,ActionPerformed,ActionDate) values(@Id,@Name,'Updated',GETDATE())
END;

CREATE OR ALTER TRIGGER tr_3
ON Movies
INSTEAD OF delete
AS
BEGIN
     Declare @Id int,@Name varchar(100)
	Select @Id=MovieID from inserted
	Select @Name=MovieTitle from inserted
	
	Insert into MoviesLog(MovieID,MovieTitle,ActionPerformed,ActionDate) values(@Id,@Name,'Deleted',GETDATE())
END;	

--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .

	CREATE OR ALTER TRIGGER tr_4
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    Declare @Id int,@Rate Decimal(5,2)
	Select @Id=MovieID from inserted
	Select @Rate=Rating from inserted
	
	if(@Rate!=5.5)
		begin
			print('Rate Below 5.5')
		end
END;
drop Trigger tr_4

--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.

	

--4.	Create trigger that prevents to insert pre-release movies.

--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.
