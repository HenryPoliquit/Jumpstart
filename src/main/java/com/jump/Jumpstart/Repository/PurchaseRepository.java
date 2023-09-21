package com.jump.Jumpstart.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Long>{
	List<Purchase> findByUser(User user);
	List<Purchase> findByProduct(Product product);
}
