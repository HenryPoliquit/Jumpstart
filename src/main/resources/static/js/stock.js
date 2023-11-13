    // Stock MODAL
    const stockModal = document.querySelector("#editProductModal");
    const openStockModal = document.querySelector("#editProduct");
    const closeStockModal = document.querySelector("#closeEditProduct");
        
    openStockModal.addEventListener("click", () => {
          stockModal.showModal();
        });

    closeStockModal.addEventListener("click", () => {
          stockModal.close();
        });