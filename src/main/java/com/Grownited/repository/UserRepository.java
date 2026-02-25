package com.Grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);

}

















/*package com.Grownited.repository;

import java.awt.List;
import java.util.Optional;


import org.springframework.data.jpa.repository.JpaRepository;
import com.Grownited.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

   UserEntity findByEmail(String email);

    boolean existsByEmail(String email);
	
	//findByXXXX(xxx);
	
		//select * from users where email = :email
		Optional<UserEntity>  findByEmail(String email);
		
		java.util.List<UserEntity> findByRole(String role); // 
		
	

}*/
