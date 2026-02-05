
package com.Grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "question_bank")
public class QuestionBankEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer questionId;

    @ManyToOne
    @JoinColumn(name = "subject_id", nullable = false)
    private SubjectEntity subject;

    @ManyToOne
    @JoinColumn(name = "difficulty_id", nullable = false)
    private DifficultyLevelEntity difficulty;

    @Column(nullable = false, length = 2000)
    private String questionText;

    @Column(nullable = false)
    private String optionA;

    @Column(nullable = false)
    private String optionB;

    @Column(nullable = false)
    private String optionC;

    @Column(nullable = false)
    private String optionD;

    @Column(nullable = false)
    private String correctOption;

    @Column(length = 2000)
    private String explanation;

    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private UserEntity createdBy; // ADMIN or EXAMINER

    private Boolean active;

    public QuestionBankEntity() {
        this.active = true;
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public SubjectEntity getSubject() {
        return subject;
    }

    public void setSubject(SubjectEntity subject) {
        this.subject = subject;
    }

    public DifficultyLevelEntity getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(DifficultyLevelEntity difficulty) {
        this.difficulty = difficulty;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectOption() {
        return correctOption;
    }

    public void setCorrectOption(String correctOption) {
        this.correctOption = correctOption;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public UserEntity getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(UserEntity createdBy) {
        this.createdBy = createdBy;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
