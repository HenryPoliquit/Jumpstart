package com.jump.Jumpstart.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.Category;
import com.jump.Jumpstart.Entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>{
	Optional<Product> findById(Long prodId);
	
	List<Product> findByCategory(Category category);
	
	@Query(value = "SELECT p FROM Product p WHERE p.name LIKE '%' || :keyword || '%'")
	public List<Product> searchByName(@Param("keyword") String keyword);
	
	@Query(value = "SELECT p FROM Product p WHERE p.description LIKE '%' || :keyword || '%'")
	public List<Product> searchByDescription(@Param("keyword") String keyword);
}
