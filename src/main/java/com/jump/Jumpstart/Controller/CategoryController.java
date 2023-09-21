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

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class CategoryController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	CategoryService catService;
	
	@Autowired
	ProductService prodService;
	
	@GetMapping("category")
	public String thread(Model model, @ModelAttribute("category") Category category, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> allCategory = catService.getAllCategorys();
		List<Category> recent = allCategory.subList(Math.max(allCategory.size() - 5, 0), allCategory.size());
		
		model.addAttribute("user", user);
		model.addAttribute("recent", recent);
		model.addAttribute("allCategory", allCategory);
		return "Common/category";
	}
	
	@PostMapping("create_category")
	public String createThread(@ModelAttribute("category") Category category) {
		
		catService.save(category);
		
		return "redirect:category";
	}
	
	@GetMapping("category_details")
	public String viewCategoryDetail(@RequestParam long catId, Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		Category category_info = catService.findCategory(catId);
		
		List<Category> category = new ArrayList<Category>();
		category.add(category_info);
		
    	List<Category> AllCategory = catService.getAllCategorys();
		List<Category> recent = AllCategory.subList(Math.max(AllCategory.size() - 5, 0), AllCategory.size());
		
		List<Product> product = prodService.getSpecificProduct(catService.findCategory(catId));
		
		model.addAttribute("recent", recent);
		model.addAttribute("product", product);
		model.addAttribute("user", user);
		model.addAttribute("category", category);
		
		return "Common/category-detail";
	}
}
