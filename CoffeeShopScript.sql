USE [master]
GO
/****** Object:  Database [CoffeeShop]    Script Date: 5/7/2019 9:05:34 AM ******/

/********THIS STATEMENT CREATES THE DATABASE*********/



CREATE DATABASE [CoffeeShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineRetailApp', FILENAME = N'C:\Database\OnlineRetailApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineRetailApp_log', FILENAME = N'C:\Database\OnlineRetailApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CoffeeShop] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CoffeeShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CoffeeShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CoffeeShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CoffeeShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CoffeeShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CoffeeShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CoffeeShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CoffeeShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CoffeeShop] SET  MULTI_USER 
GO
ALTER DATABASE [CoffeeShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CoffeeShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CoffeeShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CoffeeShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CoffeeShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CoffeeShop] SET QUERY_STORE = OFF
GO
USE [CoffeeShop]
GO



/**********PLease ignore this Functions**************/


/****** Object:  UserDefinedFunction [dbo].[DiscountedPrice]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DiscountedPrice](
    @Quantity INT,
    @ItemPrice money,
    @DiscountAmount money
)
RETURNS money

AS 
BEGIN
    RETURN (@Quantity * @ItemPrice) - @DiscountAmount;
END;
GO

/***********Please ignore this Function**********/



/****** Object:  UserDefinedFunction [dbo].[fnVendorID]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnVendorID]
    (@VendorName varchar(50))
    RETURNS int
BEGIN
    RETURN (SELECT VendorID FROM Vendors WHERE VendorName = @VendorName);
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetDiscountedPrice]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetDiscountedPrice]
          (@Quantity INT,
          @ItemPrice money,
          @DiscountAmount money)
          RETURNS money



BEGIN
     RETURN (@Quantity * @ItemPrice) - @DiscountAmount;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductDiscount]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/******TTHIS STATEMENT CREATES GETPRODUCTDISCOUNT USER DEFINED FUNCTION******/



CREATE FUNCTION [dbo].[GetProductDiscount]
          (@ItemPrice money,
           @DiscountAmount float)
           RETURNS money


BEGIN
     RETURN  (@ItemPrice-(@ItemPrice * @DiscountAmount));
END;
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS STATEMENT CREATES THE ADDRESS TABLE************/


CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL, --THE PRIMARY KEY OF THE ADDRESS TABLE
	[Address] [varchar](100) NOT NULL,
	[State] [char](2) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED --THE PRIMRY KEY IS A CLUSTERED INDEX
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AddressLIst]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/********** A VIEW OF THE ADDRESS TABLE***********/


CREATE VIEW [dbo].[AddressLIst]
AS 
SELECT Address, City,State, ZipCode 
FROM Addresses
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS STATEMENT CREATES THE CUSTOMER TABLE************/


CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,--THE PRIMARY KEY OF THE CUSTOMER TABLE
	[AddressID] [int] NULL,--THE FOREIGN KEY OF THE CUSTOMER TABLE
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED --THE PRIMARY KEY IS A CLUSTERED INDEX
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerList]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/********** A VIEW OF THE CUSTOMER TABLE AND JOINED WITH THE ADDRESS TABLE  ************/

CREATE VIEW [dbo].[CustomerList]
AS
select CustomerID,Customers.AddressID,FirstName,LastName,Addresses.Address,Addresses.State,Addresses.City,Addresses.ZipCode
 from Customers inner join Addresses on Customers.AddressID= Addresses.AddressID
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS STATEMENT CREATES THE ORDERITEMS TABLE************/



CREATE TABLE [dbo].[OrderItems](
	[ItemID] [int] IDENTITY(1,1) NOT NULL, --THE PRIMARY KEY OF THE ORDERITEMS TABLE
	[OrderID] [int] NOT NULL,--THE FOREIGN KEY OF THE ORDERITEMS TABLE
	[ProductID] [int] NOT NULL,--THE FOREIGN KEY OF THE ORDERITEMS TABLE
	[ItemPrice] [money] NULL,
	[DiscountAmount] [float] NULL,
	[Quantity] [int] NOT NULL,
	[TaxAmount] [money] NULL,
 CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED --THE PRIMARY KEY IS A CLUSTERED INDEX
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS STATEMENT CREATES THE ORDER TABLE************/


CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,--THE PRIMARY KEY OF THE ORDER TABLE
	[CustomerID] [int] NOT NULL, --THE FOREIGN KEY OF THE ORDER TABLE
	[OrderDate] [smalldatetime] NOT NULL,
	[CardType] [varchar](50) NOT NULL,
	[CardNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED --THE PRIMARY KEY IS A CLUSTERED INDEX
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderList]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS IS VIEW OF THE ORDER TABLE AND JOINED WITH THE CUSTOMER TABLE************/



CREATE VIEW [dbo].[OrderList]
AS 
SELECT orders.OrderID,Orders.CustomerID,orders.OrderDate,OrderItems.ItemID,OrderItems.ProductID,ItemPrice,DiscountAmount,Quantity
from orders inner join OrderItems on Orders.OrderID=OrderItems.OrderID

GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********THIS STATEMENT CREATES THE PRODUCTS TABLE************/



CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL, --THE PRIMARY KEY OF THE PRODUCTS TABLE
	[ProductName] [varchar](50) NOT NULL,
	[ProductDescription] [varchar](200) NULL,
	[DateAdded] [smalldatetime] NULL,
	[Stock] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED --THE PRIMARY KEY IS A CLUSTERED INDEX 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductLIst]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**********A VIEW OF THE THE PRODUCTS TABLE************/
