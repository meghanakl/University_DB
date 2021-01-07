create view vw_LibraryTransaction
as 
select br.ID LibraryId,
br.First_Name + ' ' + br.Last_Name as FullName,
b.title as BookName,
bb.barrowed_date_time as barrowedDate,
bb.Return_date as ReturnDate,
br.Mobile_Number_CountryCode + br.Mobile_Number as ContactNumber 

from Tbl_Barrowed_Book bb
inner join Tbl_Book b on bb.book_id = b.id
inner join Tbl_Barrower br on br.id = bb.Barrower_id