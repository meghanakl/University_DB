CREATE  procedure spReturnBook
           @id int,
           @barrower_id int,
           @book_id int,
		   @brrowed_Date_time datetime,
		   @return_date date
           
    as
begin
     update  Tbl_Barrowed_Book 
	 set return_date = GETDATE()
	 where (barrower_id=@barrower_id and book_id=@book_id)
	
	insert into Tbl_Barrowed_Book(id,barrower_id,book_id ,brrowed_Date_time,return_date)
          values(@id,@barrower_id,@book_id ,@brrowed_Date_time,@return_date)
end

