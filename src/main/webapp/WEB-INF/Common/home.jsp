<jsp:include page="../header.jsp">
	<jsp:param value="Home" name="HTMLtitle" />
</jsp:include>

<main class="bg1 home">
	<section id="landingSection" class="align-start justify-evenly">

		<a href="login" id="logoutPopup"
			class="align-center login-popup btnAnimation text-deco-none text-align-center">
			<span class="material-icons">login</span>
			<p id="logoutText" class="pFont login-text">${success_logout}</p>
		</a>

		<div id="homeCard" class="flex-col justify-center">

			<h2 class="hFont">Welcome to Jumpstart</h2>
			<p class="pFont">Whether you're looking for clothing, electronics, home goods, or anything in between, you'll find it at Jumpstart.</p>

			<button class="get-started hFont"
				onclick="window.location.href='register';">
				<span class="circle" aria-hidden="true"> <span
					class="icon arrow"></span>
				</span> <span class="button-text">Shop Now!</span>
			</button>

		</div>

		<div id="blobContainer">
			<img id="blob" src="images/blob.svg" alt="Svg graphic" width="500" />
			<img id="motorcycle" src="images/Motorcycle.svg"
				alt="Motorcycle graphic" width="500" />
		</div>
	</section>
</main>

<jsp:include page="../footer.jsp"></jsp:include>