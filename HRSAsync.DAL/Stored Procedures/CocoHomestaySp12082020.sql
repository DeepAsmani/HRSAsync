USE [CoCoHomeStayDb]
GO
/****** Object:  StoredProcedure [dbo].[Booking_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_Delete>ssss
-- =============================================
CREATE PROCEDURE [dbo].[Booking_Delete]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].BOOKING
		   SET IsCanceled = 1
		WHERE BookingId = @BookingId
		SET @Message = 'Service has been deleted successfully!'
		SELECT @BookingId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Booking_GetAll]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKING
  WHERE IsCanceled = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Booking_GetByBookingId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKING
  WHERE IsCanceled = 0 AND @BookingId = BookingId
END

GO
/****** Object:  StoredProcedure [dbo].[Booking_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_Save]
	-- Add the parameters for the stored procedure here
	@BookingId INT,
	@CustomerId INT,
	@CouponId INT,
	@CheckinDate DATETIME,
	@CheckoutDate DATETIME,
	@NumberofAdults INT,
	@NumberofChildren INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
DECLARE @ServiceAmount FLOAT
DECLARE @RoomAmount FLOAT
DECLARE @Reduction FLOAT
DECLARE @CreateDate DATE
DECLARE @UpdateCouponId INT = NULL
BEGIN TRY
SET @CreateDate = GETDATE()
IF(EXISTS(SELECT Reduction FROM COUPON WHERE (CouponId = @CouponId) AND (Remain > 0) AND (@CreateDate < EndDate) AND (IsDeleted = 0)))
	BEGIN
		SET @Reduction = (SELECT Reduction FROM COUPON WHERE (CouponId = @CouponId) AND (Remain > 0) AND (@CreateDate < EndDate) AND (IsDeleted = 0))
		SET @RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = @BookingId)*@Reduction
		SET @UpdateCouponId = @CouponId
	END
ELSE 
	BEGIN
		SET @RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = @BookingId)
	END
SET @ServiceAmount = (SELECT SUM(ServicePrice) FROM BOOKINGSERVICEDETAILS WHERE BookingId = @BookingId)

	IF (@BookingId = 0 OR @BookingId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[BOOKING]
           (CustomerId
           ,CreateDate
		   ,ServiceAmount
		   ,RoomAmount
		   ,CouponId
		   ,IsCanceled
		   ,CheckinDate
		   ,CheckoutDate
		   ,NumberofAdults
		   ,NumberofChildren)
			VALUES
           (@CustomerId
		   ,@CreateDate
		   ,0
		   ,0
		   ,@UpdateCouponId
		   ,0
		   ,@CheckinDate
		   ,@CheckoutDate
		   ,@NumberofAdults
		   ,@NumberofChildren)
			SET @BookingId = SCOPE_IDENTITY()
			SET @Message = 'Booking has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[BOOKING]
			   SET CustomerId = @CustomerId,
				   ServiceAmount = @ServiceAmount,
				   RoomAmount = @RoomAmount,
				   CouponId = @UpdateCouponId,
				   CheckinDate = @CheckinDate,
				   CheckoutDate = @CheckoutDate,
				   NumberofAdults = @NumberofAdults,
				   NumberofChildren = @NumberofChildren
			 WHERE @BookingId = BookingId
			 SET @Message = 'Booking has been updated successfully!'
		END;
		SELECT @BookingId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @BookingId = 0
		SELECT @BookingId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_Delete]
	-- Add the parameters for the stored procedure here
	@BookingRoomDetailsId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[BOOKINGROOMDETAILS]
		WHERE BookingRoomDetailsId = @BookingRoomDetailsId
		SET @Message = 'BookingRoomDetails has been deleted successfully!'
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_GetByBookingId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_GetByBookingId>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS

BEGIN

SELECT *
  FROM [dbo].BOOKINGROOMDETAILS
  WHERE @BookingId = BOOKINGROOMDETAILS.BookingId AND EXISTS(SELECT * FROM [dbo].BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Save>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_Save]
	-- Add the parameters for the stored procedure here
	@BookingRoomDetailsId INT,
	@RoomTypeId INT,
	@BookingId INT,
	@RoomQuantity INT,
	@Date DATETIME
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
declare @RoomPrice FLOAT
DECLARE @DiscountRates FLOAT
SET @DiscountRates = (SELECT MIN(DiscountRates) AS DiscountRates FROM PROMOTION  
					 INNER JOIN PROMOTIONAPPLY
					 ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
					 WHERE PROMOTIONAPPLY.RoomTypeId = @RoomTypeId
					 GROUP BY StartDate, EndDate
					 HAVING @Date >= StartDate AND @Date < EndDate)

IF (@DiscountRates<>0)
BEGIN
	SET @RoomPrice = 
	 (SELECT DefaultPrice FROM ROOMTYPE WHERE ROOMTYPE.RoomTypeId = @RoomTypeId)
	*(@DiscountRates) 
	*(@RoomQuantity)
END
ELSE
BEGIN
	SET @RoomPrice = 
	 (SELECT DefaultPrice FROM ROOMTYPE WHERE ROOMTYPE.RoomTypeId = @RoomTypeId)
	*(@RoomQuantity)
END



	IF (@BookingRoomDetailsId = 0 OR @BookingRoomDetailsId = NULL)
		BEGIN -- Create new RoomType
		  
			INSERT INTO [dbo].BOOKINGROOMDETAILS
           (RoomTypeId
		   ,BookingId
           ,RoomQuantity
		   ,[Date]
		   ,RoomPrice)
			VALUES
           (@RoomTypeId
		   ,@BookingId
		   ,@RoomQuantity
		   ,@Date
		   ,@RoomPrice)
			SET @BookingRoomDetailsId = SCOPE_IDENTITY()
			SET @Message = 'BookingRoomDetails has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].BOOKINGROOMDETAILS
			   SET RoomTypeId = @RoomTypeId,
				   RoomQuantity = @RoomQuantity,
				   Date = @Date,
				   RoomPrice = @RoomPrice
			 WHERE @BookingRoomDetailsId = BookingRoomDetailsId
			 SET @Message = 'BookingRoomDetails has been updated successfully!'
		END;
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @BookingRoomDetailsId = 0
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_Delete]
	-- Add the parameters for the stored procedure here
	@BookingServiceDetailsId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].BOOKINGSERVICEDETAILS
		WHERE @BookingServiceDetailsId = BookingServiceDetailsId
		SET @Message = 'BookingServiceDetails has been deleted successfully!'
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_GetByBookingId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKINGSERVICEDETAILS
  WHERE @BookingId = BOOKINGSERVICEDETAILS.BookingId AND EXISTS(SELECT * FROM [dbo].BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingServiceDetails_Save>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_Save]
	-- Add the parameters for the stored procedure here
	@BookingServiceDetailsId INT,
	@BookingId INT,
	@ServiceId INT,
	@ServiceQuantity INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
DECLARE @ServicePrice FLOAT
BEGIN TRY

SET @ServicePrice = (SELECT Price FROM [SERVICE] WHERE [SERVICE].ServiceId = @ServiceId)
				   *(@ServiceQuantity)

	IF (@BookingServiceDetailsId = 0 OR @BookingServiceDetailsId = NULL)
		BEGIN -- Create new RoomType
		  
			INSERT INTO [dbo].BOOKINGSERVICEDETAILS
           (BookingId
           ,ServiceId
		   ,ServiceQuantity
		   ,ServicePrice)
			VALUES
           (@BookingId
		   ,@ServiceId
		   ,@ServiceQuantity
		   ,@ServicePrice)
			SET @BookingServiceDetailsId = SCOPE_IDENTITY()
			SET @Message = 'BookingServiceDetails has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].BOOKINGSERVICEDETAILS
			   SET BookingId = @BookingId,
				   ServiceId = @ServiceId,
				   ServicePrice = @ServicePrice,
				   ServiceQuantity = @ServiceQuantity
			 WHERE @BookingServiceDetailsId = BookingServiceDetailsId
			 SET @Message = 'BookingServiceDetails has been updated successfully!'
		END;
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @BookingServiceDetailsId = 0
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Coupon_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_Delete]
	-- Add the parameters for the stored procedure here
	@CouponId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].COUPON
		   SET IsDeleted = 1
		WHERE CouponId = @CouponId
		SET @Message = 'Customer has been deleted successfully!'
		SELECT @CouponId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @CouponId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Coupon_GetAll]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].COUPON WHERE (IsDeleted = 0)
END

GO
/****** Object:  StoredProcedure [dbo].[Coupon_GetbyId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_GetbyId]
	-- Add the parameters for the stored procedure here
	@CouponId INT
AS
BEGIN 
SELECT *
  FROM [dbo].COUPON
  WHERE CouponId = @CouponId AND (IsDeleted = 0)
END

GO
/****** Object:  StoredProcedure [dbo].[Coupon_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_Save]
	-- Add the parameters for the stored procedure here
	@CouponId INT,
	@CouponCode NVARCHAR(50),
	@Remain INT,
	@Reduction FLOAT,
	@EndDate DATE
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@CouponId = 0 OR @CouponId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[COUPON]
           ([CouponCode]
           ,[Remain]
		   ,[Reduction]
		   ,[EndDate]
		   ,[IsDeleted])
			VALUES
           (@CouponCode
		   ,@Remain
		   ,@Reduction
		   ,@EndDate
		   ,0)
			SET @CouponId = SCOPE_IDENTITY()
			SET @Message = 'Coupon has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[COUPON]
			   SET [CouponCode] = @CouponCode,
				   [Remain] = @Remain,
				   [Reduction] = @Reduction,
				   [EndDate] = @EndDate
			 WHERE CouponId = @CouponId
			 SET @Message = 'Coupon has been updated successfully!'
		END;
		SELECT @CouponId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @CouponId = 0
		SELECT @CouponId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Customer_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_Delete]
	-- Add the parameters for the stored procedure here
	@CustomerId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].CUSTOMER
		   SET IsDeleted = 1
		WHERE CustomerId = @CustomerId
		SET @Message = 'Customer has been deleted successfully!'
		SELECT @CustomerId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @CustomerId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Customer_GetAll]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].CUSTOMER
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Customer_GetByCustomerId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_GetByCustomerId>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_GetByCustomerId]
	-- Add the parameters for the stored procedure here
	@CustomerId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[CUSTOMER]
  WHERE IsDeleted = 0 AND @CustomerId = CustomerId
END

GO
/****** Object:  StoredProcedure [dbo].[Customer_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_Save]
	-- Add the parameters for the stored procedure here
	@CustomerId INT,
	@Name NVARCHAR(50),
	@PhoneNumber NVARCHAR(50),
	@Email NVARCHAR(50)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@CustomerId = 0 OR @CustomerId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].CUSTOMER
           ([Name]
		   ,PhoneNumber
		   ,Email
		   ,IsDeleted)
			VALUES
           (@Name
		   ,@PhoneNumber
		   ,@Email
		   ,0)
			SET @CustomerId = SCOPE_IDENTITY()
			SET @Message = 'Customer has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].CUSTOMER
			   SET [Name] = @Name,
				   PhoneNumber = @PhoneNumber,
				   Email = @Email
			 WHERE @CustomerId = CustomerId
			 SET @Message = 'Customer has been updated successfully!'
		END;
		SELECT @CustomerId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @CustomerId = 0
		SELECT @CustomerId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Facility_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_Delete]
	@FacilityId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].FACILITIES
		WHERE FacilityId = @FacilityId
		SET @Message = 'RoomType has been deleted successfully!'
		SELECT @FacilityId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @FacilityId AS Id, @Message AS [Message]
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Facility_GetAll]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_GetAll]
AS
BEGIN 
SELECT *
  FROM [dbo].FACILITIES
END

GO
/****** Object:  StoredProcedure [dbo].[Facility_GetbyId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_GetbyId]
	@FacilityId INT
AS
BEGIN 
SELECT *
  FROM [dbo].FACILITIES
  WHERE FacilityId = @FacilityId
END

GO
/****** Object:  StoredProcedure [dbo].[Facility_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Facility_Save]
	@FacilityId INT,
	@FacilityName NVARCHAR(50),
	@FacilityImage NVARCHAR(MAX)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@FacilityId = 0 OR @FacilityId = NULL)
		BEGIN
			INSERT INTO [dbo].FACILITIES
           (FacilityName
           ,FacilityImage)
			VALUES
           (@FacilityName
		   ,@FacilityImage)
			SET @FacilityId = SCOPE_IDENTITY()
			SET @Message = 'Facility has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].FACILITIES
			   SET FacilityName = @FacilityName,
				   FacilityImage = @FacilityImage
			 WHERE FacilityId = @FacilityId
			 SET @Message = 'Facility has been updated successfully!'
		END;
		SELECT @FacilityId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @FacilityId = 0
		SELECT @FacilityId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_Delete]
	@FacilitiesApplyId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[FACILITIESAPPLY]
		WHERE @FacilitiesApplyId = FacilitiesApplyId
		SET @Message = 'Facility has been removed successfully!'
		SELECT @FacilitiesApplyId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @FacilitiesApplyId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_DeleteByRoomTypeId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_DeleteByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[FACILITIESAPPLY]
		WHERE @RoomTypeId = RoomTypeId
		SET @Message = 'Facility has been removed successfully!'
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_GetByRoomTypeId]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[FACILITIESAPPLY] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 31/07/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_Save]
	@FacilityId INT,
	@RoomTypeId INT
AS
BEGIN
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	BEGIN
		INSERT INTO [dbo].[FACILITIESAPPLY]
        (FacilityId
		,RoomTypeId)
		VALUES
        (@FacilityId
		,@RoomTypeId)
		SET @FacilityId = SCOPE_IDENTITY()
		SET @Message = 'Facility has been added successfully!'
	END
END TRY
BEGIN CATCH
		SET @FacilityId = 0
END CATCH
SELECT @FacilityId AS Id, @Message AS [Message]
END
GO
/****** Object:  StoredProcedure [dbo].[Promotion_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Promotion_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_Delete]
	-- Add the parameters for the stored procedure here
	@PromotionId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].PROMOTION
		   SET IsDeleted = 1
		WHERE PromotionId = @PromotionId
		SET @Message = 'Promotion has been deleted successfully!'
		SELECT @PromotionId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @PromotionId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetAll]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: [Promotion_GetAll]>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].PROMOTION WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetById]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 04/08/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetById]
	-- Add the parameters for the stored procedure here
	@PromotionId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[PROMOTION]
  WHERE IsDeleted = 0 AND PromotionId = @PromotionId
END

GO
/****** Object:  StoredProcedure [dbo].[Promotion_Save]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Promotion_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_Save]
	-- Add the parameters for the stored procedure here
	@PromotionId INT,
	@PromotionName NVARCHAR(50),
	@StartDate DATE,
	@EndDate DATE,
	@DiscountRates FLOAT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@PromotionId = 0 OR @PromotionId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].PROMOTION
           (PromotionName,
		    StartDate,
			EndDate,
			DiscountRates,
			IsDeleted)
			VALUES
           (@PromotionName,
		   @StartDate,
		   @EndDate,
		   @DiscountRates,
		   0)
			SET @PromotionId = SCOPE_IDENTITY()
			SET @Message = 'Promotion has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].PROMOTION
			   SET StartDate = @StartDate,
				   EndDate = @EndDate,
				   DiscountRates = @DiscountRates
			 WHERE PromotionId = @PromotionId
			 SET @Message = 'Promotion has been updated successfully!'
		END;
		SELECT @PromotionId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @PromotionId = 0
		SELECT @PromotionId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_Delete]    Script Date: 8/12/2020 8:23:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_Delete]
	@PromotionApplyId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[PromotionApply]
		WHERE @PromotionApplyId = PromotionApplyId
		SET @Message = 'PromotionApply has been deleted successfully!'
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_GetAll]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_GetAll]
AS
BEGIN
	SELECT * FROM [dbo].[PROMOTIONAPPLY]
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_GetByRoomTypeId]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[PROMOTIONAPPLY] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_Save]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 31/07/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_Save]
	@PromotionApplyId INT,
	@PromotionId INT,
	@RoomTypeId INT
AS
BEGIN
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@PromotionApplyId = 0 OR @PromotionApplyId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[PromotionApply]
           (PromotionId
		   ,RoomTypeId)
			VALUES
           (@PromotionId
		   ,@RoomTypeId)
			SET @PromotionApplyId = SCOPE_IDENTITY()
			SET @Message = 'Promotion has been applied successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[PromotionApply]
			   SET PromotionId = @PromotionId,
				   RoomTypeId = @RoomTypeId
			 WHERE PromotionApplyId = @PromotionApplyId
			 SET @Message = 'Promotion apply has been updated successfully!'
		END;
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @PromotionApplyId = 0
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Room_GetAll]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Room_GetByRoomNumber]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetRoomNumber>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetByRoomNumber]
	-- Add the parameters for the stored procedure here
	@RoomNumber INT
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0 AND RoomNumber = @RoomNumber
END

GO
/****** Object:  StoredProcedure [dbo].[Room_GetByRoomTypeId]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetRoomNumber>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetByRoomTypeId]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0 AND RoomTypeId = @RoomTypeId
END

GO
/****** Object:  StoredProcedure [dbo].[Room_Save]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Room_Save]
	-- Add the parameters for the stored procedure here
	@RoomNumber INT,
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF(NOT EXISTS(SELECT * FROM ROOM WHERE @RoomNumber = RoomNumber))
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].ROOM
           ([RoomTypeId]
		   ,RoomNumber
		   ,IsOccupied)
			VALUES
           (@RoomTypeId
		   ,@RoomNumber
		   ,0)
			SET @Message = 'Room has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].ROOM
			   SET RoomTypeId = @RoomTypeId
			 WHERE @RoomNumber = RoomNumber
			 SET @Message = 'Room has been updated successfully!'
		END;
		SELECT @RoomNumber AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @RoomNumber = 0
		SELECT @RoomNumber AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[RoomType_Delete]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Delete]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].ROOMTYPE
		   SET IsDeleted = 1
		WHERE RoomTypeId = @RoomTypeId
		SET @Message = 'RoomType has been deleted successfully!'
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[RoomType_GetAll]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].RoomType
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[RoomType_GetById]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_GetById]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN 
SELECT *
  FROM [dbo].RoomType
  WHERE IsDeleted = 0 AND RoomTypeId = @RoomTypeId
END

GO
/****** Object:  StoredProcedure [dbo].[RoomType_Save]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Save]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT,
	@Name NVARCHAR(50),
	@DefaultPrice INT,
	@Quantity INT,
	@Description NVARCHAR(max),
	@MaxAdult INT,
	@MaxChildren INT,
	@MaxPeople INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@RoomTypeId = 0 OR @RoomTypeId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].ROOMTYPE
           ([Name]
           ,[DefaultPrice]
		   ,Quantity
		   ,IsDeleted
		   ,Description
		   ,MaxAdult
		   ,MaxChildren
		   ,MaxPeople)
			VALUES
           (@Name
		   ,@DefaultPrice
		   ,@Quantity
		   ,0
		   ,@Description
		   ,@MaxAdult
		   ,@MaxChildren
		   ,@MaxPeople)
			SET @RoomTypeId = SCOPE_IDENTITY()
			SET @Message = 'RoomType has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].ROOMTYPE
			   SET [Name] = @Name,
				   DefaultPrice = @DefaultPrice,
				   Quantity = @Quantity,
				   Description = @Description,
				   MaxAdult = @MaxAdult,
				   MaxChildren = @MaxChildren,
				   MaxPeople = @MaxPeople
			 WHERE RoomTypeId = @RoomTypeId
			 SET @Message = 'RoomType has been updated successfully!'
		END;
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @RoomTypeId = 0
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[RoomType_Search]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 11/8/2020
-- Description:	Search RoomType
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Search]
	@Adult INT,
	@Children INT
--	@CheckInDate DATE,
--	@CheckOutDate DATE
AS
BEGIN 
	SELECT RoomTypeId, Name, DefaultPrice, Description FROM ROOMTYPE--, BOOKING, BOOKINGROOMDETAILS 
	WHERE ROOMTYPE.IsDeleted = 0 
	AND MaxAdult >= @Adult AND MaxChildren >= @Children AND MaxPeople >= (@Adult + @Children)

END

GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_Delete]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_Delete]
	@RoomTypeImageId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].ROOMTYPEIMAGES
		WHERE RoomTypeImageId = @RoomTypeImageId
		SET @Message = 'Image has been deleted successfully!'
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT @RoomTypeImageId AS Id, @Message AS [Message]
END  

GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_GetByRoomTypeId]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[ROOMTYPEIMAGES] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_Save]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_Save]
	@RoomTypeId INT,
	@ImageData NVARCHAR(max)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
		INSERT INTO [dbo].[ROOMTYPEIMAGES]
        (RoomTypeId,
		ImageData)
		VALUES
        (@RoomTypeId,
		@ImageData)
		SET @Message = 'RoomType Image has been save successfully!'
		SELECT SCOPE_IDENTITY() AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SELECT 0 AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Delete]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Delete]
	-- Add the parameters for the stored procedure here
	@ServiceId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].[SERVICE]
		   SET IsDeleted = 1
		WHERE ServiceId = @ServiceId
		SET @Message = 'Service has been deleted successfully!'
		SELECT @ServiceId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @ServiceId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Service_GetAll]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Service_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Service_GetByServiceId]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[Service_GetByServiceId]
	-- Add the parameters for the stored procedure here
	@ServiceId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0 AND @ServiceId = ServiceId
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Save]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Save]
	-- Add the parameters for the stored procedure here
	@ServiceId INT,
	@ServiceName NVARCHAR(50),
	@Price INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@ServiceId = 0 OR @ServiceId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[SERVICE]
           ([ServiceName]
           ,[Price]
		   ,IsDeleted)
			VALUES
           (@ServiceName
		   ,@Price
		   ,0)
			SET @ServiceId = SCOPE_IDENTITY()
			SET @Message = 'Service has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[SERVICE]
			   SET [ServiceName] = @ServiceName,
				   Price = @Price
			 WHERE ServiceId = @ServiceId
			 SET @Message = 'Service has been updated successfully!'
		END;
		SELECT @ServiceId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @ServiceId = 0
		SELECT @ServiceId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Search]    Script Date: 8/12/2020 8:23:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Search]
	-- Add the parameters for the stored procedure here
	@keyWord NVARCHAR(50)
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0 AND ServiceName LIKE ('%'+@keyWord+'%')
END

GO
