package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.StudentAnswerEntity;
import com.Grownited.entity.ExamAttemptEntity;

@Repository
public interface StudentAnswerRepository
        extends JpaRepository<StudentAnswerEntity, Integer> {

	List<StudentAnswerEntity> findByAttempt(ExamAttemptEntity attempt);
}

