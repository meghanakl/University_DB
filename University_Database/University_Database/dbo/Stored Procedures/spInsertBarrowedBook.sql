
CREATE  procedure [dbo].[spInsertBarrowedBook]
          @id int,
           @barrower_id int,
           @book_id int,
		   @barrowed_Date_time datetime
           
    AS
begin

	insert into spInsertBarrowedBook(id,barrower_id,book_id ,barrowed_Date_time,LastUpdated)
          values(@id,@barrower_id,@book_id ,@barrowed_Date_time,getdate())
end
