package com.jump.Jumpstart.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.Cart;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long>{
	Optional<Cart> findById(Long cartId);
	
	List<Cart> findByUser(User user);
	List<Cart> findByProduct(Product product);
}
