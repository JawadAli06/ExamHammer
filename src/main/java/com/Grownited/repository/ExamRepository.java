package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.UserEntity;

@Repository
public interface ExamRepository extends JpaRepository<ExamEntity, Integer> {

    List<ExamEntity> findByCreatedBy(UserEntity createdBy);

    long countByCreatedBy(UserEntity createdBy);

    List<ExamEntity> findByStatus(ExamEntity.Status status);

    long countByStatus(ExamEntity.Status status);

    List<ExamEntity> findByCreatedByAndStatus(UserEntity createdBy, ExamEntity.Status status);
}