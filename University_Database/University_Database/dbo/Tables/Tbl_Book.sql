CREATE TABLE [dbo].[Tbl_Book] (
    [Title]          VARCHAR (30)    NOT NULL,
    [Author]         VARCHAR (30)    NOT NULL,
    [price]          DECIMAL (10, 2) NOT NULL,
    [Published_Date] DATE            NOT NULL,
    [Purchased_Date] DATE            NOT NULL,
    [Quantity]       DECIMAL (5, 2)  NOT NULL,
    [LastUpdated]    DATE            NULL,
    [ID]             INT             IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

