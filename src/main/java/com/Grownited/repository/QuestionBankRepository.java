package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.QuestionBankEntity;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.ExamEntity;

@Repository
public interface QuestionBankRepository
        extends JpaRepository<QuestionBankEntity, Integer> {

    List<QuestionBankEntity> findBySubject(SubjectEntity subject);
    List<QuestionBankEntity> findByExam(ExamEntity exam);
}