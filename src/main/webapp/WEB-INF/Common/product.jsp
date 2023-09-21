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
			<div class="flex-col dashboard-right-column-content align-center">
				<h3 class="dashboard-heading">Most Popular</h3>
				<c:if test="${empty allProduct}">
					<h4 class="">No products found</h4>
				</c:if>
				<c:if test="${not empty allProduct}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${allProduct}" var="p">
							<c:set var="pId" value="${p.id}"></c:set>
							<c:set var="pName" value="${p.name}"></c:set>
							<c:set var="pDescription" value="${p.description}"></c:set>
							<c:set var="pPrice" value="${p.price}"></c:set>
							<c:set var="pSales" value="${p.sales}"></c:set>
							<c:set var="pStock" value="${p.stock}"></c:set>
							<c:set var="pPhotos" value="${p.photos}"></c:set>
							<c:set var="pPhotoImgPath" value="${p.photoImagePath}"></c:set>
							<div class="card pFont">
								<img class="card-image" src="${pPhotoImgPath}" alt="${pPhotos}" />
								<h4 class="card-heading">${pName}</h4>
								<h4 class="card-heading">$${pPrice}</h4>
								<p class="card-desc">${pSales} Sold</p>
								<a href="product_details?prodId=${pId}" class="text-center"><button class="dash-btn">View</button></a>
							</div>
						</c:forEach>
					</div>
				</c:if>
				<sec:authorize access="hasRole('Administrator')">
				<button id="createProduct" class="share-btn">Add Product</button>
				</sec:authorize>
			</div>
			<sec:authorize access="hasRole('Administrator')">
			<!-- Product Modal -->

			<dialog id="createProductModal" class="modal">

			<div class="align-center error-popup">
				<span class="material-icons">error</span>
				<p id="error-text" class="pFont error-text"></p>
				<button class="btnAnimation icon material-icons"
					onclick="closeFormError()">close</button>
			</div>

			<h3 class="modal-heading">Product</h3>
			<sf:form id="createProductForm" class="align-center flex-col form"
				onsubmit="validateCreateProduct(event)" action="create_product"
				method="post" modelAttribute="product"
				enctype="multipart/form-data">
				<div class="input-group">
					<input required="true" type="text" name="name" path="name"
						autocomplete="off" id="fullname" class="input"
						onkeyup="validateFullname()" /> <label class="user-label">Name</label>
				</div>
				<div class="input-group">
					<input required="true" type="text" name="description"
						path="description" autocomplete="off" class="input" /> <label
						class="user-label">Description</label>
				</div>
				<div class="input-group">
					<input required="true" type="text" name="price"
						path="price" autocomplete="off" class="input" /> <label
						class="user-label">Price</label>
				</div>
				<div class="input-group">
					<label class="select-label">Category:</label> <select id="category"
						class="input-select" name="category">
						<option value="" selected disabled hidden>Choose here</option>
						<c:forEach items="${category}" var="cat">
							<option value="${cat.id}">${cat.name}</option>
						</c:forEach>
					</select>
				</div>				
				<div class="input-group">
					<input type="file" class="input" name="fileImage" id="photo"
						accept="image/png, image/jpeg" required="true" /> <label
						class="user-label"></label>
				</div>
				<div class="input-group"
					style="height: 200px; width: 300px; margin: auto;">
					<img id="imgPreview" src="images/Logo.png" alt="image preview"
						style="width: inherit; height: inherit;" />
				</div>

				<button class="submit-btn btnAnimation"
					style="background-color: var(- -success);" type="submit">Save</button>
			</sf:form>
			<button id="closeCreateProduct" class="material-icons modal-close">close</button>
			</dialog>
			<script>
						            $(document).ready(() => {
						            	
						                $("#photo").change(function () {
						                    const file = this.files[0];
						                    if (file) {
						                        let reader = new FileReader();
						                        reader.onload = function (event) {
						                            $("#imgPreview")
						                              .attr("src", event.target.result);
						                        };
						                        reader.readAsDataURL(file);
						                    }
						                });
						            });
						        </script>
			<script>
					document.querySelector("#createProduct").addEventListener("click", () => {
						document.querySelector("#createProductModal").showModal();
						});
					
					document.querySelector("#closeCreateProduct").addEventListener("click", () => {
						document.querySelector("#createProductModal").close();
						});
					</script>
			</sec:authorize>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>