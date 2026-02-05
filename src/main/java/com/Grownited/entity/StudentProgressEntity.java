package com.Grownited.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "student_progress")
public class StudentProgressEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer progressId;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private UserEntity student; // STUDENT

    @ManyToOne
    @JoinColumn(name = "subject_id", nullable = false)
    private SubjectEntity subject;

    private Integer totalAttempts;
    private Double averageScore;
    private Double bestScore;

    private LocalDateTime lastUpdated;

    public StudentProgressEntity() {
        this.totalAttempts = 0;
        this.averageScore = 0.0;
        this.bestScore = 0.0;
        this.lastUpdated = LocalDateTime.now();
    }

    public Integer getProgressId() {
        return progressId;
    }

    public void setProgressId(Integer progressId) {
        this.progressId = progressId;
    }

    public UserEntity getStudent() {
        return student;
    }

    public void setStudent(UserEntity student) {
        this.student = student;
    }

    public SubjectEntity getSubject() {
        return subject;
    }

    public void setSubject(SubjectEntity subject) {
        this.subject = subject;
    }

    public Integer getTotalAttempts() {
        return totalAttempts;
    }

    public void setTotalAttempts(Integer totalAttempts) {
        this.totalAttempts = totalAttempts;
    }

    public Double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(Double averageScore) {
        this.averageScore = averageScore;
    }

    public Double getBestScore() {
        return bestScore;
    }

    public void setBestScore(Double bestScore) {
        this.bestScore = bestScore;
    }

    public LocalDateTime getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(LocalDateTime lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}

