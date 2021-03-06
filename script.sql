USE [Flowers]
GO
/****** Object:  StoredProcedure [dbo].[Cancel_Order]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cancel_Order]

@InvoiceID int

as

DECLARE @AddressTable TABLE (DeliveryAddress int)
DECLARE @AddressID int

DELETE InvoiceDetails
OUTPUT deleted.DeliveryAddress INTO @AddressTable
WHERE InvoiceID = @InvoiceID

SELECT @AddressID = DeliveryAddress from @AddressTable

DELETE Addresses
WHERE AddressID = @AddressID

DELETE Invoices
WHERE InvoiceID = @InvoiceID


GO
/****** Object:  StoredProcedure [dbo].[Confirm_Order]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Confirm_Order]

@OrderNumber int,
@NumberOfItems int,
@TotalPrice nvarchar(50),
@ContactName nvarchar(100)

as
INSERT INTO OrderSummary(InvoiceID,NumberOfItems,TotalPrice,[ShipToName])
VALUES (@OrderNumber,@NumberOfItems,@TotalPrice,@ContactName)
GO
/****** Object:  StoredProcedure [dbo].[Delete_Row]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[Delete_Row]

 @InvoiceNumber int,
 @ItemNumber int

 as

 DELETE FROM InvoiceDetails WHERE InvoiceID = @InvoiceNumber AND ItemNumber = @ItemNumber

 UPDATE InvoiceDetails
 Set ItemNumber = ItemNumber - 1
Where ItemNumber > @ItemNumber AND InvoiceID = @InvoiceNumber
GO
/****** Object:  StoredProcedure [dbo].[Generate_Invoice]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Generate_Invoice]
@ID int,
@ItemNumber int,
@Flower int,
@ContactName nvarchar(100),
@Street nvarchar(50),
@Apt nvarchar(10) = null,
@City nvarchar(50),
@Region int,
@Country int,
@ZipCode nvarchar(15)

as

DECLARE @AddressID TABLE (AddressID int)
DECLARE @InvoiceID TABLE (InvoiceID int)
DECLARE @InvoiceDate date
DECLARE @AddressInvoice int
DECLARE @InvoiceDetailID int
DECLARE @TaxRate money

set @InvoiceDate = GETDATE()

Select @TaxRate = TaxRate from TaxCode where [status] = 1 AND TaxCodeID = @Country

BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Addresses(Street, apt, City, Region, Country, ZipCode, ContactPerson, Status)
		OUTPUT inserted.AddressID INTO @AddressID
		VALUES (@Street, @Apt, @City, @Region, @Country, @ZipCode,@ContactName, 0);

		INSERT INTO Invoices(UserID, Date, TaxCode,Processed)
		OUTPUT inserted.InvoiceID INTO @InvoiceID
		VALUES (@ID,@InvoiceDate , @TaxRate , 0)

		SELECT @AddressInvoice = AddressID FROM @AddressID
		SELECT @InvoiceDetailID = InvoiceID FROM @InvoiceID

		INSERT INTO InvoiceDetails (ItemNumber,Flower, Processed,DeliveryAddress,InvoiceID)
		VALUES (@ItemNumber, @Flower, 0, @AddressInvoice, @InvoiceDetailID)

		SELECT IDENT_CURRENT('Invoices');
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH



GO
/****** Object:  StoredProcedure [dbo].[Get_Country_Table]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Country_Table]
as
SELECT [CountryID]
      ,[DisplayValue]
  FROM [Flowers].[dbo].[Country]
GO
/****** Object:  StoredProcedure [dbo].[Get_Flowers_Table]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Flowers_Table]
as
SELECT [FlowerID]
      ,[RetialPrice]
      ,[Description]
      ,[Status]
  FROM [Flowers].[dbo].[Flowers]
  WHERE Status = 1
  ORDER BY Description
GO
/****** Object:  StoredProcedure [dbo].[Get_Locations_Table]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Locations_Table] 
as
SELECT [RegionID]
      ,[DisplayValue]
  FROM [Flowers].[dbo].[Regions]
  ORDER BY DisplayValue
GO
/****** Object:  StoredProcedure [dbo].[Get_Occasions_Table]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Occasions_Table]
as
SELECT [Seasonalid]
      ,[DisplayValue]
      ,[Status]
  FROM [Flowers].[dbo].[Seasonal]
  WHERE Status = 1
GO
/****** Object:  StoredProcedure [dbo].[Get_Order_Details]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Order_Details]

@IdentityNumber int

as

SELECT InvoiceDetails.ItemNumber as [Item Number], Flowers.Description as Flower,
Flowers.RetialPrice as Price, 
ROUND(Flowers.RetialPrice * Invoices.TaxCode,2) as Taxes, Flowers.RetialPrice + (ROUND(Flowers.RetialPrice * Invoices.TaxCode,2)) as Subtotal
  FROM [Flowers].[dbo].[InvoiceDetails], Flowers, Invoices
  WHERE Flower = flowers.FlowerID AND InvoiceDetails.InvoiceID = Invoices.InvoiceID AND Invoices.InvoiceID = @IdentityNumber
GO
/****** Object:  StoredProcedure [dbo].[Get_Orders]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Orders]

@UserID int

as

SELECT Invoices.InvoiceID,
Invoices.Date,
OrderSummary.NumberOfItems,
OrderSummary.TotalPrice,
OrderSummary.ShipToName

FROM

Invoices
INNER JOIN OrderSummary
ON Invoices.InvoiceID = OrderSummary.InvoiceID
WHERE Invoices.UserID = @userID
GO
/****** Object:  StoredProcedure [dbo].[Get_User_Info]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_User_Info]
@UserName nvarchar(50)
AS
SELECT
	 p.UserID
	,[LName]
    ,[FName]
    ,[UserName]
    ,[Pswd]
    ,[Phone]
    ,[Email]
	,c.SecretQuestion1
	,c.Answer1
	,c.SecretQuestion2
	,c.Answer2
  FROM dbo.Users p
  INNER JOIN dbo.PasswordRecovery c 
  ON c.UserID = p.UserID
  WHERE p.UserName = @UserName

GO
/****** Object:  StoredProcedure [dbo].[Insert_Item]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Item]


@Flower int,
@InvoiceID int

as

DECLARE @Address int
DECLARE @ItemNumber int

SELECT @Address = InvoiceDetails.DeliveryAddress
FROM InvoiceDetails
WHERE InvoiceDetails.InvoiceID = @InvoiceID

if @Address is null set @Address = IDENT_CURRENT('Addresses')

SELECT @ItemNumber = COUNT(InvoiceDetails.ItemNumber) + 1
FROM InvoiceDetails
WHERE InvoiceDetails.InvoiceID = @InvoiceID

INSERT INTO InvoiceDetails(ItemNumber, Flower, Processed, DeliveryAddress, InvoiceID)
VALUES (@ItemNumber, @Flower, 0, @Address, @InvoiceID);
GO
/****** Object:  StoredProcedure [dbo].[Insert_New_Profile]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_New_Profile]
@LName nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@Pswd nvarchar(15),
@Phone nvarchar(25),
@Email nvarchar(150),
@Status int,
@Secret1 nvarchar(75),
@Answer1 nvarchar(75),
@Secret2 nvarchar(75),
@Answer2 nvarchar(75)

as

DECLARE @Idnum TABLE (UserID int)
DECLARE @Idparam int

BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Users(LName, FName, UserName, Pswd, Phone, Email, Status)
		OUTPUT inserted.UserID INTO @Idnum
		VALUES (@Lname, @FName, @UserName, HASHBYTES('md5', @Pswd), @Phone, @Email, 1);
		INSERT INTO PasswordRecovery(UserID)
		SELECT UserID
		FROM @Idnum
		SELECT @Idparam = UserID from @Idnum
		EXEC PasswordRecovery_Update @Idparam,@Secret1,@Answer1,@Secret2,@Answer2
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Insert_User]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_User]
@Lname nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@Pswd nvarchar(15),
@Phone nvarchar(25),
@Email nvarchar(150)
as
INSERT INTO Users(LName, FName, UserName, Pswd, Phone, Email, Status)
VALUES (@Lname, @FName, @UserName, HASHBYTES('md5', @Pswd), @Phone, @Email, 1);


GO
/****** Object:  StoredProcedure [dbo].[Login_Check]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login_Check]
@UserName nvarchar(50), @Password nvarchar(15)
AS
SELECT 1
FROM dbo.Users
WHERE UserName = @UserName AND Pswd = HASHBYTES('md5', @Password) AND Status = 1;
GO
/****** Object:  StoredProcedure [dbo].[PasswordRecovery_Update]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PasswordRecovery_Update]
@userID int,
@Secret1 nvarchar(75),
@Answer1 nvarchar(75),
@Secret2 nvarchar(75),
@Answer2 nvarchar(75)
as
UPDATE PasswordRecovery 
   SET SecretQuestion1 = @Secret1,
       Answer1 = @Answer1,
       SecretQuestion2 = @Secret2,
       Answer2 = @Answer2
 WHERE UserID = @UserID

GO
/****** Object:  StoredProcedure [dbo].[Profile_Update]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profile_Update] 
@UserID int,
@LName nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@Pswd nvarchar(15),
@Phone nvarchar(25),
@Email nvarchar(150),
@Status int

as 

UPDATE Users 
   SET [LName] = @LName,
       [FName] = @FName,
       [UserName] = @UserName,
       [Pswd] = HASHBYTES('md5',@Pswd),
       [Phone] = @Phone,
       [Email] = @Email, 
       [Status] = @Status
 WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[Reset_Password]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reset_Password]
@UserID int,
@Password nvarchar(15)
as
UPDATE Users 
   SET [Pswd] = HASHBYTES('md5', @Password)
 WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[Update_Profile_AND_Recovery]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Profile_AND_Recovery]
@UserID int,
@LName nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@Pswd nvarchar(15),
@Phone nvarchar(25),
@Email nvarchar(150),
@Status int,
@Secret1 nvarchar(75),
@Answer1 nvarchar(75),
@Secret2 nvarchar(75),
@Answer2 nvarchar(75)
as

BEGIN TRANSACTION
	BEGIN TRY
		EXEC Profile_Update @UserID,@LName,@FName,@UserName,@Pswd,@Phone,@Email,@Status
		EXEC PasswordRecovery_Update @UserID,@Secret1,@Answer1,@Secret2,@Answer2
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Users_Insert]
@Lname nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@Pswd nvarchar(15),
@Phone nvarchar(25),
@Email nvarchar(150)

as

INSERT INTO [dbo].[Users]
           ([LName]
           ,[FName]
           ,[UserName]
           ,[Pswd]
           ,[Phone]
           ,[Email]
           ,[Status])
     VALUES
           (@LName
           ,@FName
           ,@UserName
           ,@Pswd
           ,@Phone
           ,@Email
           ,1)

GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Users_Update]
@UserID int,
@LName nvarchar(50),
@FName nvarchar(50),
@UserName nvarchar(50),
@pswd nvarchar(15),
@Phone nvarchar(25),
@email nvarchar(150),
@status int

as

UPDATE [dbo].[Users]
   SET [LName] = @LName,
       [FName] = @FName,
       [UserName] = @UserName,
       [Pswd] = HASHBYTES('md5', @pswd),
       [Phone] = @Phone,
       [Email] = @Email, 
       [Status] = @Status
 WHERE UserID = @UserID

GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[Street] [nvarchar](50) NULL,
	[apt] [nvarchar](10) NULL,
	[City] [nvarchar](50) NULL,
	[Region] [int] NULL,
	[Country] [int] NULL,
	[ZipCode] [nvarchar](15) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayValue] [nvarchar](50) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Flowers]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flowers](
	[FlowerID] [int] IDENTITY(1,1) NOT NULL,
	[RetialPrice] [money] NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Flowers] PRIMARY KEY CLUSTERED 
(
	[FlowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FlowersSeasonal]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlowersSeasonal](
	[flowerSeasonalID] [int] IDENTITY(1,1) NOT NULL,
	[Flower] [int] NOT NULL,
	[Seasonal] [int] NOT NULL,
 CONSTRAINT [PK_FlowersSeasonal] PRIMARY KEY CLUSTERED 
(
	[Flower] ASC,
	[Seasonal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[InvoiceDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[ItemNumber] [int] NULL,
	[Flower] [int] NULL,
	[Processed] [int] NULL,
	[DeliveryAddress] [int] NULL,
	[InvoiceID] [int] NULL,
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Date] [date] NULL,
	[TaxCode] [money] NULL,
	[Processed] [int] NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderSummary]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderSummary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[NumberOfItems] [int] NULL,
	[TotalPrice] [nvarchar](50) NULL,
	[ShipToName] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PasswordRecovery]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordRecovery](
	[UserID] [int] NOT NULL,
	[SecretQuestion1] [nvarchar](75) NULL,
	[Answer1] [nvarchar](75) NULL,
	[SecretQuestion2] [nvarchar](75) NULL,
	[Answer2] [nvarchar](75) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Regions]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regions](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayValue] [nvarchar](50) NULL,
 CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seasonal]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seasonal](
	[Seasonalid] [int] IDENTITY(5,1) NOT NULL,
	[DisplayValue] [nvarchar](50) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Seasonal] PRIMARY KEY CLUSTERED 
(
	[Seasonalid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxCode]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxCode](
	[TaxCodeID] [int] IDENTITY(1,1) NOT NULL,
	[TaxRate] [money] NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/9/2022 11:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[LName] [nvarchar](50) NULL,
	[FName] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[Pswd] [nvarchar](15) NULL,
	[Phone] [nvarchar](25) NULL,
	[Email] [nvarchar](150) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[OrderSummary]  WITH CHECK ADD  CONSTRAINT [FK_OrderSummary_Invoices] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[OrderSummary] CHECK CONSTRAINT [FK_OrderSummary_Invoices]
GO
ALTER TABLE [dbo].[PasswordRecovery]  WITH CHECK ADD  CONSTRAINT [FK_PasswordRecovery_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PasswordRecovery] CHECK CONSTRAINT [FK_PasswordRecovery_Users]
GO
