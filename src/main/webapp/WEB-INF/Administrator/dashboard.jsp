<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
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
			<div class="flex-col dashboard-right-column-content align-center">
				<h3 class="dashboard-heading">Most Popular</h3>
				<c:if test="${empty popular}">
					<h4 class="">No products found</h4>
				</c:if>
				<c:if test="${not empty popular}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${popular}" var="p">
							<c:set var="pId" value="${p.id}"></c:set>
							<c:set var="pName" value="${p.name}"></c:set>
							<c:set var="pDescription" value="${p.description}"></c:set>
							<c:set var="pPrice" value="${p.price}"></c:set>
							<c:set var="pSales" value="${p.sales}"></c:set>
							<c:set var="pStock" value="${p.stock}"></c:set>
							<c:set var="pPhotos" value="${p.photos}"></c:set>
							<c:set var="pPhotoImgPath" value="${p.photoImagePath}"></c:set>
								<div class="card pFont">
									<img class="card-image" src="${pPhotoImgPath}"
										alt="${pPhotos}" />
									<h4 class="card-heading">${pName}</h4>
									<h4 class="card-heading">$${pPrice}</h4>
									<p class="card-desc">${pSales} Sold</p>
									<p class="card-desc">${pStock} available</p>
									<a href="product_details?prodId=${pId}" class="text-center"><button class="dash-btn">View</button></a>
								</div>
						</c:forEach>
					</div>						
				</c:if>
				<a href="product"><button class="share-btn">View All Product</button></a>				
			</div>
			<div class="flex-col dashboard-right-column-content align-center">
				<h3 class="dashboard-heading">Categories</h3>
				<c:if test="${empty recent}">
					<h4 class="">No categories found</h4>
				</c:if>
				<c:if test="${not empty recent}">
					<div class="flex-wrap card-container justify-evenly">				
						<c:forEach items="${recent}" var="c">
							<c:set var="cId" value="${c.id}"></c:set>
							<c:set var="cName" value="${c.name}"></c:set>
							<c:set var="cDesc" value="${c.description}"></c:set>
							<a href="category_details?catId=${cId}" class="card pFont center"><div>
								<h4 class="card-heading text-center">${cName}</h4>
							</div></a>
						</c:forEach>
					</div>					
				</c:if>
				<a href="category"><button class="share-btn">View All Category</button></a>						
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>