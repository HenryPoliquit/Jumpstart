    // Search MODAL
    const searchModal = document.querySelector("#createSearchModal");
    const openSearchModal = document.querySelector("#createSearch");
    const closeSearchModal = document.querySelector("#closeCreateSearch");
        
    openSearchModal.addEventListener("click", () => {
          searchModal.showModal();
        });

    closeSearchModal.addEventListener("click", () => {
          searchModal.close();
        });