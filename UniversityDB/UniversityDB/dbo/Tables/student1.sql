CREATE TABLE [dbo].[student1] (
    [std_id]          INT           NOT NULL,
    [std_LIB_id]      VARCHAR (100) NOT NULL,
    [std_addres]      VARCHAR (500) NOT NULL,
    [std_father_name] VARCHAR (70)  NOT NULL,
    [class_id]        INT           NULL,
    CONSTRAINT [student1_class_id_FK] FOREIGN KEY ([class_id]) REFERENCES [dbo].[class] ([cls_id]),
    CONSTRAINT [student1_FK] FOREIGN KEY ([class_id]) REFERENCES [dbo].[class] ([cls_id])
);

