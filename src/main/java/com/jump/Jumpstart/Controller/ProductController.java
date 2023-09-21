package com.jump.Jumpstart.Controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.CategoryService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.UserService;

@Controller
public class ProductController {

	@Autowired
	UserService userService;
	
	@Autowired
	ProductService prodService;
	
	@Autowired
	CategoryService catService;
	
	@GetMapping("product")
	public String thread(Model model, @ModelAttribute("product") Product product, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		List<Product> allProduct = prodService.getAllProducts();
		
    	List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
    	
    	model.addAttribute("category", category);
		model.addAttribute("recent", recent);
		model.addAttribute("user", user);
		model.addAttribute("allProduct", allProduct);
		return "Common/product";
	}
	
	@PostMapping("create_product")	
	public String createProduct(@ModelAttribute("product") Product product, Principal principal, @RequestParam("fileImage") MultipartFile multipartFile, @RequestParam("category") int category) throws IOException {
		String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());

		product.setPhotos(fileName);

		Product savedProduct = prodService.save(product);

		String uploadDir = "./src/main/resources/static/images/product-photo/" + savedProduct.getId();

		Path uploadPath = Paths.get(uploadDir);

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}

		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			System.out.println(filePath.toFile().getAbsolutePath());
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			throw new IOException("Could not save uploaded file: " + fileName);

		}

		product.setPhotoImagePath("/images/product-photo/" + savedProduct.getId() + "/" + savedProduct.getPhotos());
		
		long catId = category;
		product.setSales(0);
		product.setStock(0);
		product.setCategory(catService.findCategory(catId));
		
		prodService.save(product);
		return "redirect:dashboard";
	}
	
	@GetMapping("product_details")
	public String viewProductDetail(@RequestParam long prodId, Model model, Principal principal) {
		String username = principal.getName();

		User userdata = userService.findLoginUser(username);
		
		List<User> user = new ArrayList<User>();
		user.add(userdata);
		
		Product product_info = prodService.findProduct(prodId);
		
		List<Product> product = new ArrayList<Product>();
		product.add(product_info);
		
		List<Product> related = prodService.getSpecificProduct(product_info.getCategory());
		
    	List<Category> category = catService.getAllCategorys();
		List<Category> recent = category.subList(Math.max(category.size() - 5, 0), category.size());
    	
		model.addAttribute("recent", recent);
		model.addAttribute("related", related);
		model.addAttribute("user", user);
		model.addAttribute("product", product);
		
		return "Common/product-detail";
	}
	
}
