CREATE TABLE [dbo].[Tbl_Barrowed_Book] (
	[ID] INT NOT NULL
	,[Barrower_id] INT NOT NULL
	,[Book_id] INT NOT NULL
	,[Barrowed_Date_Time] DATETIME NOT NULL
	,[Return_date] DATETIME NULL
	,[LastUpdated] DATETIME NULL
	,CONSTRAINT [pK_Barrowed_Book] PRIMARY KEY CLUSTERED ([Book_id] ASC)
	,CONSTRAINT [FK_Tbl_Barrower_Tbl_Barrowed_Book] FOREIGN KEY ([Barrower_id]) REFERENCES [dbo].[Tbl_Barrower]([Id])
	,CONSTRAINT [FK_Tbl_Book_Tbl_Barrowed_Book] FOREIGN KEY ([ID]) REFERENCES [dbo].[Tbl_Barrower]([Id])
	);
