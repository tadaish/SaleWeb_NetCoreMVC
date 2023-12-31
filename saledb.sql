USE [master]
GO
/****** Object:  Database [saledb]    Script Date: 9/14/2023 12:33:07 PM ******/
CREATE DATABASE [saledb] ON  PRIMARY 
( NAME = N'saledb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\saledb.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'saledb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\saledb_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [saledb] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [saledb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [saledb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [saledb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [saledb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [saledb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [saledb] SET ARITHABORT OFF 
GO
ALTER DATABASE [saledb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [saledb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [saledb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [saledb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [saledb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [saledb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [saledb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [saledb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [saledb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [saledb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [saledb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [saledb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [saledb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [saledb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [saledb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [saledb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [saledb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [saledb] SET RECOVERY FULL 
GO
ALTER DATABASE [saledb] SET  MULTI_USER 
GO
ALTER DATABASE [saledb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [saledb] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'saledb', N'ON'
GO
USE [saledb]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 9/14/2023 12:33:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colors]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colors](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[ColorName] [nvarchar](20) NULL,
 CONSTRAINT [PK_Colors] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Price] [money] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Order Details] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[ShippingAddress] [nvarchar](50) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[BrandID] [int] NULL,
	[SizeID] [int] NULL,
	[ProductName] [nvarchar](100) NULL,
	[Quantity] [int] NULL,
	[Price] [money] NULL,
	[UnitsInStock] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Limited] [bit] NULL,
	[Images] [varchar](max) NULL,
	[ColorID] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[SizeID] [int] IDENTITY(1,1) NOT NULL,
	[SizeOption] [varchar](10) NULL,
 CONSTRAINT [PK_Size] PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/14/2023 12:33:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NULL,
	[Password] [nvarchar](20) NULL,
	[FullName] [nvarchar](50) NULL,
	[Phone] [nvarchar](15) NULL,
	[Address] [nvarchar](50) NULL,
	[Role] [varchar](10) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 

INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (1, N'Nón Sơn')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (2, N'Coolmate')
SET IDENTITY_INSERT [dbo].[Brands] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Snapback')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Jacket')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (3, N'Lưỡi trai')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (4, N'Bucket')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (5, N'Vành')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (6, N'Phớt')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Colors] ON 

INSERT [dbo].[Colors] ([ColorID], [ColorName]) VALUES (1, N'Đỏ')
INSERT [dbo].[Colors] ([ColorID], [ColorName]) VALUES (2, N'Xanh dậm')
INSERT [dbo].[Colors] ([ColorID], [ColorName]) VALUES (3, N'Đen')
INSERT [dbo].[Colors] ([ColorID], [ColorName]) VALUES (4, N'Trắng')
INSERT [dbo].[Colors] ([ColorID], [ColorName]) VALUES (5, N'Xanh lá')
SET IDENTITY_INSERT [dbo].[Colors] OFF
GO
SET IDENTITY_INSERT [dbo].[Order Details] ON 

INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (1, 36, 6, 130.0000, 2)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (2, 38, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (3, 48, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (4, 57, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (5, 57, 7, 100.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (6, 57, 8, 140.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (7, 58, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (8, 58, 8, 140.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (9, 58, 7, 100.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (10, 59, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (11, 59, 9, 100.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (12, 59, 8, 140.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (13, 60, 9, 100.0000, 2)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (14, 60, 8, 140.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (15, 61, 8, 140.0000, 2)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (16, 61, 20, 1500.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (17, 62, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (18, 62, 20, 1500.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (19, 62, 7, 100.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (20, 62, 19, 1500.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (21, 64, 6, 130.0000, 1)
INSERT [dbo].[Order Details] ([id], [OrderID], [ProductID], [Price], [Quantity]) VALUES (22, 65, 6, 130.0000, 1)
SET IDENTITY_INSERT [dbo].[Order Details] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (27, NULL, CAST(N'2023-09-12T16:18:33.593' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (32, NULL, CAST(N'2023-09-12T16:33:57.573' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (35, NULL, CAST(N'2023-09-12T16:40:01.357' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (36, NULL, CAST(N'2023-09-12T16:40:10.133' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (38, NULL, CAST(N'2023-09-12T16:47:10.613' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (40, NULL, CAST(N'2023-09-12T16:47:41.663' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (42, NULL, CAST(N'2023-09-12T16:49:28.780' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (44, NULL, CAST(N'2023-09-12T16:58:11.567' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (46, NULL, CAST(N'2023-09-12T17:00:27.063' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (48, NULL, CAST(N'2023-09-12T17:08:02.913' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (50, NULL, CAST(N'2023-09-12T17:13:02.493' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (54, NULL, CAST(N'2023-09-12T17:29:32.870' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (56, NULL, CAST(N'2023-09-12T17:54:04.113' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (57, NULL, CAST(N'2023-09-12T17:55:41.867' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (58, NULL, CAST(N'2023-09-12T17:55:58.917' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (59, NULL, CAST(N'2023-09-12T17:56:15.140' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (60, NULL, CAST(N'2023-09-12T18:11:14.650' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (61, NULL, CAST(N'2023-09-13T22:00:40.853' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (62, NULL, CAST(N'2023-09-13T23:58:29.590' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (63, NULL, CAST(N'2023-09-14T00:01:00.593' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (64, NULL, CAST(N'2023-09-14T00:01:09.270' AS DateTime), NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [ShippingAddress]) VALUES (65, NULL, CAST(N'2023-09-14T00:01:53.303' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (6, 3, 2, 2, N'Tech Cap', 10, 130.0000, 3, N'Thể thao', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694585681/vdzfiedtrmuaou8i6wfp.jpg', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (7, 1, 1, 3, N'Hip hop', 20, 100.0000, 10, N'Hip hop', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694586279/trgotizp98r5ttfqnvr3.jpg', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (8, 3, 2, 3, N'Simple Cool V2', 100, 140.0000, 50, N'Thiết kế mũ cơ bản', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694586462/xn7nlyllaojpbipz6kwp.jpg', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (9, 3, 2, 3, N'Baseball Cap', 50, 100.0000, 40, N'thoáng khí phối lưới ', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694587198/idoxnjq46wbplx8w9pwv.jpg', 4)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (16, 3, 2, 2, N'Classic Cap', 25, 140.0000, 10, N'Thiết kế kiểu dáng thể thao', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694590906/kipepvfotanp8syukhgp.jpg', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (17, 3, 2, 2, N'Kaki Care & Share', 10, 190.0000, 5, N'100% Cotton vải Kaki Hàn Quốc', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694591292/rtokpyey35jbwc4arbyp.png', 4)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (18, 3, 2, 3, N'Dadcap Jeans Copper Denim ', 15, 200.0000, 9, N'Là sản phẩm kết hợp giữa Coolmate và Copper Denim', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694593336/dgjopv6ldgb6g3s8cruw.jpg', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (19, 3, 1, 2, N'Nón Kết MC226A-DO1', 10, 1500.0000, 5, N'Chất liệu dù phối da thật cao cấp', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694597825/brkdjkuxj7l0u8uqwbqq.png', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [BrandID], [SizeID], [ProductName], [Quantity], [Price], [UnitsInStock], [Description], [Limited], [Images], [ColorID]) VALUES (20, 2, 1, 1, N'Nón Jacket MC257-DO1', 10, 1500.0000, 5, N'Vải da phối da bò', NULL, N'https://res.cloudinary.com/dbkmrrnge/image/upload/v1694597900/j2vsvxv39ojf40gdhftg.png', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([SizeID], [SizeOption]) VALUES (1, N'M')
INSERT [dbo].[Size] ([SizeID], [SizeOption]) VALUES (2, N'X')
INSERT [dbo].[Size] ([SizeID], [SizeOption]) VALUES (3, N'XX')
INSERT [dbo].[Size] ([SizeID], [SizeOption]) VALUES (4, N'XXL')
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [FullName], [Phone], [Address], [Role]) VALUES (1, N'tester', N'tester', N'tester', N'0912030901', N'Hai ba trưng', N'User')
INSERT [dbo].[Users] ([UserID], [Username], [Password], [FullName], [Phone], [Address], [Role]) VALUES (2, N'Admin', N'123', NULL, NULL, NULL, N'Admin')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [FK_Order Details_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order Details_Orders]
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [FK_Order Details_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order Details_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Brands]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Colors] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Colors] ([ColorID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Colors]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Size] FOREIGN KEY([SizeID])
REFERENCES [dbo].[Size] ([SizeID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Size]
GO
USE [master]
GO
ALTER DATABASE [saledb] SET  READ_WRITE 
GO
