package com.jump.Jumpstart.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@PostMapping("purchase_product")
	public String placePurchase(@ModelAttribute("purchase") Purchase purchase, Model model, Principal principal, @RequestParam long prodId, RedirectAttributes redir) {

		String username = principal.getName();

		User user = userService.findLoginUser(username);
		
		String code = generateCode();
		
		Product product = prodService.findProduct(prodId);
		
		purchase.setDescription("Purchase of product, " + product.getName());
		purchase.setIntent("sales");
		purchase.setCode(code);
		purchase.setProduct(product);
		purchase.setUser(user);

		purchService.save(purchase);
		
		product.setSales(product.getSales() + purchase.getCount());
		product.setStock(product.getStock() - purchase.getCount());
		
		prodService.save(product);
		
		redir.addFlashAttribute("code", code);
		
		return "redirect:purchase-confirmation";
	}
	
	public String generateCode() {
		Random rnd = new Random();
		int number = rnd.nextInt(999999);
		String code = String.format("%06d", number);
		return code;
	}
	
	@GetMapping("purchase-confirmation")
	public String orderConfirmation(Model model, Principal principal) {
		return "Users/confirmation";
	}	
}
