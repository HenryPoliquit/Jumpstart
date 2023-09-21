<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../header.jsp">
	<jsp:param value="User" name="HTMLtitle" />
</jsp:include>

<main class="bg2 align-center flex-col">
	<div class="flex dashboard">
		<!-- 1st Column -->
		<div class="dashboard-left">
			<div class="dashboard-left-column-links">
				<c:forEach items="${product}" var="p">
					<c:set var="pId" value="${p.id}"></c:set>
					<c:set var="pName" value="${p.name}"></c:set>
					<c:set var="pDescription" value="${p.description}"></c:set>
					<c:set var="pPrice" value="${p.price}"></c:set>
					<c:set var="pSales" value="${p.sales}"></c:set>
					<c:set var="pStock" value="${p.stock}"></c:set>
					<c:set var="pPhotos" value="${p.photos}"></c:set>
					<c:set var="pPhotoImgPath" value="${p.photoImagePath}"></c:set>
					<c:set var="cId" value="${p.getCategory().getId()}"></c:set>
					<c:set var="cName" value="${p.getCategory().getName()}"></c:set>
				</c:forEach>
				<div class="two-block-card-col flex-col">
					<div class="two-block-first-col">
						<img class="prod-img" src="${pPhotoImgPath}" alt="${pPhotos}" />
					</div>
					<div class="two-block-second-col">
						<div class="prod-detail">
							<h3 class="two-block-heading-col">${pName}</h3>
							<p class="hFont">Category: ${cName}</p>
							<p class="pFont">Description: ${pDescription}</p>
							<h4 class="hFont">Price: $${pPrice}</h4>
							<p class="pFont">Items sold: ${pSales} Sold</p>
							<p class="pFont">Items available: ${pStock} items</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 2nd Column -->
		<div class="flex-col gap-20">
			<div class="flex-col dashboard-right-column-content align-center">
				<section class="align-center flex-col form-card">
					<h3 class="form-heading">Purchase Form</h3>
					<sf:form action="add_donation" class="align-center flex-col form"
						method="post" modelAttribute="purchase">
						<div class="input-group">
							<sf:input required="true" type="text" name="method"
								autocomplete="off" path="method" class="input" />
							<label class="user-label">Payment Method</label>
						</div>
						<div class="input-group">
							<sf:input required="true" type="text" name="currency"
								autocomplete="off" path="currency" class="input" id="currency"
								value="USD" />
							<label class="user-label">Currency</label>
						</div>
						<div class="input-group">
							<sf:input required="true" type="text" name="count"
								autocomplete="off" path="count" class="input"
								id="donation-amount" />
							<label class="user-label">Count</label>
						</div>
						<div class="input-group">
							<sf:input required="true" type="text" name="total"
								autocomplete="off" path="total" class="input"
								id="donation-amount" />
							<label class="user-label">Amount</label>
						</div>
						<div class="input-group">
							<sf:input required="true" type="text" name="intent"
								autocomplete="off" value="sale" path="intent" class="input" />
							<label class="user-label">Intent</label>
						</div>
						<div class="input-group">
							<sf:input required="true" type="text" name="description"
								autocomplete="off" path="description" class="input" />
							<label class="user-label">Payment Description</label>
						</div>

						<button type="submit" class="submit-btn">Donate</button>
					</sf:form>
					<a href="paypal"><button class="submit-btn">Pay with
							PayPal</button></a>
				</section>
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>