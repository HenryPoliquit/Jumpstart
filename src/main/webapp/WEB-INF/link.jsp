<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!-- Admin Dashboard Links -->
<sec:authorize access="hasRole('Administrator')">
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Products</h3>
		<a href="manage_category"><button class="dash-btn">Manage
				Categories</button></a> <a href="manage_product"><button class="dash-btn">Manage
				Products</button></a> <a href="manage_purchase"><button class="dash-btn">Manage
				Purchases</button></a>
	</div>
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Users</h3>
		<a href="manage_users"><button class="dash-btn">User
				Management</button></a> <a href="category"><button class="dash-btn">All
				Categories</button></a> <a><button id="createSearch" class="dash-btn">Search</button></a>
		<a href="search"><button class="dash-btn">Bulk Mail</button></a>
	</div>
</sec:authorize>

<!-- User Dashboard Links -->
<sec:authorize access="hasRole('Users')">
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Categories</h3>
		<c:forEach items="${recent}" var="c">
			<c:set var="cId" value="${c.id}"></c:set>
			<c:set var="cName" value="${c.name}"></c:set>
			<a href="category_details?catId=${cId}"><button class="dash-btn">${cName}</button></a>
		</c:forEach>
		<a href="category"><button class="dash-btn">More
				Categories</button></a>
	</div>
	<div class="flex-col center dashboard-left-column-links">
		<a><button id="createSearch" class="dash-btn">Search</button></a><a
			href="purchase-history"><button class="dash-btn">Purchase
				History</button></a>
	</div>
</sec:authorize>
<!-- Search Modal -->

<dialog id="createSearchModal" class="modal">

<div class="align-center error-popup">
	<span class="material-icons">error</span>
	<p id="error-text" class="pFont error-text"></p>
	<button class="btnAnimation icon material-icons"
		onclick="closeFormError()">close</button>
</div>

<h3 class="modal-heading">Search</h3>
<sf:form class="align-center flex-col form" action="search-product"
	method="get">
	<div class="input-group">
		<input required="true" type="text" name="keyword" autocomplete="off"
			class="input" /> <label class="user-label">Search</label>
	</div>
	<button class="submit-btn btnAnimation"
		style="background-color: var(- -success);" type="submit">Search
		Product</button>
</sf:form>
<button id="closeCreateSearch" class="material-icons modal-close">close</button>
</dialog>

<!-- Sales Dashboard Links -->
<sec:authorize access="hasRole('Sales')">
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Categories</h3>
		<c:forEach items="${recent}" var="c">
			<c:set var="cId" value="${c.id}"></c:set>
			<c:set var="cName" value="${c.name}"></c:set>
			<a href="category_details?catId=${cId}"><button class="dash-btn">${cName}</button></a>
		</c:forEach>
		<a href="category"><button class="dash-btn">More
				Categories</button></a>
	</div>
	<div class="flex-col center dashboard-left-column-links">
		<a><button id="createSearch" class="dash-btn">Search</button></a><a
			href="all_products"><button class="dash-btn">Product
				Management</button></a>
	</div>
</sec:authorize>