package com.jump.Jumpstart.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jump.Jumpstart.Entity.About;
import com.jump.Jumpstart.Entity.User;

@Repository
public interface AboutRepository extends JpaRepository<About, Long>{
	Optional<About> findById(Long aId);
	
	List<About> findByUser(User user);
}
