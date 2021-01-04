CREATE TABLE [dbo].[employee] (
    [empd_id]        INT          NULL,
    [emp_name]       VARCHAR (50) NULL,
    [emp_Manager_id] INT          NULL
);


GO
CREATE trigger tgr_emp_delete on employee
for delete, update , insert
as insert into employee2 (empd_id,emp_name,emp_Manager_id,Last_updated)
select empd_id,emp_name,emp_Manager_id, getdate()
from deleted 
insert into employee2(empd_id,emp_name,emp_Manager_id,Last_updated)
select empd_id,emp_name,emp_Manager_id, getdate()
from inserted