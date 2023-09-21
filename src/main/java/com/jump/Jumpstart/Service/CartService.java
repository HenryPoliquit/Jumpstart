package com.jump.Jumpstart.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jump.Jumpstart.Entity.Cart;
import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Repository.CartRepository;

@Service
@Transactional
public class CartService {
	@Autowired
	CartRepository cartRepo;
	
	public Cart save(Cart cart) {
		
		return cartRepo.save(cart);
	}
	
	public List<Cart> getAllCarts() {
		return cartRepo.findAll(Sort.by(Sort.Direction.DESC, "date"));
	}
	
	public Cart findCart(Long cartId) {
		return cartRepo.getById(cartId);
	}
	
	public void deleteCart(long cartId) {
		cartRepo.deleteById(cartId);
	}
	public Optional<Cart> getCartInfo(long cartId){
		
		return cartRepo.findById(cartId);
	}
	
	public List<Cart> findByUser(User user) {
		return cartRepo.findByUser(user);
	}
	
	public List<Cart> findByProduct(Product product) {
		return cartRepo.findByProduct(product);
	}
}
