

 CREATE procedure [dbo].[spInsertBarrower]
         
		 @Title varchar(3),
		 @First_Name varchar(30),
           @Last_Name varchar(30),
           @AddressLine1  varchar(30),
           @AddressLine2  varchar(30),
           @City  varchar(30),
           @StateName  varchar(30),
           @Country  varchar(30),
           @PostCode varchar(10),
           @Mobile_Number_CountryCode  varchar(5),
           @Mobile_Number  varchar(10),
           @Email_Id varchar(20),
           @Barrower_Type  varchar(20)
    as
	begin
	if not exists( Select * from tbl_barrower where (Email_Id=@Email_Id) or (Mobile_Number_CountryCode=@Mobile_Number_CountryCode and Mobile_Number=@Mobile_Number))
	begin
	insert into Tbl_Barrower(Title,First_Name,Last_Name,AddressLine1,AddressLine2 , City ,StateName  ,    Country  ,PostCode ,Mobile_Number_CountryCode ,Mobile_Number  ,Email_Id,Barrower_Type,LastUpdated)values(@Title,@First_Name ,
           @Last_Name ,
           @AddressLine1  ,
           @AddressLine2  ,
           @City ,
           @StateName  ,
           @Country  ,
           @PostCode ,
           @Mobile_Number_CountryCode  ,
           @Mobile_Number  ,
           @Email_Id ,
           @Barrower_Type ,
		   getdate())
          
	end
	else 
	begin 
	print ('record already exist please provide another number and number')
	end
	end

	

	
