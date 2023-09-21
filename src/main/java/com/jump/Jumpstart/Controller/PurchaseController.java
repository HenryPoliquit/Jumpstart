package com.jump.Jumpstart.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.PurchaseService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class PurchaseController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	ProductService prodService;
	
	@Autowired
	PurchaseService purchService;
	
	@GetMapping("purchase")
	public String purchaseProduct(@ModelAttribute("purchase") Purchase purchase, @RequestParam long prodId, Model model) {
		
		Product product_info = prodService.findProduct(prodId);
		
		List<Product> product = new ArrayList<Product>();
		product.add(product_info);
		
		model.addAttribute("product", product);
		
		return "Users/purchase";
	}	
}
