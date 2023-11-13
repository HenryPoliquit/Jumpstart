<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../header.jsp">
	<jsp:param value="Profile" name="HTMLtitle" />
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
					<button id="editProfile" class="btn material-icons">edit</button>
				</div>
				<!-- Links -->
				<div class="flex-col dashboard-left-column-links">
					<div class="flex gap-20 center">
						<h3 class="dashboard-heading">About</h3>
						<button id="createAbout" class="post-btn">Create About</button>
					</div>
					<c:forEach items="${summary}" var="u">
						<c:set var="aboutMe" value="${u.summary}"></c:set>
					</c:forEach>
					<c:if test="${aboutMe != null}">
						<p class="pFont">${aboutMe}</p>
					</c:if>
					<c:if test="${aboutMe == null}">
						<p class="pFont">No about added</p>
					</c:if>
					<h3 class="dashboard-heading">Contact</h3>
					<p class="pFont">Email: ${email}</p>
					<c:if test="${mobile != null}">
						<p class="pFont">Mobile: ${mobile}</p>
					</c:if>
					<c:if test="${mobile == null}">
						<p class="pFont">No mobile number set</p>
					</c:if>
				</div>
				<!-- About Modal -->

				<dialog id="createAboutModal" class="modal">

				<div class="align-center error-popup">
					<span class="material-icons">error</span>
					<p id="error-text" class="pFont error-text"></p>
					<button class="btnAnimation icon material-icons"
						onclick="closeFormError()">close</button>
				</div>

				<h3 class="modal-heading">About</h3>
				<sf:form id="createAboutForm" class="align-center flex-col form"
					onsubmit="validateCreateAbout(event)" action="update-about"
					method="post" modelAttribute="about">
					<div class="input-group">
						<input required="true" type="text" name="summary" path="summary"
							autocomplete="off" class="input" /> <label class="user-label">Summary</label>
					</div>
					<button class="submit-btn btnAnimation"
						style="background-color: var(- -success);" type="submit">Save</button>
				</sf:form>
				<button id="closeCreateAbout" class="material-icons modal-close">close</button>
				</dialog>

				<!-- Profile Modal -->
				<dialog id="editProfileModal" class="modal">

				<div class="align-center error-popup">
					<span class="material-icons">error</span>
					<p id="error-text" class="pFont error-text"></p>
					<button class="btnAnimation icon material-icons"
						onclick="closeFormError()">close</button>
				</div>

				<h3 class="modal-heading">Edit Profile</h3>
				<sf:form id="editProfileForm" class="align-center flex-col form"
					onsubmit="validateEditProfile(event)" action="update-profile"
					method="post" modelAttribute="user">
					<div class="input-group">
						<input required="true" type="text" name="name" path="name"
							autocomplete="off" id="fullname" class="input"
							onkeyup="validateFullname()" value="${name}" /> <label
							class="user-label">Name</label>
					</div>
					<div class="input-group">
						<label class="select-label">Gender</label> <select id="gender"
							class="input-select" name="gender" path="gender">
							<option selected disabled hidden>Select gender</option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
							<option value="Prefer not to say">Prefer not to say</option>
						</select>
					</div>
					<div class="input-group">
						<input required="true" type="text" name="address" path="address"
							autocomplete="off" class="input" value="${address}" /> <label
							class="user-label">Address</label>
					</div>
					<div class="input-group">
						<input required="true" type="text" name="mobile" path="mobile"
							autocomplete="off" id="mobile" class="input" value="${mobile}" />
						<label class="user-label">Mobile No.</label>

					</div>

					<button class="submit-btn btnAnimation"
						style="background-color: var(- -success);" type="submit">Save</button>
				</sf:form>
				<button id="closeEditProfile" class="material-icons modal-close">close</button>
				</dialog>
			</div>
		</div>
		<!-- 2nd Column -->
		<div class="flex-col gap-20">
			<div class="flex-col dashboard-right-column-content">
				<h3 class="dashboard-heading">My Cart</h3>
				<c:if test="${empty cart}">
					<h4 class="">No products found in cart</h4>
				</c:if>
				<c:if test="${not empty cart}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${cart}" var="p">
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
			<!-- Purchase table -->
			<div class="flex-col dashboard-right-column-content dashboard-panel">
				<table class="dashboard-table">
					<thead class="hFont">
						<tr>
							<th>Purchase No.</th>
							<th>Count</th>
							<th>Product</th>
							<th>User</th>
							<th>Currency</th>
							<th>Amount</th>
							<th>Location</th>
							<th>Code</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody class="pFont">
						<c:if test="${not empty purchases}">
							<c:forEach items="${purchases}" var="p" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${p.count}</td>
									<td>${p.product.name}</td>
									<td>${p.user.name}</td>
									<td>${p.currency}</td>
									<td>${p.amount}</td>
									<td>${p.location}</td>
									<td>${p.code}</td>
									<td>${p.ordStatus}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>