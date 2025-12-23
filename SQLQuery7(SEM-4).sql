use CSE_4A_214

--------------------Part _A-------------------
-- Create the Customers table 
CREATE TABLE Customers ( 
Customer_id INT PRIMARY KEY,                 
Customer_Name VARCHAR(250) NOT NULL,         
Email VARCHAR(50) UNIQUE                     
); -- Create the Orders table 
CREATE TABLE Orders ( 
Order_id INT PRIMARY KEY,                    
Customer_id INT,                             
Order_date DATE NOT NULL,                    
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
);




--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 
begin try

declare @num1 int = 10 , @num2 int = 0,@ans int
set @ans = @num1 / @num2

end Try
begin catch

print 'Divide by Zero Error Occures'

end catch

--2. Try to convert string to integer and handle the error using try…catch block. 
begin try

declare @str varchar(50) = 'Bhavy' , @msg int
set @msg = CAST(@str  as int)

end Try
begin catch

print 'Type Casting Error Occures'

end catch
--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result. 

Create or alter proc PR_Error_sum
@num1 int , @num2 int 
as
begin

Begin Try
print @num1
print @num2
declare @ans int
set @ans = @num1 + @num2
print @ans
End Try
Begin Catch
print 'error message :' + error_message()
print 'error state :' + CAST(error_state() as varchar(50))
print 'error! string value exception '
End Catch

end

exec PR_Error_sum 20,'51'
--4. Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state. 

Begin Try
insert into Customers values (null ,'Bhavy','bhavy@Gmail.com')
End Try
Begin Catch
print 'error message :' + error_message()
print 'error state :' + CAST(error_state() as varchar(50))
print 'error number :' + CAST(error_number() as varchar(50))
print 'error severity :' + CAST(error_severity() as varchar(50))
End Catch

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database.

CREATE PROCEDURE ER_CUSTOMERROR
	@CUSTOMER_ID INT
AS
BEGIN
	IF NOT EXISTS(SELECT Customer_id FROM Customers WHERE Customer_id=@CUSTOMER_ID)
	BEGIN
		THROW 51000, 'No Customer_id is available in the database.', 1;
	END
	ELSE
	BEGIN
		PRINT 'Customer_id EXISTS';
	END
END

EXEC ER_CUSTOMERROR 1
EXEC ER_CUSTOMERROR 2

BEGIN TRY
    INSERT INTO Orders (Order_id, Customer_id, Order_date)
    VALUES (1, 100, GETDATE());
END TRY
BEGIN CATCH
    PRINT 'Foreign Key Violation: Customer_id does not exist in the Customers table.';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;

--7. Throw custom exception that throws error if the data is invalid.
CREATE PROCEDURE SP_ValidateData
@CustomerName VARCHAR(250)
AS
BEGIN
    IF LEN(@CustomerName) = 0
    BEGIN
        THROW 51001, 'Invalid data: Customer name cannot be empty.', 1;
    END
    ELSE
    BEGIN
        PRINT 'Data is valid.';
    END
END

EXEC SP_ValidateData ''
EXEC SP_ValidateData 'Bhavy'

--8. Create a Procedure to Update Customer’s Email with Error Handling.
CREATE PROCEDURE SP_UpdateCustomerEmail
@Customer_id INT, @Email VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        UPDATE Customers
        SET Email = @Email
        WHERE Customer_id = @Customer_id;
        PRINT 'Email updated successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error updating email.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC SP_UpdateCustomerEmail 1, 'Bhavy@gmail.com'
EXEC SP_UpdateCustomerEmail 2, 'Prince@gmail.com'

--Part – C
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another one”.
CREATE PROCEDURE SP_InsertCustomer
@Customer_id INT, @Customer_Name VARCHAR(250), @Email VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customers (Customer_id, Customer_Name, Email)
        VALUES (@Customer_id, @Customer_Name, @Email);
        PRINT 'Customer inserted successfully.';
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 2627
        BEGIN
            PRINT 'The Customer_id is already taken. Try another one.';
        END
        ELSE
        BEGIN
            PRINT 'Error: ' + ERROR_MESSAGE();
        END
    END CATCH;
END;

EXEC SP_InsertCustomer 1, 'Bhavy', 'bhavy@gmail.com'
EXEC SP_InsertCustomer 2, 'Prince', 'Prince@gmail.com'

--10. Handle Duplicate Email Insertion in Customers Table.
BEGIN TRY
    INSERT INTO Customers (Customer_id, Customer_Name, Email)
    VALUES (3, 'Bhavy', 'bhavy@example.com');
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 2627
    BEGIN
        PRINT 'Duplicate Email Insertion: The email address already exists.';
    END
    ELSE
    BEGIN
        PRINT 'Error: ' + ERROR_MESSAGE();
    END
END CATCH;