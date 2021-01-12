CREATE PROCEDURE [dbo].[spInsertBarrowedBook] @barrower_id INT
	,@book_id INT
	
AS
BEGIN
	IF NOT EXISTS (
			SELECT *
			FROM Tbl_Barrowed_Book
			WHERE Barrower_id = @barrower_id
				AND Book_id = @book_id
			)
	BEGIN
		INSERT INTO Tbl_Barrowed_Book (
			barrower_id
			,book_id
			,Barrowed_Date_Time
			,Return_date
			,LastUpdated
			)
		VALUES (
			@barrower_id
			,@book_id
			,getDate()
			,NULL
			,getdate()
			)
	END
	ELSE
	BEGIN
		PRINT ('That book already taken by the same barrower so cannot insert')
	END
END
