package com.jump.Jumpstart.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.PurchaseService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class AdminController {
	@Autowired
	UserService userService;

	@Autowired
	ProductService prodService;

	@Autowired
	CategoryService catService;
	
	@Autowired
	PurchaseService purchService;

	@GetMapping("manage_users")
	public ModelAndView manageUsers(Principal principal, Model model) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);

		model.addAttribute("user", user);

		List<User> all_user = userService.showAllUser();
		return new ModelAndView("Administrator/manage-user", "all_user", all_user);
	}

	@PostMapping("edit-profile")
	public String editProfile(@ModelAttribute("edit") User user, @RequestParam long uId) {

		User user_info = userService.findSpecificUser(uId);

		System.out.print(user_info);

		user_info.setName(user.getName());
		user_info.setGender(user.getGender());
		user_info.setEnabled(user.isEnabled());
		user_info.setAddress(user.getAddress());
		user_info.setMobile(user.getMobile());

		userService.editUser(user_info);

		return "redirect:manage_users";
	}

	@GetMapping("delete_user")
	public String deleteUser(@RequestParam long uid) {

		userService.deleteUser(uid);
		purchService.deleteAllPurchase(purchService.getMyPurchase(userService.findSpecificUser(uid)));

		return "redirect:manage_users";
	}
	
	@GetMapping("manage_category")
	public ModelAndView manageCategory(Principal principal, Model model) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);

		model.addAttribute("user", user);

		List<Category> all_category = catService.getAllCategorys();
		return new ModelAndView("Administrator/manage-category", "all_cat", all_category);
	}

	@PostMapping("edit-category")
	public String editCategory(@ModelAttribute("cat") Category cat, @RequestParam long catId) {

		Category category = catService.findCategory(catId);

		System.out.print(category);

		category.setName(cat.getName());
		category.setDescription(cat.getDescription());

		catService.save(category);

		return "redirect:manage_category";
	}
	
	@GetMapping("delete_category")
	public String deleteCategory(@RequestParam long catId) {

		catService.deleteCategory(catId);
		prodService.deleteAllProduct(prodService.getSpecificProduct(catService.findCategory(catId)));
		return "redirect:manage_users";
	}
	
	@GetMapping("manage_product")
	public ModelAndView manageProduct(Principal principal, Model model) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);

		model.addAttribute("user", user);

		List<Product> all_product = prodService.getAllProducts();
		return new ModelAndView("Administrator/manage-product", "all_prod", all_product);
	}
	
	@PostMapping("edit-product")
	public String editProduct(@ModelAttribute("prod") Product prod, @RequestParam long prodId) {

		Product product = prodService.findProduct(prodId);

		System.out.print(product);

		product.setName(prod.getName());
		product.setDescription(prod.getDescription());
		product.setPrice(prod.getPrice());
		product.setSales(prod.getSales());
		product.setStock(prod.getStock());

		prodService.save(product);

		return "redirect:manage_product";
	}
	
	@GetMapping("delete_product")
	public String deleteProduct(@RequestParam long prodId) {

		prodService.deleteProduct(prodId);
		return "redirect:manage_users";
	}
	
	@GetMapping("manage_purchase")
	public ModelAndView managePurchase(Principal principal, Model model) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);

		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		model.addAttribute("user", user);
		model.addAttribute("recent", recent);
		
		List<Purchase> all_purchase = purchService.getAllPurchases();
		return new ModelAndView("Administrator/manage-purchase", "all_purch", all_purchase);
	}

	@PostMapping("edit-purchase")
	public String editPurchase(@ModelAttribute("purch") Purchase purch, @RequestParam long purchId) {

		Purchase purchase = purchService.findPurchase(purchId);

		System.out.print(purchase);

		purchase.setCode(purch.getCode());
		purchase.setLocation(purch.getLocation());
		purchase.setOrdStatus(purch.isOrdStatus());

		purchService.save(purchase);

		return "redirect:manage_purchase";
	}
	
	@GetMapping("delete_purchase")
	public String deletePurchase(@RequestParam long purchId) {
		
		purchService.deletePurchase(purchId);

		return "redirect:manage_purchase";
	}
}
