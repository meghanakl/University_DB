CREATE FUNCTION [dbo].[getNthQuantity] (@n INT)
RETURNS INT
AS
BEGIN
declare	@quantity INT

	SELECT @quantity = quantity

	FROM (
		SELECT Quantity
			,DENSE_RANK() OVER (
				ORDER BY quantity DESC
				) AS Rankid
		FROM Tbl_Book
		) AS Result
	WHERE Rankid = 1

	RETURN @quantity
END
