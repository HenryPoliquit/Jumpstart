<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
				<div class="two-block-card">
					<div class="two-block-first">
						<img class="prod-img" src="${pPhotoImgPath}" alt="${pPhotos}" />
					</div>
					<div class="flex-col two-block-second">
						<div class="prod-detail">
							<h3 class="two-block-heading">${pName}</h3>
							<span class="hFont">Category: <a
								href="category_details?catId=${cId}" class="hFont link">${cName}</a></span>
							<p class="pFont">Description: ${pDescription}</p>
							<h4 class="hFont">Price: $${pPrice}</h4>
							<p class="pFont">Items sold: ${pSales} Sold</p>
							<p class="pFont">Items available: ${pStock} items</p>
						</div>
						<div class="button-holder center">
							<sec:authorize access="hasRole('Users')">
								<a href="purchase?prodId=${pId}"><button class="share-btn">Purchase</button></a>
								<sf:form method="post" action="add_to_cart" target="dummyframe">
									<input type="hidden" name="prodId" value="${pId}" />
									<button class="dash-btn" type="submit">Add to Cart</button>
								</sf:form>
							</sec:authorize>
							<sec:authorize access="hasRole('Sales')">
								<button id="editProduct" class="share-btn">Update Stock</button>
								<!-- Update Stock Modal -->

								<dialog id="editProductModal" class="modal">

								<div class="align-center error-popup">
									<span class="material-icons">error</span>
									<p id="error-text" class="pFont error-text"></p>
									<button class="btnAnimation icon material-icons"
										onclick="closeFormError()">close</button>
								</div>

								<h3 class="modal-heading">Update Stock</h3>
								<sf:form id="editProductForm" class="align-center flex-col form"
									onsubmit="validateEditProduct(event)" action="update_stock?prodId=${pId}"
									method="post" modelAttribute="stock">
									<div class="input-group">
										<input required="true" type="text" name="stock" path="stock"
											autocomplete="off" class="input" /> <label
											class="user-label">Stock</label>
									</div>
									<button class="submit-btn btnAnimation"
										style="background-color: var(- -success);" type="submit">Save</button>
								</sf:form>
								<button id="closeEditProduct" class="material-icons modal-close">close</button>
								</dialog>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
			<div class="flex-col dashboard-right-column-content">
				<h3 class="dashboard-heading">Related Products</h3>
				<c:if test="${empty related}">
					<h4 class="dashboard-heading">No related products found</h4>
				</c:if>
				<c:if test="${not empty related}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${related}" var="r">
							<c:set var="rId" value="${r.id}"></c:set>
							<c:set var="rName" value="${r.name}"></c:set>
							<c:set var="rDescription" value="${r.description}"></c:set>
							<c:set var="rPrice" value="${r.price}"></c:set>
							<c:set var="rSales" value="${r.sales}"></c:set>
							<c:set var="rStock" value="${r.stock}"></c:set>
							<c:set var="rPhotos" value="${r.photos}"></c:set>
							<c:set var="rPhotoImgPath" value="${r.photoImagePath}"></c:set>
							<c:if test="${rName ne pName == true}">
								<div class="card pFont">
									<img class="card-image" src="${rPhotoImgPath}" alt="${rPhotos}" />
									<h4 class="card-heading">${rName}</h4>
									<h4 class="card-heading">$${rPrice}</h4>
									<p class="card-desc">${rSales}Sold</p>
									<p class="card-desc">${rStock}available</p>
									<a href="product_details?prodId=${rId}" class="text-center"><button
											class="dash-btn">View</button></a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
</main>

<jsp:include page="../footer.jsp"></jsp:include>