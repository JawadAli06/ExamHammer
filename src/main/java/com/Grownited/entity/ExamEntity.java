package com.Grownited.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "exam")
public class ExamEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer examId;

    @Column(nullable = false)
    private String examName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ExamType examType;

    @ManyToOne
    @JoinColumn(name = "subject_id", nullable = false)
    private SubjectEntity subject;

    @Column(nullable = false)
    private Integer totalQuestions;

    @Column(nullable = false)
    private Integer totalMarks;

    @Column(nullable = false)
    private Integer durationMinutes;

    @ManyToOne
    @JoinColumn(name = "difficulty_id", nullable = false)
    private DifficultyLevelEntity difficulty;

    private Boolean negativeMarking;

    private LocalDateTime startDate;
    private LocalDateTime endDate;

    private Integer passingScore;

    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private UserEntity createdBy; // ADMIN

    @Enumerated(EnumType.STRING)
    private Status status;

    public enum ExamType {
        SCHOOL, COLLEGE, JOB
    }

    public enum Status {
        ACTIVE, INACTIVE
    }

    public ExamEntity() {
        this.status = Status.ACTIVE;
        this.negativeMarking = false;
    }

    public Integer getExamId() {
        return examId;
    }

    public void setExamId(Integer examId) {
        this.examId = examId;
    }

    public String getExamName() {
        return examName;
    }

    public void setExamName(String examName) {
        this.examName = examName;
    }

    public ExamType getExamType() {
        return examType;
    }

    public void setExamType(ExamType examType) {
        this.examType = examType;
    }

    public SubjectEntity getSubject() {
        return subject;
    }

    public void setSubject(SubjectEntity subject) {
        this.subject = subject;
    }

    public Integer getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(Integer totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public Integer getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(Integer totalMarks) {
        this.totalMarks = totalMarks;
    }

    public Integer getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public DifficultyLevelEntity getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(DifficultyLevelEntity difficulty) {
        this.difficulty = difficulty;
    }

    public Boolean getNegativeMarking() {
        return negativeMarking;
    }

    public void setNegativeMarking(Boolean negativeMarking) {
        this.negativeMarking = negativeMarking;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public Integer getPassingScore() {
        return passingScore;
    }

    public void setPassingScore(Integer passingScore) {
        this.passingScore = passingScore;
    }

    public UserEntity getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(UserEntity createdBy) {
        this.createdBy = createdBy;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
