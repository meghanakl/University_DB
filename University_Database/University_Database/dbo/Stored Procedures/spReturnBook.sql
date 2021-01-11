CREATE  procedure spReturnBook
       
           @barrower_id int,
           @book_id int
		  
    as
begin
     update  Tbl_Barrowed_Book 
	 set return_date = GETDATE(), Lastupdated = GETDATE()
	 where (barrower_id=@barrower_id and book_id=@book_id)
	
	
end

