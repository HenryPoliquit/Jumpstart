<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../header.jsp">
	<jsp:param value="User" name="HTMLtitle" />
</jsp:include>
<main class="bg2">
	<div class="row">
		<div class="col-75">
			<div class="container">
				<sf:form action="pay" method="post" modelAttribute="purchase">
					<c:forEach items="${product}" var="p">
						<c:set var="pId" value="${p.id}"></c:set>
						<c:set var="pPrice" value="${p.price}"></c:set>
					</c:forEach>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<input type="hidden" name="prodId" value="${pId}" />
					<div class="col-50">
						<h3>Payment</h3>
						<label>Accepted Cards</label>
						<div class="icon-container">
							<i class="fa fa-cc-visa" style="color: navy;"></i> <i
								class="fa fa-cc-amex" style="color: blue;"></i> <i
								class="fa fa-cc-mastercard" style="color: red;"></i> <i
								class="fa fa-cc-discover" style="color: orange;"></i>
						</div>
						<label class="paypal-label" for="amount">Product Price</label> <input
							class="paypal" type="text" value="${pPrice}"
							placeholder="Total amount" /> <label class="paypal-label"
							for="currency">Currency</label> <input class="paypal" type="text"
							id="currency" name="currency" path="currency"
							placeholder="Enter Currency" /> <label class="paypal-label"
							for="count">Count</label> <input class="paypal" type="text"
							id="count" name="count" path="count" placeholder="Enter Count" />
						<label class="paypal-label" for="method">Payment Method</label> <input
							class="paypal" type="text" id="method" name="method"
							path="method" placeholder="Payment Method" /> <label
							class="paypal-label" for="intent">Intent</label> <input
							class="paypal" type="text" id="intent" name="intent"
							path="intent" value="sale" /> <label class="paypal-label"
							for="location">Pickup Location</label> <input class="paypal"
							type="text" id="location" name="location" path="location"
							placeholder="Pickup Location" />
					</div>

					<input type="submit" value="Continue to checkout"
						class="paypal-btn">
				</sf:form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="../footer.jsp"></jsp:include>