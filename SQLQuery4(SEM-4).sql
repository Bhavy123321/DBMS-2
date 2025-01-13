--1. Write a function to print "hello world". 

CREATE OR ALTER FUNCTION FN_HELLOWORLD()
RETURNS VARCHAR(50)
AS 
BEGIN
		RETURN 'HELLO WORLD'
END

SELECT dbo.FN_HELLOWORLD()

--2. Write a function which returns addition of two numbers. 

CREATE OR ALTER FUNCTION FN_ADDITION(
@N1 INT,
@N2 INT
)
RETURNS INT
AS 
BEGIN
		RETURN @N1+@N2
END

SELECT dbo.FN_ADDITION(10,20) AS ADDITION

--3. Write a function to check whether the given number is ODD or EVEN. 

CREATE OR ALTER FUNCTION FN_ODDEVEN(
@N1 INT
)
RETURNS VARCHAR(50)
AS 
BEGIN
		DECLARE @ANSWER VARCHAR(50)=''
		IF (@N1%2=0)
			SET @ANSWER='EVEN'
		ELSE 
			SET @ANSWER='ODD'

		RETURN @ANSWER
END

SELECT dbo.FN_ODDEVEN(5) AS ODDorEVEN

--4. Write a function which returns a table with details of a person whose first name starts with B.

CREATE OR ALTER FUNCTION FN_FIRSTNAME()
RETURNS TABLE
AS
	RETURN(SELECT FirstName FROM Person WHERE FirstName LIKE 'B%')

SELECT * FROM FN_FIRSTNAME()

--5. Write a function which returns a table with unique first names from the person table. 

CREATE OR ALTER FUNCTION FN_UniqueFirstName()
RETURNS TABLE
AS
	RETURN(SELECT DISTINCT(FirstName) FROM Person)

SELECT * FROM FN_UniqueFirstName()

--6. Write a function to print number from 1 to N. (Using while loop) 

CREATE OR ALTER FUNCTION FN_1toNnumbers(@N INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ANSWER AS VARCHAR(200)
	SET @ANSWER=''
	DECLARE @I AS INT 
	SET @I=1
	WHILE @I<=@N
	BEGIN
		SET @ANSWER =@ANSWER+CAST(@I AS varchar)+','
		SET @I=@I+1
	END
	RETURN @ANSWER
END

SELECT DBO.FN_1toNnumbers(10) AS NUMBERS
--7. Write a function to find the factorial of a given integer.

CREATE OR ALTER FUNCTION FN_FACTORIAL(@N INT)
RETURNS INT 
AS
BEGIN
	DECLARE @ANSWER AS INT
	SET @ANSWER=1
	DECLARE @I AS INT 
	SET @I=1
	WHILE @I<=@N
	BEGIN
		SET @ANSWER = @ANSWER*@I
		SET @I=@I+1
	END
	RETURN @ANSWER
END

SELECT DBO.FN_FACTORIAL(5) AS FACTORIAL

-------------EXTRAA
--USER FIRST LATTER ENTER KARE ENATHI START THATU NAME RETURN

CREATE OR ALTER FUNCTION FN_EXTRA(@FL VARCHAR(50))
RETURNS TABLE
AS
	RETURN(	SELECT FirstName FROM Person 
			WHERE FirstName LIKE @FL+'%'
			)

SELECT * FROM FN_EXTRA('R')

-------------------------------------------PART-B------------------------------------------------------

--8. Write a function to compare two integers and return the comparison result. (Using Case statement) 

CREATE OR ALTER FUNCTION FN_COMPERISION(
@N1 INT,
@N2 INT
)
RETURNS VARCHAR(500)
AS 
BEGIN
		DECLARE @ANSWER AS VARCHAR(500)
		IF(@N1<@N2)
			SET @ANSWER = 'NUMBER 1 IS LESS THAN NUMBER 2'
		ELSE IF(@N1>@N2)
			SET @ANSWER = 'NUMBER 1 IS GREAER THAN NUMBER 2'
		ELSE
			SET @ANSWER = 'BOTH ARE EQUAL'
	RETURN @ANSWER
END

SELECT dbo.FN_COMPERISION(10,20) AS COMPERISION

--9. Write a function to print the sum of even numbers between 1 to 20. 

	CREATE OR ALTER FUNCTION FN_SUMofEVENnumbers(@N INT)
	RETURNS INT
	AS 
	BEGIN
		DECLARE @ANSWER INT=0
		DECLARE @I AS INT=1
		WHILE @I<=@N
		BEGIN
		IF(@I%2=0)
			SET @ANSWER=@ANSWER+@I
			SET @I=@I+1
		END
		RETURN @ANSWER
	END

	SELECT DBO.FN_SUMofEVENnumbers(20)

--10. Write a function that checks if a given string is a palindrome

