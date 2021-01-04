CREATE TABLE [dbo].[student] (
    [student_Id]          INT           NOT NULL,
    [student_name]        VARCHAR (50)  NOT NULL,
    [student_LIB_ID]      INT           NULL,
    [student_adress]      VARCHAR (500) NOT NULL,
    [student_father_name] VARCHAR (50)  NULL,
    [class_id]            INT           NULL,
    CONSTRAINT [student_id_PK] PRIMARY KEY CLUSTERED ([student_Id] ASC),
    UNIQUE NONCLUSTERED ([student_LIB_ID] ASC),
    UNIQUE NONCLUSTERED ([student_LIB_ID] ASC),
    CONSTRAINT [UC] UNIQUE NONCLUSTERED ([student_LIB_ID] ASC)
);

