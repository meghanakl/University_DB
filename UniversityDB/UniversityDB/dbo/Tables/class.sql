CREATE TABLE [dbo].[class] (
    [cls_id]           INT           NOT NULL,
    [No_of_Students]   VARCHAR (100) NOT NULL,
    [class_teacher_id] INT           NULL,
    [class_id]         INT           NULL,
    CONSTRAINT [class_PK] PRIMARY KEY CLUSTERED ([cls_id] ASC)
);

