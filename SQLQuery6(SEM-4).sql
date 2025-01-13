use CSE_A5_184

--  Create the Products table 

CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
); 

--  Insert data into the Products table 

INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

-----------------------------------PART-A-----------------------------------

--1. Create a cursor Product_Cursor to fetch all the rows from a products table. 

	Declare @pId int,
			@pName varchar(50),
			@price Decimal(8,2)

	Declare Product_Cursor cursor for
	select * from Products

	open Product_Cursor

	fetch next from Product_Cursor
	into @pId,@pName,@price;

	while(@@FETCH_STATUS=0)
		begin
			print cast(@pId as varchar(50))+'-'+@pName+'-'+cast(@price as varchar(50))
			fetch next from Product_Cursor 
			into @pId,@pName,@price
		end

	close Product_Cursor

	Deallocate Product_Cursor

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. (Example: 1_Smartphone) 

	Declare @id int,
			@name varchar(50)

	Declare Product_Cursor_Fetch cursor for 
	select Product_id,Product_Name from Products

	open Product_Cursor_Fetch

	fetch next from Product_Cursor_Fetch
	into @id,@name;

	while @@FETCH_STATUS=0
		begin
		
				print cast(@id as varchar(50))+'-'+@name
				fetch next from Product_Cursor_Fetch
				into @id,@name;

		end

		close Product_Cursor_Fetch

		Deallocate Product_Cursor_Fetch
		
--3. Create a Cursor to Find and Display Products Above Price 30,000. 

	Declare @p int
			
	Declare Product_Cursor_p cursor for
	select Price from Products

	open Product_Cursor_p

	fetch next from Product_Cursor_p
	into @p;

	while(@@FETCH_STATUS=0)
		begin
			
			if(@p>30000)
				begin
					print cast(@p as varchar(50))
				end	
				fetch next from Product_Cursor_p 
				into @p
		end

	close Product_Cursor_p

	Deallocate Product_Cursor_p

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

	Declare @pId1 int,
			@pName1 varchar(50),
			@price1 Decimal(8,2)

	Declare Product_CursorDelete cursor for
	select * from Products

	open Product_CursorDelete

	fetch next from Product_CursorDelete 
	into @pId1,@pName1,@price1;

	while(@@FETCH_STATUS=0)
		begin
			delete from Products
			where Product_id=@pId1 and Product_Name=@pName1 and Price=@price1
			fetch next from Product_CursorDelete 
			into @pId1,@pName1,@price1
		end

	close Product_CursorDelete

	Deallocate Product_CursorDelete

