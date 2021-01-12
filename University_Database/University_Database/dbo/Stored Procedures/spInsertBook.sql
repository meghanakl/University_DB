CREATE PROCEDURE [dbo].[spInsertBook] @title VARCHAR(30)
	,@author VARCHAR(30)
	,@price DECIMAL(10, 2)
	,@published_date DATE
	,@purchased_date DATE
	,@quantity DECIMAL(5, 2)
AS
BEGIN
	IF NOT EXISTS (
			SELECT *
			FROM Tbl_Book
			WHERE (title = @title)
				AND (author = @author)
			)
		INSERT INTO Tbl_Book (
			title
			,author
			,price
			,published_date
			,purchased_date
			,quantity
			,LastUpdated
			)
		VALUES (
			@title
			,@author
			,@price
			,@published_date
			,@purchased_date
			,@quantity
			,getdate()
			)
END
