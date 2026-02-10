package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.ExamQuestionEntity;

@Repository
public interface ExamQuestionRepository
        extends JpaRepository<ExamQuestionEntity, Integer> {

    List<ExamQuestionEntity> findByExam(ExamEntity exam);
}

