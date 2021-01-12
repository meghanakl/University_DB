CREATE PROCEDURE spReturnBook @barrower_id INT
	,@book_id INT
AS
BEGIN
	UPDATE Tbl_Barrowed_Book
	SET return_date = GETDATE()
		,Lastupdated = GETDATE()
	WHERE (
			barrower_id = @barrower_id
			AND book_id = @book_id
			)
END
