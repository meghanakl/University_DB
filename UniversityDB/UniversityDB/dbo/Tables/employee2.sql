CREATE TABLE [dbo].[employee2] (
    [empd_id]        INT          NULL,
    [emp_name]       VARCHAR (50) NULL,
    [emp_Manager_id] INT          NULL,
    [Last_updated]   DATETIME     NULL
);


GO
create trigger tgr_emp_del on employee2
for delete as
insert into employee2(empd_id,emp_name,emp_Manager_id,Last_updated)
select empd_id,emp_name,emp_Manager_id, getdate()
from deleted