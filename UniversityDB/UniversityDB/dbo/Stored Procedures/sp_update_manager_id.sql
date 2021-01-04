create procedure sp_update_manager_id 
(@empd_id int , 
@emp_manager_id int )
as 
begin
update employee 
 set emp_manager_id=@emp_manager_id
 where empd_id=@empd_id
end