package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.UserEntity;

@Repository
public interface ExamRepository extends JpaRepository<ExamEntity, Integer> {

    List<ExamEntity> findBySubject(SubjectEntity subject);

    List<ExamEntity> findByCreatedBy(UserEntity user);
}
