package com.jump.Jumpstart.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long>{
	Optional<Category> findById(Long catId);
	
	@Query(value = "SELECT p FROM Category p WHERE p.name LIKE '%' || :keyword || '%'")
	public List<Category> searchByName(@Param("keyword") String keyword);
}