CREATE View [dbo].[ProductLIst] 
AS 
SELECT ProductName, ProductDescription 
FROM Products
GO
/****** Object:  View [dbo].[OrderItemList]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/********** A VUEW OF THE ORDERITEM TABLE************/

CREATE VIEW [dbo].[OrderItemList]
as

SELECT ItemID, OrderID
FROM OrderItems;

GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([AddressID], [Address], [State], [City], [ZipCode]) VALUES (101, N'34 Greenroad Ave', N'TX', N'Redwood', N'05678')
INSERT [dbo].[Addresses] ([AddressID], [Address], [State], [City], [ZipCode]) VALUES (102, N'45 Broadway Ave', N'NJ', N'Clark', N'74532')
INSERT [dbo].[Addresses] ([AddressID], [Address], [State], [City], [ZipCode]) VALUES (103, N'1000 James Street', N'NC', N'Harrisville', N'54321')
INSERT [dbo].[Addresses] ([AddressID], [Address], [State], [City], [ZipCode]) VALUES (104, N'67 Bricks Street', N'VA', N'South Park', N'56739')
INSERT [dbo].[Addresses] ([AddressID], [Address], [State], [City], [ZipCode]) VALUES (105, N'97 North Gibbs', N'CA', N'Caton', N'34567')
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [AddressID], [FirstName], [LastName], [Phone]) VALUES (301, 101, N'James', N'McWade', N'345-444-2186')
INSERT [dbo].[Customers] ([CustomerID], [AddressID], [FirstName], [LastName], [Phone]) VALUES (302, 102, N'Jennifer', N'Williams', N' 708-456-4567')
INSERT [dbo].[Customers] ([CustomerID], [AddressID], [FirstName], [LastName], [Phone]) VALUES (303, 103, N'Sara', N'Greene', N'667-344-0001')
INSERT [dbo].[Customers] ([CustomerID], [AddressID], [FirstName], [LastName], [Phone]) VALUES (304, 104, N'Lisa', N'Jackson', N'814-939-2662')
INSERT [dbo].[Customers] ([CustomerID], [AddressID], [FirstName], [LastName], [Phone]) VALUES (305, 105, N'Shawn', N'Robbins', N' 973-777-7788')
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (1, 751, 432, 1.0500, 0.1, 5, 0.3750)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (2, 752, 434, 4.7500, 0.1, 2, 0.3750)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (3, 752, 433, 1.5000, 0.1, 2, 0.5490)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (4, 751, 437, 1.1000, 0.1, 5, 0.3750)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (5, 752, 435, 1.2500, 0.1, 2, 0.5490)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (6, 753, 433, 1.5000, 0.2, 20, 0.3150)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (7, 753, 437, 1.1000, 0.2, 40, 0.3150)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [ItemPrice], [DiscountAmount], [Quantity], [TaxAmount]) VALUES (8, 753, 436, 1.7500, 0.2, 40, 0.3150)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [CardType], [CardNumber]) VALUES (751, 301, CAST(N'2019-04-05T00:00:00' AS SmallDateTime), N'Visa', N'4567-3345-4565-4566')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [CardType], [CardNumber]) VALUES (752, 302, CAST(N'2019-04-06T00:00:00' AS SmallDateTime), N'Master', N'6756-2345-4675-6788')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [CardType], [CardNumber]) VALUES (753, 303, CAST(N'2019-04-11T00:00:00' AS SmallDateTime), N'Visa', N'0773-2345-4005-3902')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [CardType], [CardNumber]) VALUES (754, 304, CAST(N'2019-04-12T00:00:00' AS SmallDateTime), N'Visa', N' 6443-9213-4448-3211')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [CardType], [CardNumber]) VALUES (755, 305, CAST(N'2019-04-23T00:00:00' AS SmallDateTime), N'American Express', N'3775-5455-3002-1004')
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (432, N'Small Coffee', N'6oz hot coffee', CAST(N'2019-01-22T00:00:00' AS SmallDateTime), 300)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (433, N'Medium Coffee', N'8 oz hot coffee', CAST(N'2019-01-25T00:00:00' AS SmallDateTime), 500)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (434, N'Carrot Cake', N'Rich Cream Cheese frosting carrot based cake batter', CAST(N'2019-01-25T00:00:00' AS SmallDateTime), 80)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (435, N'Plain Bagel', N'', CAST(N'2019-01-22T00:00:00' AS SmallDateTime), 100)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (436, N'Bacon', N'4 strips of bacon', CAST(N'2019-01-22T00:00:00' AS SmallDateTime), 100)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [DateAdded], [Stock]) VALUES (437, N'Scramble Eggs', N'', CAST(N'2019-01-25T00:00:00' AS SmallDateTime), 150)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Addresses] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Addresses]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
/****** Object:  StoredProcedure [dbo].[spCopyCustomers]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**********A STOREED PROCEDURE   ************/

--THIS CREATES A COPY OF THE CUSTOMER TABLE

/********** PLEASE IGNORE THIS IT DOES NOT ADD  MUCH VALUE TO MY PROJECT. I WILL NOT BE GOING OVER IT ************/
  CREATE PROC [dbo].[spCopyCustomers] 
  AS
     IF OBJECT_id('CustoemrCopy') IS NOT NULL 
	      DROP TABLE CustoemrCopy;
		  SELECT *  iNTO CustoemrCopy FROM customers 
GO
/****** Object:  StoredProcedure [dbo].[totalamount]    Script Date: 5/7/2019 9:05:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[totalamount]
  as
  begin
  select orderid,itemprice * Quantity as totalamount from orderitems
  end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 178
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerList'
GO
USE [master]
GO
ALTER DATABASE [CoffeeShop] SET  READ_WRITE 
GO
