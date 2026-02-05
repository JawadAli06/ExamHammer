package com.Grownited.entity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDetailRepository extends JpaRepository<UserEntity, Integer> {

    // Find user by email
    UserEntity findByEmail(String email);

    // Check if email already exists
    boolean existsByEmail(String email);
}
