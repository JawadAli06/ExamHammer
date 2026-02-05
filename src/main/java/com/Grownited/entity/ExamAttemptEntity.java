package com.Grownited.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "exam_attempt")
public class ExamAttemptEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer attemptId;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private ExamEntity exam;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private UserEntity student; // STUDENT

    private LocalDateTime startTime;
    private LocalDateTime endTime;

    private Double totalScore;
    private Double percentage;

    @Enumerated(EnumType.STRING)
    private Result result;

    @Enumerated(EnumType.STRING)
    private Status status;

    public enum Result {
        PASS, FAIL
    }

    public enum Status {
        IN_PROGRESS, COMPLETED
    }

    public ExamAttemptEntity() {
        this.status = Status.IN_PROGRESS;
    }

    public Integer getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(Integer attemptId) {
        this.attemptId = attemptId;
    }

    public ExamEntity getExam() {
        return exam;
    }

    public void setExam(ExamEntity exam) {
        this.exam = exam;
    }

    public UserEntity getStudent() {
        return student;
    }

    public void setStudent(UserEntity student) {
        this.student = student;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}

