<jsp:include page="../header.jsp">
	<jsp:param value="Purchase Confirmed" name="HTMLtitle" />
</jsp:include>

<main class="bg1 align-center justify-center">

	<div class="align-center util-card flex-col">
		<img src="images/order-confirm.svg" alt="Confirmation" width="400"
			height="300" />
		<p class="hFont text-align-center">Purchase has been successfully placed</p>
		<p class="hFont text-align-center">Your code for pickup is: ${code}</p>
		<a href="ongoing-orders" class="btnAnimation pFont text-deco-none">Click
			here to view your purchase</a>
	</div>

</main>

<jsp:include page="../footer.jsp"></jsp:include>