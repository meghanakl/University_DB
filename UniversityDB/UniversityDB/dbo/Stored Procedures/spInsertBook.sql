


CREATE procedure [dbo].[spInsertBook]
         @title varchar(30),
          @author varchar(30),
           @price decimal(10,2),
           @published_date date,
           @purchased_date date,
           @quantity decimal(5,2)
    as
begin
	if not exists( Select * from Tbl_Book where (title=@title) and (author=@author))
	insert into Tbl_Book(title,author,price,published_date,purchased_date,quantity,LastUpdated)values(@title,@author,@price,@published_date,@purchased_date,@quantity,getdate())
end
   
