package com.jump.Jumpstart.Controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.EmailSenderService;
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
	
	@Autowired
	CategoryService catService;
	
	@Autowired
	EmailSenderService emailSender;
	
	@GetMapping("purchase")
	public String purchaseProduct(@ModelAttribute("purchase") Purchase purchase, @RequestParam long prodId, Model model) {
		
		Product product_info = prodService.findProduct(prodId);
		
		List<Product> product = new ArrayList<Product>();
		product.add(product_info);
		
		model.addAttribute("product", product);
		
		return "Users/purchase";
	}	
	
	@PostMapping("purchase_product")
	public String placePurchase(@ModelAttribute("purchase") Purchase purchase, Model model, Principal principal, @RequestParam long prodId, RedirectAttributes redir) throws UnsupportedEncodingException, MessagingException  {

		String username = principal.getName();

		User user = userService.findLoginUser(username);
		
		String code = generateCode();
		
		Product product = prodService.findProduct(prodId);
		
		purchase.setDescription("Purchase of product, " + product.getName());
		purchase.setAmount(purchase.getCount()*product.getPrice());
		purchase.setIntent("sales");
		purchase.setCode(code);
		purchase.setProduct(product);
		purchase.setUser(user);

		purchService.save(purchase);
		
		product.setSales(product.getSales() + purchase.getCount());
		product.setStock(product.getStock() - purchase.getCount());
		
		prodService.save(product);
		
		String toEmail = user.getEmail();
		String subject = "Thank you for your purchase AT Jumpstart";
		String body = "Dear " + user.getName() + ",\r\n" + "\r\n"
				+ "We are delighted to inform you that your order has been successfully processed.\r\n"
				+ "\r\n"
				+ "Your 6-digit code is" + purchase.getCode() +". Please keep it safe and use it to claim your order at " + purchase.getLocation() + "branch.\r\n"
				+ "\r\n"
				+ "We appreciate your trust in Jumpstart, the best ecommerce platform for your online business. We hope you enjoy our products and services, and we look forward to serving you again in the future.\r\n"
				+ "\r\n"
				+ "If you have any questions or feedback, please do not hesitate to contact us at support@jumpstart.com. We are always happy to hear from you.\r\n"
				+ "\r\n" + "Sincerely,\r\n" + "\r\n" + "Jumpstart Team";

		emailSender.sendEmail(toEmail, subject, body);
		
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
	
	@GetMapping("purchase-history")
	public ModelAndView purchaseHistory(Principal principal, Model model) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		model.addAttribute("recent", recent);
		model.addAttribute("user", user);
		
		List<Purchase> purchases = purchService.getMyPurchase(userdata);
		return new ModelAndView ("Users/purchase-history", "purchases", purchases);
	}
}
