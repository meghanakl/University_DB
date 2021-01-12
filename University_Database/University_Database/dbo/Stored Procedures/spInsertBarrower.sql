CREATE PROCEDURE [dbo].[spInsertBarrower] @Title VARCHAR(3)
	,@First_Name VARCHAR(30)
	,@Last_Name VARCHAR(30)
	,@AddressLine1 VARCHAR(30)
	,@AddressLine2 VARCHAR(30)
	,@City VARCHAR(30)
	,@StateName VARCHAR(30)
	,@Country VARCHAR(30)
	,@PostCode VARCHAR(10)
	,@Mobile_Number_CountryCode VARCHAR(5)
	,@Mobile_Number VARCHAR(10)
	,@Email_Id VARCHAR(20)
	,@Barrower_Type VARCHAR(20)
AS
BEGIN
	IF NOT EXISTS (
			SELECT *
			FROM tbl_barrower
			WHERE (Email_Id = @Email_Id)
				OR (
					Mobile_Number_CountryCode = @Mobile_Number_CountryCode
					AND Mobile_Number = @Mobile_Number
					)
			)
	BEGIN
		INSERT INTO Tbl_Barrower (
			Title
			,First_Name
			,Last_Name
			,AddressLine1
			,AddressLine2
			,City
			,StateName
			,Country
			,PostCode
			,Mobile_Number_CountryCode
			,Mobile_Number
			,Email_Id
			,Barrower_Type
			,LastUpdated
			)
		VALUES (
			@Title
			,@First_Name
			,@Last_Name
			,@AddressLine1
			,@AddressLine2
			,@City
			,@StateName
			,@Country
			,@PostCode
			,@Mobile_Number_CountryCode
			,@Mobile_Number
			,@Email_Id
			,@Barrower_Type
			,getdate()
			)
	END
	ELSE
	BEGIN
		PRINT ('record already exist please provide another number and number')
	END
END
