package com.jump.Jumpstart.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>{
	Optional<Product> findById(Long prodId);
	
	List<Product> findByCategory(Category category);
}
