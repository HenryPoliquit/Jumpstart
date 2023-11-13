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
						<c:if test="${not empty all_purch}">
							<c:forEach items="${all_purch}" var="p" varStatus="status">
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
									<td>
										<div class="flex center gap-10">
											<!-- Update -->
											<button id="editPurchase${status.count}"
												class="btnAnimation material-icons">edit</button>
											<!-- User Modal -->
											<dialog id="editPurchaseModal${status.count}" class="modal">

											<div class="align-center error-popup">
												<span class="material-icons">error</span>
												<p id="error-text" class="pFont error-text"></p>
												<button class="btnAnimation icon material-icons"
													onclick="closeFormError()">close</button>
											</div>

											<h3 class="modal-heading">Edit Purchase</h3>
											<sf:form id="editPurchaseForm"
												class="align-center flex-col form"
												action="edit-purchase?purchId=${p.id}" method="post"
												modelAttribute="purch">
												<div class="input-group">
													<input required="true" type="text" name="code" path="code"
														autocomplete="off" id="fullname" class="input"
														onkeyup="validateFullname()" value="${p.code}" /> <label
														class="user-label">Code</label>
												</div>
												<div class="input-group">
													<input required="true" type="text" name="location"
														path="location" autocomplete="off" class="input"
														value="${p.location}" /> <label class="user-label">Location</label>
												</div>
												<div class="input-group">
													<label class="select-label">Order Status</label> <select
														id="ordStatus" class="input-select" name="ordStatus"
														path="ordStatus">
														<option selected disabled hidden>Select order status</option>
														<option value="true">Retrieved</option>
														<option value="false">Pending</option>
													</select>
												</div>
												<button class="submit-btn btnAnimation"
													style="background-color: var(- -success);" type="submit">Save</button>
											</sf:form>
											<button id="closeEditPurchase${status.count}"
												class="material-icons modal-close">close</button>
											</dialog>
											<script>
					document.querySelector("#editPurchase${status.count}").addEventListener("click", () => {
						document.querySelector("#editPurchaseModal${status.count}").showModal();
						});
					
					document.querySelector("#closeEditPurchase${status.count}").addEventListener("click", () => {
						document.querySelector("#editPurchaseModal${status.count}").close();
						});
					</script>
											<!-- Delete -->
											<button id="delete${status.count}"
												class="btnAnimation material-icons">delete</button>
											<!-- Delete Modal -->
											<dialog id="deleteModal${status.count}" class="modal">
											<h3 class="modal-heading">Delete User</h3>
											<a href="/delete_purchase?purchId=${p.id}"><button
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
						<c:if test="${empty all_purch}">
							<tr>
								<td colspan="6">No purchases made yet</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>