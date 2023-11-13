package com.jump.Jumpstart.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Repository.CategoryRepository;

@Service
@Transactional
public class CategoryService {
	@Autowired
	CategoryRepository catRepo;
	
	public Category save(Category category) {
		
		return catRepo.save(category);
	}
	
	public List<Category> getAllCategorys() {
		return catRepo.findAll(Sort.by(Sort.Direction.ASC, "name"));
	}
	
	public Category findCategory(Long catId) {
		return catRepo.getById(catId);
	}
	
	public void deleteCategory(long catId) {
		catRepo.deleteById(catId);
	}
	public Optional<Category> getCategoryInfo(long catId){
		
		return catRepo.findById(catId);
	}
	public List<Category> searchByName(String keyword) {
		return catRepo.searchByName(keyword);
	}
}
