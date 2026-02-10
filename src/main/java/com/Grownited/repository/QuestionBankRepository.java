package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.QuestionBankEntity;
import com.Grownited.entity.SubjectEntity;

@Repository
public interface QuestionBankRepository
        extends JpaRepository<QuestionBankEntity, Integer> {

    List<QuestionBankEntity> findBySubject(SubjectEntity subject);
}
