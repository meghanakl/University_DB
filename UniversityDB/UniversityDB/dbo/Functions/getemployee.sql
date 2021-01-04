CREATE function getemployee(@empd_id int)
returns table 
as
return
select *
from employee 
where empd_id = @empd_id