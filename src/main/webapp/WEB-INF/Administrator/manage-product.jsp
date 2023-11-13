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
			<!-- Category table -->
			<div class="flex-col dashboard-right-column-content dashboard-panel">
				<table class="dashboard-table">
					<thead class="hFont">
						<tr>
							<th>Category No.</th>
							<th>Name</th>
							<th>Description</th>
							<th>Price</th>
							<th>Sales</th>
							<th>Stock</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody class="pFont">
						<c:if test="${not empty all_prod}">
							<c:forEach items="${all_prod}" var="p" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${p.name}</td>
									<td>${p.description}</td>
									<td>${p.price}</td>
									<td>${p.sales}</td>
									<td>${p.stock}</td>
									<td>
										<div class="flex center gap-10">
											<!-- Update -->
											<button id="editCategory${status.count}"
												class="btnAnimation material-icons">edit</button>
											<!-- User Modal -->
											<dialog id="editCategoryModal${status.count}" class="modal">

											<div class="align-center error-popup">
												<span class="material-icons">error</span>
												<p id="error-text" class="pFont error-text"></p>
												<button class="btnAnimation icon material-icons"
													onclick="closeFormError()">close</button>
											</div>

											<h3 class="modal-heading">Edit Product</h3>
											<sf:form id="editCategoryForm"
												class="align-center flex-col form"
												action="edit-product?prodId=${p.id}" method="post"
												modelAttribute="prod">
												<div class="input-group">
													<input required="true" type="text" name="name" path="name"
														autocomplete="off" id="fullname" class="input"
														onkeyup="validateFullname()" value="${p.name}" /> <label
														class="user-label">Name</label>
												</div>
												<div class="input-group">
													<input required="true" type="text" name="description"
														path="description" autocomplete="off" class="input" value="${p.description}" /> <label
														class="user-label">Description</label>
												</div>
												<div class="input-group">
													<input required="true" type="text" name="price"
														path="price" autocomplete="off" class="input" value="${p.price}" /> <label
														class="user-label">Price</label>
												</div>
												<div class="input-group">
													<input required="true" type="text" name="sales"
														path="sales" autocomplete="off" class="input" value="${p.sales}"/> <label
														class="user-label">Sales</label>
												</div>
												<div class="input-group">
													<input required="true" type="text" name="stock"
														path="stock" autocomplete="off" class="input" value="${p.stock}"/> <label
														class="user-label">Stock</label>
												</div>
												<button class="submit-btn btnAnimation"
													style="background-color: var(- -success);" type="submit">Save</button>
											</sf:form>
											<button id="closeEditCategory${status.count}"
												class="material-icons modal-close">close</button>
											</dialog>
											<script>
					document.querySelector("#editCategory${status.count}").addEventListener("click", () => {
						document.querySelector("#editCategoryModal${status.count}").showModal();
						});
					
					document.querySelector("#closeEditCategory${status.count}").addEventListener("click", () => {
						document.querySelector("#editCategoryModal${status.count}").close();
						});
					</script>
											<!-- Delete -->
											<button id="delete${status.count}"
												class="btnAnimation material-icons">delete</button>
											<!-- Delete Modal -->
											<dialog id="deleteModal${status.count}" class="modal">
											<h3 class="modal-heading">Delete User</h3>
											<a href="/delete_product?prodId=${p.id}"><button
													class="submit-btn btnAnimation"
													style="background-color: var(- -error);" type="submit">Delete</button></a>
											<button id="closeDelete${status.count}"
												class="material-icons modal-close">close</button>
											</dialog>
											<script>
					document.querySelector("#delete${status.count}").addEventListener("click", () => {
						document.querySelector("#deleteModal${status.count}").showModal();
						});
					
					document.querySelector("#closeDelete${status.count}").addEventListener("click", () => {
						document.querySelector("#deleteModal${status.count}").close();
						});
					</script>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty all_prod}">
							<tr>
								<td colspan="6">No products made yet</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>