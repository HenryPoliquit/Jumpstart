package com.jump.Jumpstart.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class SalesController {
	@Autowired
	UserService userService;

	@Autowired
	ProductService prodService;

	@Autowired
	CategoryService catService;

	@PostMapping("update_stock")
	public String updateStock(@ModelAttribute("stock") Product product, RedirectAttributes redir,
			@RequestParam long prodId) {

		Product stock = prodService.findProduct(prodId);

		stock.setStock(stock.getStock() + product.getStock());

		prodService.save(stock);

		String success_msg = "Product has been updated";

		redir.addFlashAttribute("success_msg", success_msg);

		return "redirect:product_details?prodId=" + prodId;
	}
}
