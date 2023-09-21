<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp">
	<jsp:param value="User" name="HTMLtitle" />
</jsp:include>

<main class="bg2 align-center flex-col">
	<c:forEach items="${user}" var="u">
		<c:set var="id" value="${u.id}"></c:set>
		<c:set var="name" value="${u.name}"></c:set>
		<c:set var="uname" value="${u.userName}"></c:set>
		<c:set var="email" value="${u.email}"></c:set>
		<c:set var="mobile" value="${u.mobile}"></c:set>
		<c:set var="address" value="${u.address}"></c:set>
		<c:set var="gender" value="${u.gender}"></c:set>
	</c:forEach>
	<div class="flex dashboard">
		<!-- 1st Column -->
		<div>
			<div class="flex-col gap-15 dashboard-left">
				<div class="justify-center center dashboard-left-column-profile">
					<div>
						<c:if test="${gender == 'Male'}">
							<img src="images/Profile-male.svg" alt="profile picture"
								width="75" height="75" />
						</c:if>
						<c:if test="${gender == 'Female'}">
							<img src="images/Profile-female.svg" alt="profile picture"
								width="75" height="75" />
						</c:if>
						<c:if test="${gender == 'Prefer not to say'}">
							<img src="images/Profile-wildcard.png" alt="profile picture"
								width="75" height="75" />
						</c:if>
						<c:if test="${gender == null}">
							<img src="images/Profile-wildcard.png" alt="profile picture"
								width="75" height="75" />
						</c:if>
					</div>
					<div style="justify-content: center;">
						<h3>
							<a href="profile" class="hfont link">${name}</a>
						</h3>
						<c:if test="${address != null}">
							<p class="pFont">${address}</p>
						</c:if>
						<c:if test="${address == null}">
							<p class="pFont">No address set</p>
						</c:if>
					</div>
				</div>
				<!-- Links -->
				<jsp:include page="../link.jsp"></jsp:include>
			</div>
		</div>
		<!-- 2nd Column -->
		<div class="flex-col gap-20">
			<div class="flex-col dashboard-right-column-content">
				<h3 class="dashboard-heading">My Cart</h3>
				<c:if test="${empty allCart}">
					<h4 class="">No products found in cart</h4>
				</c:if>
				<c:if test="${not empty allCart}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${allCart}" var="p">
							<c:set var="cartId" value="${p.id}"></c:set>
							<c:set var="pId" value="${p.product.id}"></c:set>
							<c:set var="pCount" value="${p.count}"></c:set>
							<c:set var="pName" value="${p.product.name}"></c:set>
							<c:set var="pDescription" value="${p.product.description}"></c:set>
							<c:set var="pPrice" value="${p.product.price}"></c:set>
							<c:set var="pSales" value="${p.product.sales}"></c:set>
							<c:set var="pStock" value="${p.product.stock}"></c:set>
							<c:set var="pPhotos" value="${p.product.photos}"></c:set>
							<c:set var="pPhotoImgPath" value="${p.product.photoImagePath}"></c:set>
							<div class="card pFont">
								<img class="card-image" src="${pPhotoImgPath}" alt="${pPhotos}" />
								<a href="product_details?prodId=${pId}"><h4
										class="card-heading link">${pName}</h4></a>
								<h4 class="card-heading">$${pPrice}</h4>
								<p class="card-desc">Count: ${pCount}</p>
								<a class="text-center"><button class="dash-btn">Purchase</button></a>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>