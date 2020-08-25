--	Error handling - Workshop

/*Add error handling on CreateOrderDetail procedure
Test the error handling by inserting not-existing values for ProductId*/

alter procedure dbo.CreateOrderDetail(
					@OrderId bigint,
					@ProductId int,
					@Quantity int)
as
begin
	declare @Price decimal(18, 2)
	declare @TotalPrice decimal(18, 2)

	select @price = Price
	from dbo.Product
	where Id = @ProductId

	begin try
		insert into dbo.OrderDetails(OrderId, ProductId, Quantity, Price)
		select @OrderId, @ProductId, @Quantity, @Price

		select @TotalPrice = sum(Quantity * Price)
		from dbo.OrderDetails
		where OrderId = @OrderId

		update dbo.[Order]
		set TotalPrice = @TotalPrice
		where Id = @OrderId

		select p.[Name], sum(od.Price * od.Quantity)
		from dbo.OrderDetails as od
		inner join dbo.Product as p on p.Id = od.ProductId
		where od.OrderId = @OrderId
		group by p.[Name]
	end try
	begin catch
		select
			ERROR_NUMBER() as ErrorNumber,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMsg
		return
	end catch
end
go

--execute dbo.CreateOrderDetail 3, 2, 3
execute dbo.CreateOrderDetail 3, 88, 3