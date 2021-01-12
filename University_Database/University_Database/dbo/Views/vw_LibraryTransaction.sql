CREATE VIEW vw_LibraryTransaction
AS
SELECT br.ID LibraryId
	,br.First_Name + ' ' + br.Last_Name AS FullName
	,b.title AS BookName
	,bb.barrowed_date_time AS barrowedDate
	,bb.Return_date AS ReturnDate
	,br.Mobile_Number_CountryCode + br.Mobile_Number AS ContactNumber
FROM Tbl_Barrowed_Book bb
INNER JOIN Tbl_Book b ON bb.book_id = b.id
INNER JOIN Tbl_Barrower br ON br.id = bb.Barrower_id
