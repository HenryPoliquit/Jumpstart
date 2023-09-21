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

import com.jump.Jumpstart.Entity.Cart;
import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CartService;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class CartController {

	@Autowired
	UserService userService;

	@Autowired
	ProductService prodService;

	@Autowired
	CartService cartService;

	@Autowired
	CategoryService catService;

	@GetMapping("cart")
	public String cart(Model model, @ModelAttribute("cart") Cart cart, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);

		List<User> user = new ArrayList<User>();
		user.add(userdata);

		List<Cart> allCart = cartService.getAllCarts();
		List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());

		model.addAttribute("user", user);
		model.addAttribute("recent", recent);
		model.addAttribute("allCart", allCart);
		return "Users/cart";
	}

	@PostMapping("add_to_cart")
	public void addToCart(Principal principal, @RequestParam long prodId) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<Cart> allCart = cartService.findByUser(userdata);
		
		Cart newCart = new Cart();
		Product addedProduct = prodService.findProduct(prodId);
		for (Cart cartItem :allCart) {
			if (cartItem.getProduct() == addedProduct) {
				cartItem.setCount(cartItem.getCount() + 1);
				System.out.println(cartItem.getCount());
				cartService.save(cartItem);
				return;
			}
		}
		newCart.setCount(1);
		newCart.setProduct(addedProduct);
		newCart.setUser(userdata);
		
		cartService.save(newCart);
		return;
	}
}
