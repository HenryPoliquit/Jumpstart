package com.jump.Jumpstart.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class SearchController {
	@Autowired
	ProductService productService;
	
	@Autowired
	CategoryService catService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/search-product")
	public ModelAndView searchResultsPage(@RequestParam String keyword, Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		List<Product> searchProduct = productService.searchByName(keyword);
		System.out.println(searchProduct);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("recent", recent);
		model.addAttribute("user", user);
		return new ModelAndView("Search/search-result", "searchProduct", searchProduct);
	}
	
	@GetMapping("/search-product_by-product")
	public ModelAndView searchProductPage(@RequestParam String keyword, Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		List<Product> searchProduct = productService.searchByName(keyword);
		System.out.println(searchProduct);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("recent", recent);
		model.addAttribute("user", user);
		return new ModelAndView("Search/search-result", "searchProduct", searchProduct);
	}
	
	@GetMapping("/search-product_by-description")
	public ModelAndView searchProductPricePage(@RequestParam String keyword, Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
		
		List<Product> searchProduct = productService.searchByDesc(keyword);
		System.out.println(searchProduct);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("recent", recent);
		model.addAttribute("user", user);
		return new ModelAndView("Search/search-result", "searchProduct", searchProduct);
	}
}
