

SET QUOTED_IDENTIFIER OFF;
GO
USE [MyStore];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

IF OBJECT_ID(N'[dbo].[FK__Order__CustomerI__5441852A]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK__Order__CustomerI__5441852A];
GO
IF OBJECT_ID(N'[dbo].[FK__OrderDeta__Order__5812160E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__Order__5812160E];
GO
IF OBJECT_ID(N'[dbo].[FK__OrderDeta__Produ__571DF1D5]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__Produ__571DF1D5];
GO
IF OBJECT_ID(N'[dbo].[FK_Pro_Category]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Category];
GO
IF OBJECT_ID(N'[dbo].[FK_User_Customer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_User_Customer];
GO

IF OBJECT_ID(N'[dbo].[Category]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Category];
GO
IF OBJECT_ID(N'[dbo].[Customer]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customer];
GO
IF OBJECT_ID(N'[dbo].[Order]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Order];
GO
IF OBJECT_ID(N'[dbo].[OrderDetail]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderDetail];
GO
IF OBJECT_ID(N'[dbo].[Product]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[User]', 'U') IS NOT NULL
    DROP TABLE [dbo].[User];
GO

CREATE TABLE [dbo].[Categories] (
    [CategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] nvarchar(max)  NOT NULL
);
GO

CREATE TABLE [dbo].[Customers] (
    [CustomerID] int IDENTITY(1,1) NOT NULL,
    [CustomerName] nvarchar(max)  NOT NULL,
    [CustomerPhone] nvarchar(15)  NOT NULL,
    [CustomerEmail] nvarchar(max)  NULL,
    [CustomerAddress] nvarchar(max)  NULL,
    [Username] nvarchar(255)  NOT NULL
);
GO

CREATE TABLE [dbo].[Orders] (
    [OrderID] int IDENTITY(1,1) NOT NULL,
    [CustomerID] int  NOT NULL,
    [OrderDate] datetime  NOT NULL,
    [TotalAmount] decimal(18,2)  NOT NULL,
    [PaymentStatus] nvarchar(max)  NULL,
    [AddressDelivery] nvarchar(max)  NOT NULL
);
GO

CREATE TABLE [dbo].[OrderDetails] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [ProductID] int  NOT NULL,
    [OrderID] int  NOT NULL,
    [Quantity] int  NOT NULL,
    [UnitPrice] decimal(18,2)  NOT NULL
);
GO

CREATE TABLE [dbo].[Products] (
    [ProductID] int IDENTITY(1,1) NOT NULL,
    [CategoryID] int  NOT NULL,
    [ProductName] nvarchar(max)  NOT NULL,
    [ProductDescription] nvarchar(max)  NOT NULL,
    [ProductPrice] decimal(18,2)  NOT NULL,
    [ProductImage] nvarchar(max)  NULL
);
GO

CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

CREATE TABLE [dbo].[Users] (
    [Username] nvarchar(255)  NOT NULL,
    [Password] nchar(50)  NOT NULL,
    [UserRole] nchar(1)  NOT NULL
);
GO

ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([CategoryID] ASC);
GO

ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([CustomerID] ASC);
GO

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([OrderID] ASC);
GO

ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [PK_OrderDetails]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([ProductID] ASC);
GO

ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Username] ASC);
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Pro_Category]
    FOREIGN KEY ([CategoryID])
    REFERENCES [dbo].[Categories]
        ([CategoryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

CREATE INDEX [IX_FK_Pro_Category]
ON [dbo].[Products]
    ([CategoryID]);
GO

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK__Order__CustomerI__5441852A]
    FOREIGN KEY ([CustomerID])
    REFERENCES [dbo].[Customers]
        ([CustomerID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

CREATE INDEX [IX_FK__Order__CustomerI__5441852A]
ON [dbo].[Orders]
    ([CustomerID]);
GO

ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [FK_User_Customer]
    FOREIGN KEY ([Username])
    REFERENCES [dbo].[Users]
        ([Username])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

CREATE INDEX [IX_FK_User_Customer]
ON [dbo].[Customers]
    ([Username]);
GO

ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [FK__OrderDeta__Order__5812160E]
    FOREIGN KEY ([OrderID])
    REFERENCES [dbo].[Orders]
        ([OrderID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

CREATE INDEX [IX_FK__OrderDeta__Order__5812160E]
ON [dbo].[OrderDetails]
    ([OrderID]);
GO

ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [FK__OrderDeta__Produ__571DF1D5]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ProductID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

CREATE INDEX [IX_FK__OrderDeta__Produ__571DF1D5]
ON [dbo].[OrderDetails]
    ([ProductID]);
GO

-- --------------------------------------------------