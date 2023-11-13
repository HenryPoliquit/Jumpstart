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
					<div class="" style="justify-content: center;">
						<h3>
							<a href="profile">${name}</a>
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
				<h3 class="dashboard-heading">Categories</h3>
				<c:if test="${empty allCategory}">
					<h4 class="">No categories found</h4>
				</c:if>
				<c:if test="${not empty allCategory}">
					<div class="flex-wrap card-container justify-evenly">
						<c:forEach items="${allCategory}" var="c">
							<c:set var="cId" value="${c.id}"></c:set>
							<c:set var="cName" value="${c.name}"></c:set>
							<c:set var="cDesc" value="${c.description}"></c:set>
							<a href="category_details?catId=${cId}" class="card pFont center"><div>
								<h4 class="card-heading text-center">${cName}</h4>							
							</div></a>
						</c:forEach>
					</div>
				</c:if>
				<sec:authorize access="hasRole('Administrator')">
				<button id="createCategory" class="share-btn">Add Category</button>
				</sec:authorize>					
			</div>
			<sec:authorize access="hasRole('Administrator')">			
						<!-- Category Modal -->

			<dialog id="createCategoryModal" class="modal">

			<div class="align-center error-popup">
				<span class="material-icons">error</span>
				<p id="error-text" class="pFont error-text"></p>
				<button class="btnAnimation icon material-icons"
					onclick="closeFormError()">close</button>
			</div>

			<h3 class="modal-heading">Category</h3>
			<sf:form id="createCategoryForm" class="align-center flex-col form"
				onsubmit="validateCreateCategory(event)" action="create_category"
				method="post" modelAttribute="category">
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

				<button class="submit-btn btnAnimation"
					style="background-color: var(--success);" type="submit">Save</button>
			</sf:form> 
				<button id="closeCreateCategory" class="material-icons modal-close">close</button>
			</dialog>
					<script>
					document.querySelector("#createCategory").addEventListener("click", () => {
						document.querySelector("#createCategoryModal").showModal();
						});
					
					document.querySelector("#closeCreateCategory").addEventListener("click", () => {
						document.querySelector("#createCategoryModal").close();
						});
					</script>
			</sec:authorize>				
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>