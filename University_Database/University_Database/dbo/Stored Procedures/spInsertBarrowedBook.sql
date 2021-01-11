
CREATE  procedure [dbo].[spInsertBarrowedBook]
    
           @barrower_id int,
           @book_id int,
		       
    
    AS

    begin    
           if not exists (select * from Tbl_Barrowed_Book where Barrower_id= @barrower_id and Book_id=@book_id)
    begin
          insert into Tbl_Barrowed_Book(barrower_id,book_id, Barrowed_Date_Time, Return_date,LastUpdated)
          values(@barrower_id,@book_id ,getDate(), Null,getdate())
    end
else 
	begin 
print ('That book already taken by the same barrower so cannot insert')
    end
    end
