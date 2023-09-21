package com.jump.Jumpstart.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Role;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class DashboardController {

	@Autowired
	UserService userService;
	
	@Autowired
	ProductService prodService;
	
	@Autowired
	CategoryService catService;

	@GetMapping("dashboard")
	public String dashboard(Principal principal, Model model) {
		String username = principal.getName();

		User user = userService.findLoginUser(username);

		String[] role = user.getRoles().stream().map(Role::getName).toArray(String[]::new);

		String userRole = role[0];

		String[] roleNames = userService.getAllRoles().stream().map(Role::getName).toArray(String[]::new);

		for (String roleName : roleNames) {
			if (roleName == userRole && userRole.equalsIgnoreCase("Administrator")) {
				adminDashboard(model, principal);
				return userRole + "/dashboard";
			}
			if (roleName == userRole && userRole.equalsIgnoreCase("Users")) {
				usersDashboard(model, principal);
				return userRole + "/dashboard";
			}
			if (roleName == userRole && userRole.equalsIgnoreCase("Sales")) {
				salesDashboard(model, principal);
				return userRole + "/dashboard";
			}
		}
		return "redirect:accessdenied";
	}

	public void adminDashboard(Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		List<Product> product = prodService.getAllProducts();
		List<Product> popular = product.subList(Math.max(product.size() - 12, 0), product.size());
		
		model.addAttribute("user", user);
		model.addAttribute("recent", recent);
		model.addAttribute("popular", popular);
		
		System.out.println("Logged in as Administrator");
	}

	public void usersDashboard(Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		List<Product> product = prodService.getAllProducts();
		List<Product> popular = product.subList(Math.max(product.size() - 12, 0), product.size());
		
		model.addAttribute("user", user);
		model.addAttribute("recent", recent);
		model.addAttribute("popular", popular);
		model.addAttribute("user", user);
		
		System.out.println("Logged in as User");
	}
	
	public void salesDashboard(Model model, Principal principal) {

	}
}