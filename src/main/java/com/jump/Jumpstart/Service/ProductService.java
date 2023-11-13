package com.jump.Jumpstart.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Repository.ProductRepository;

@Service
@Transactional
public class ProductService {
	@Autowired
	ProductRepository prodRepo;
	
	public Product save(Product product) {
		
		return prodRepo.save(product);
	}
	
	public List<Product> getAllProducts() {
		return prodRepo.findAll(Sort.by(Sort.Direction.DESC, "sales"));
	}
	
	public Product findProduct(Long prodId) {
		return prodRepo.getById(prodId);
	}
	
	public void deleteProduct(long prodId) {
		prodRepo.deleteById(prodId);
	}
	public void deleteAllProduct(List<Product> list) {
		prodRepo.deleteAll(list);
	}
	public Optional<Product> getProductInfo(long prodId){
		
		return prodRepo.findById(prodId);
	}
	
	public List<Product> getSpecificProduct(Category category) {
		return prodRepo.findByCategory(category);
	}
	
	public List<Product> searchByName(String keyword) {
		return prodRepo.searchByName(keyword);
	}
	
	public List<Product> searchByDesc(String keyword) {
		return prodRepo.searchByDescription(keyword);
	}
}
