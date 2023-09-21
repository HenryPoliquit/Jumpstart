<jsp:include page="../header.jsp">
	<jsp:param value="Profile" name="HTMLtitle" />
</jsp:include>

<main class="bg2 align-center flex-col">
	<div class="flex dashboard">
		<!-- 1st Column -->
		<div>
			<div class="flex-col gap-15 dashboard-left">
				<div class="justify-center center dashboard-left-column-profile">
					<div>
						<img src="images/Profile-male.svg" alt="profile picture"
							width="75" height="75" />
					</div>
					<div class="" style="justify-content: center;">
						<h3>
							<a href="profile">Paul Henry Poliquit</a>
						</h3>
						<p>Negros Oriental, Philippines</p>
					</div>
				</div>
				<!-- Links -->
				<div class="flex-col dashboard-left-column-links">
					<h3 class="dashboard-heading">About</h3>
					<p class="pFont">I am a passionate and motivated professional
						with over five years of experience in the field of web
						development.</p>
					<h3 class="dashboard-heading">Contact</h3>
					<p class="pFont">Email: paulpoliquit123@gmail.com</p>
					<p class="pFont">Mobile: 09158171758</p>
				</div>
			</div>
		</div>
		<!-- 2nd Column -->
		<div class="flex-col gap-20">
			<div class="flex-col dashboard-right-column-content">
				<h3 class="dashboard-heading">Cart</h3>
				<div class="flex-wrap card-container justify-evenly">
					<div class="card pFont">
						<img class="card-image" src="https://placehold.co/600x400.png"
							alt="" />
						<h4 class="card-heading">Sun Screen</h4>
						<h4 class="card-heading">$100</h4>
						<p class="card-desc">1200 Sold</p>
						<a class="card-link">View</a>
					</div>
					<div class="card pFont">
						<img class="card-image" src="https://placehold.co/600x400.png"
							alt="" />
						<h4 class="card-heading">Sun Screen</h4>
						<h4 class="card-heading">$100</h4>
						<p class="card-desc">1200 Sold</p>
						<a class="card-link">View</a>
					</div>
					<div class="card pFont">
						<img class="card-image" src="https://placehold.co/600x400.png"
							alt="" />
						<h4 class="card-heading">Sun Screen</h4>
						<h4 class="card-heading">$100</h4>
						<p class="card-desc">1200 Sold</p>
						<a class="card-link">View</a>
					</div>
					<div class="card pFont">
						<img class="card-image" src="https://placehold.co/600x400.png"
							alt="" />
						<h4 class="card-heading">Sun Screen</h4>
						<h4 class="card-heading">$100</h4>
						<p class="card-desc">1200 Sold</p>
						<a class="card-link">View</a>
					</div>
					<div class="card pFont">
						<img class="card-image" src="https://placehold.co/600x400.png"
							alt="" />
						<h4 class="card-heading">Sun Screen</h4>
						<h4 class="card-heading">$100</h4>
						<p class="card-desc">1200 Sold</p>
						<a class="card-link">View</a>
					</div>
				</div>
			</div>
			<div class="flex-col dashboard-right-column-content dashboard-panel center">
				<h3 class="dashboard-heading">Purchases</h3>
				<div class="flex-wrap card-container justify-evenly">
					<table class="dashboard-table">
						<thead class="hFont">
							<tr>
								<th>Purchase No.</th>
								<th>Payment Method</th>
								<th>Currency</th>
								<th>Amount</th>
								<th>Intent</th>
								<th>Payment Description</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody class="pFont">
							<tr>
								<td>1</td>
								<td>PayPal</td>
								<td>USD</td>
								<td>100</td>
								<td>Sales</td>
								<td>Payment</td>
								<td>September 6, 2023</td>
							</tr>
							<tr>
								<td>2</td>
								<td>PayPal</td>
								<td>USD</td>
								<td>100</td>
								<td>Sales</td>
								<td>Payment</td>
								<td>September 6, 2023</td>
							</tr>
							<tr>
								<td>3</td>
								<td>PayPal</td>
								<td>USD</td>
								<td>100</td>
								<td>Sales</td>
								<td>Payment</td>
								<td>September 6, 2023</td>
							</tr>
							<tr>
								<td>4</td>
								<td>PayPal</td>
								<td>USD</td>
								<td>100</td>
								<td>Sales</td>
								<td>Payment</td>
								<td>September 6, 2023</td>
							</tr>
							<tr>
								<td>5</td>
								<td>PayPal</td>
								<td>USD</td>
								<td>100</td>
								<td>Sales</td>
								<td>Payment</td>
								<td>September 6, 2023</td>
							</tr>							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>

<jsp:include page="../footer.jsp"></jsp:include>