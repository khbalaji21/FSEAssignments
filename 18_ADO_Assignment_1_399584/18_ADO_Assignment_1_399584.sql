--18 ADO Assignment 1 399584 BalajiSingh
USE FSE;
CREATE TABLE [dbo].[Product_Details](
	[Product_Id] [char](5) NOT NULL,
	[Product_Name] [varchar](40) NOT NULL,
	[Supplier_Id] [char](5) NULL
);

GO


CREATE TABLE [dbo].[Supplier_Info](
	[Supplier_Id] [char](4) NOT NULL,
	[Supplier_Name] [varchar](40) NOT NULL,
	[Address] [char](40) NULL,
	[City] [char](40) NULL,
	[Contact_No] [char](40) NULL,
	[Email] [char](40) NULL
);

GO


Create procedure [dbo].[AddNewProductDetails]  
(  
   @Product_Id varchar (5),  
   @Product_Name varchar (40),  
   @Supplier_Id varchar (5)  
)  
as  
begin  
   Insert into Product_Details values(@Product_Id, @Product_Name, @Supplier_Id)  
End  
Go
Create Procedure [dbo].[GetProducts]  
as  
begin  
   select * from Product_Details  
End  
Go
Create procedure [dbo].[UpdateProducts]  
(  
   @Product_Id int,  
   @Product_Name varchar (50),  
   @Supplier_Id varchar (50)
)  
as  
begin  
   Update Product_Details   
   set Product_Name=@Product_Name
   where Product_Id=@Product_Id
End  
Go
Create procedure [dbo].[DeleteProductbyId]  
(  
   @Product_Id int  
)  
as   
begin  
   Delete from Product_Details where Product_Id=@Product_Id 
End  


-- Supplier Procedures
Go
Create procedure [dbo].[AddNewSupplierDetails] 
( 
   @supplier_id varchar (4), 
   @supplier_name varchar (40), 
   @address varchar (40),
   @city varchar (40), 
   @contact_no varchar (40), 
   @email varchar (40)
) 
as 
begin 
   Insert into Supplier_Info values(@supplier_id, @supplier_name, @address, @city, @contact_no, @email) 
End 
Go
Create Procedure [dbo].[GetSuppliers] 
as 
begin 
   select * from Supplier_Info 
End 
Go
Drop PROC UpdateProducts
Go
Create procedure [dbo].[UpdateSupplier] 
( 
   @supplier_id varchar (4), 
   @supplier_name varchar (40), 
   @address varchar (40),
   @city varchar (40), 
   @contact_no varchar (40), 
   @email varchar (40)
) 
as 
begin 
   Update Supplier_Info  
   set Supplier_Name=@supplier_name, Address = @address, City = @city, Contact_No = @contact_no, Email = @email
   where Supplier_Id=@supplier_id
End 
Go
Drop Proc DeleteProductbyId
Go
Create procedure [dbo].[DeleteSupplierbyId] 
( 
   @supplier_id varchar(4) 
) 
as  
begin 
   Delete from Supplier_Info where Supplier_Id=@supplier_id
End
