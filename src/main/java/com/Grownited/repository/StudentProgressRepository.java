package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.StudentProgressEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.SubjectEntity;

@Repository
public interface StudentProgressRepository
        extends JpaRepository<StudentProgressEntity, Integer> {

    StudentProgressEntity findByStudentAndSubject(
            UserEntity student,
            SubjectEntity subject
    );
}

