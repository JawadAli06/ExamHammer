package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.ExamQuestionEntity;
import com.Grownited.entity.UserEntity;

@Repository
public interface ExamQuestionRepository
        extends JpaRepository<ExamQuestionEntity, Integer> {

    List<ExamQuestionEntity> findByExam_ExamId(Integer examId);

    long countByExam_CreatedBy(UserEntity createdBy);

    long countByCreatedBy(UserEntity createdBy);

    // ✅ ADDED - needed for ManageQuestions list
    List<ExamQuestionEntity> findByCreatedBy(UserEntity createdBy);
}