package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.SubjectEntity;
import java.util.List;


@Repository
public interface SubjectRepository extends JpaRepository<SubjectEntity, Integer> {
	 List<SubjectEntity> findByActiveTrue();
}

