create view vw_teacher_class
as select *
from teacher t left join class c on c.class_id= t.teacher_id 
