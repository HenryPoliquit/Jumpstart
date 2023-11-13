    // About MODAL
    const aboutModal = document.querySelector("#createAboutModal");
    const openAboutModal = document.querySelector("#createAbout");
    const closeAboutModal = document.querySelector("#closeCreateAbout");
        
    openAboutModal.addEventListener("click", () => {
          aboutModal.showModal();
        });

    closeAboutModal.addEventListener("click", () => {
          aboutModal.close();
        });