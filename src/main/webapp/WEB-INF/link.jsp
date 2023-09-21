<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Admin Dashboard Links -->
<sec:authorize access="hasRole('Administrator')">
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Products</h3>
		<a><button class="dash-btn">Manage Categories</button></a> <a
			href="all_threads"><button class="dash-btn">Manage
				Products</button></a> <a href="all_posts"><button class="dash-btn">Manage
				Purchases</button></a>
	</div>
	<div class="flex-col center dashboard-left-column-links">
		<h3 class="dashboard-heading">Users</h3>
		<a><button class="dash-btn">User Management</button></a> <a
			href="all_threads"><button class="dash-btn">Cart
				Management</button></a> <a href="all_posts"><button class="dash-btn">Search</button></a>
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
		<a><button class="dash-btn">Search</button></a> <a href="all_threads"><button
				class="dash-btn">Purchase History</button></a>
	</div>
</sec:authorize>