package com.jump.Jumpstart.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Repository.PurchaseRepository;

@Service
@Transactional
public class PurchaseService {
	@Autowired
	PurchaseRepository purchRepo;
	
	public Purchase save(Purchase purchase) {
		
		return purchRepo.save(purchase);
	}
	
	public List<Purchase> getAllPurchases() {
		return purchRepo.findAll(Sort.by(Sort.Direction.DESC, "date"));
	}
	
	public Purchase findPurchase(Long purchId) {
		return purchRepo.getById(purchId);
	}
	
	public void deletePurchase(long purchId) {
		purchRepo.deleteById(purchId);
	}
	public void deleteAllPurchase(List<Purchase> list) {
		purchRepo.deleteAll(list);
	}
	
	public Optional<Purchase> getPurchaseInfo(long purchId){
		
		return purchRepo.findById(purchId);
	}
	public List<Purchase> getMyPurchase(User user) {
		return purchRepo.findByUser(user);
	}
}
