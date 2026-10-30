/* WARNING: This setup script DROPS the existing MyStore database and recreates it. */
USE master;
GO

IF DB_ID(N'MyStore') IS NOT NULL
BEGIN
    ALTER DATABASE [MyStore] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [MyStore];
END;
GO

CREATE DATABASE [MyStore];
GO
USE [MyStore];
GO

CREATE TABLE dbo.Users
(
    Username nvarchar(255) NOT NULL CONSTRAINT PK_Users PRIMARY KEY,
    [Password] nchar(50) NOT NULL,
    UserRole nchar(1) NOT NULL
);
GO

CREATE TABLE dbo.Customers
(
    CustomerID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Customers PRIMARY KEY,
    CustomerName nvarchar(255) NOT NULL,
    CustomerPhone nvarchar(15) NOT NULL,
    CustomerEmail nvarchar(255) NULL,
    CustomerAddress nvarchar(500) NULL,
    Username nvarchar(255) NOT NULL,
    CONSTRAINT FK_Customers_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username)
);
GO

CREATE TABLE dbo.Categories
(
    CategoryID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Categories PRIMARY KEY,
    CategoryName nvarchar(255) NOT NULL
);
GO

CREATE TABLE dbo.Products
(
    ProductID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Products PRIMARY KEY,
    CategoryID int NOT NULL,
    ProductName nvarchar(255) NOT NULL,
    ProductDescription nvarchar(max) NOT NULL,
    ProductPrice decimal(18,2) NOT NULL,
    ProductImage nvarchar(500) NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES dbo.Categories(CategoryID)
);
GO

CREATE TABLE dbo.Orders
(
    OrderID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Orders PRIMARY KEY,
    CustomerID int NOT NULL,
    OrderDate datetime NOT NULL,
    TotalAmount decimal(18,2) NOT NULL,
    PaymentStatus nvarchar(100) NULL,
    AddressDelivery nvarchar(500) NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);
GO

CREATE TABLE dbo.OrderDetails
(
    ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrderDetails PRIMARY KEY,
    ProductID int NOT NULL,
    OrderID int NOT NULL,
    Quantity int NOT NULL,
    UnitPrice decimal(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES dbo.Orders(OrderID)
);
GO

INSERT INTO dbo.Users (Username, [Password], UserRole)
VALUES (N'admin', N'123', N'A'), (N'khach1', N'123', N'C');
GO

INSERT INTO dbo.Customers (CustomerName, CustomerPhone, CustomerEmail, CustomerAddress, Username)
VALUES (N'Nguyễn Văn A', N'0901234567', N'khach1@example.com', N'Quận 1, TP.HCM', N'khach1');
GO

INSERT INTO dbo.Categories (CategoryName)
VALUES (N'Văn học'), (N'Kinh tế'), (N'Kỹ năng sống');
GO

INSERT INTO dbo.Products (CategoryID, ProductName, ProductDescription, ProductPrice, ProductImage)
VALUES
(1, N'Đồi Gió Hú', N'Tiểu thuyết kinh điển của Emily Brontë.', 102600, N'~/Content/images/default_img.png'),
(1, N'Cây Cam Ngọt Của Tôi', N'Câu chuyện cảm động về tuổi thơ.', 70200, N'~/Content/images/default_img.png'),
(1, N'Cuộc Phiêu Lưu Của Thuyền Trưởng Corcoran', N'Truyện phiêu lưu hấp dẫn.', 29600, N'~/Content/images/default_img.png'),
(1, N'Nhà Giả Kim', N'Hành trình đi tìm vận mệnh của chàng chăn cừu.', 65000, N'~/Content/images/default_img.png'),
(2, N'Kinh Doanh Thời Trang', N'8 bước xây dựng, vận hành và phát triển shop quần áo.', 142000, N'~/Content/images/default_img.png'),
(2, N'Khởi Nghiệp Bán Lẻ', N'Bí quyết thành công và giàu có bằng những cửa hàng đông khách.', 120000, N'~/Content/images/default_img.png'),
(2, N'Đọc Vị Bất Kỳ Ai', N'Để không bị lợi dụng.', 66800, N'~/Content/images/default_img.png'),
(2, N'Quản Trị Doanh Nghiệp Nhỏ', N'Những nguyên tắc căn bản để vận hành doanh nghiệp.', 98000, N'~/Content/images/default_img.png'),
(3, N'Nghệ Thuật Từ Chối', N'Cách nói không mà vẫn có được đồng thuận.', 55900, N'~/Content/images/default_img.png'),
(3, N'Nói Chuyện Là Bản Năng, Giữ Miệng Là Tu Dưỡng', N'Im lặng là trí tuệ.', 109620, N'~/Content/images/default_img.png'),
(3, N'Tư Duy Bằng Con Số', N'Cuộc sống rực rỡ qua lăng kính toán học.', 119000, N'~/Content/images/default_img.png'),
(3, N'Đắc Nhân Tâm', N'Nghệ thuật đối nhân xử thế.', 86000, N'~/Content/images/default_img.png');
GO

INSERT INTO dbo.Orders (CustomerID, OrderDate, TotalAmount, PaymentStatus, AddressDelivery)
VALUES (1, GETDATE(), 0, N'Đã thanh toán', N'Quận 1, TP.HCM');
GO

INSERT INTO dbo.OrderDetails (ProductID, OrderID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 102600),
(1, 1, 2, 102600),
(5, 1, 1, 142000),
(5, 1, 1, 142000),
(5, 1, 3, 142000),
(2, 1, 1, 70200),
(9, 1, 1, 55900),
(6, 1, 2, 120000);
GO

UPDATE dbo.Orders
SET TotalAmount = (
    SELECT SUM(Quantity * UnitPrice)
    FROM dbo.OrderDetails
    WHERE OrderID = 1
)
WHERE OrderID = 1;
GO

SELECT N'Database MyStore created successfully.' AS Result;
GO
