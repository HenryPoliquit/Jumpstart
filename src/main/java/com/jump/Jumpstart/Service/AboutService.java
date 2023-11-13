package com.jump.Jumpstart.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jump.Jumpstart.Entity.About;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Repository.AboutRepository;

@Service
@Transactional
public class AboutService {
	@Autowired
	AboutRepository AboutRepo;
	
	public About save(About about) {
		
		return AboutRepo.save(about);
	}
	
	public List<About> getAllAbouts() {
		return AboutRepo.findAll(Sort.by(Sort.Direction.DESC, "date"));
	}
	
	public About findAbout(Long aId) {
		return AboutRepo.getById(aId);
	}
	
	public void deleteAbout(long aId) {
		AboutRepo.deleteById(aId);
	}
	public Optional<About> getAboutInfo(long aId){
		
		return AboutRepo.findById(aId);
	}
	
	public List<About>findByUser(User user) {
		return AboutRepo.findByUser(user);
	}
}
