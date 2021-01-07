CREATE TABLE [dbo].[Tbl_Barrower] (
    [Id]                        INT          IDENTITY (1, 1) NOT NULL,
    [Title]                     VARCHAR (3)  NOT NULL,
    [First_Name]                VARCHAR (30) NOT NULL,
    [Last_Name]                 VARCHAR (30) NOT NULL,
    [AddressLine1]              VARCHAR (30) NOT NULL,
    [AddressLine2]              VARCHAR (30) NULL,
    [City]                      VARCHAR (30) NOT NULL,
    [StateName]                 VARCHAR (30) NOT NULL,
    [Country]                   VARCHAR (30) NOT NULL,
    [PostCode]                  VARCHAR (10) NOT NULL,
    [Mobile_Number_CountryCode] VARCHAR (5)  NOT NULL,
    [Mobile_Number]             VARCHAR (10) NOT NULL,
    [Email_Id]                  VARCHAR (20) NOT NULL,
    [Barrower_Type]             VARCHAR (20) NOT NULL,
    [LastUpdated]               DATE         NULL,
    CONSTRAINT [Id_PK] PRIMARY KEY CLUSTERED ([Id] ASC)
);

