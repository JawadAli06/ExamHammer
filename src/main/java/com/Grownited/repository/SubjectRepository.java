package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.UserEntity;

import java.util.List;

@Repository
public interface SubjectRepository extends JpaRepository<SubjectEntity, Integer> {

    List<SubjectEntity> findByCreatedBy(UserEntity createdBy);

    long countByCreatedBy(UserEntity createdBy);

    List<SubjectEntity> findByActiveTrue();
    
    Long countByActiveTrue();
    
    
}