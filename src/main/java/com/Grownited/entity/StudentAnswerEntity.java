package com.Grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "student_answer")
public class StudentAnswerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer answerId;

    @ManyToOne
    @JoinColumn(name = "attempt_id", nullable = false)
    private ExamAttemptEntity attempt;

    @ManyToOne
    @JoinColumn(name = "question_id", nullable = false)
    private QuestionBankEntity question;

    private String selectedOption;

    private Boolean isCorrect;

    private Integer marksAwarded;

    public Integer getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Integer answerId) {
        this.answerId = answerId;
    }

    public ExamAttemptEntity getAttempt() {
        return attempt;
    }

    public void setAttempt(ExamAttemptEntity attempt) {
        this.attempt = attempt;
    }

    public QuestionBankEntity getQuestion() {
        return question;
    }

    public void setQuestion(QuestionBankEntity question) {
        this.question = question;
    }

    public String getSelectedOption() {
        return selectedOption;
    }

    public void setSelectedOption(String selectedOption) {
        this.selectedOption = selectedOption;
    }

    public Boolean getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(Boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Integer getMarksAwarded() {
        return marksAwarded;
    }

    public void setMarksAwarded(Integer marksAwarded) {
        this.marksAwarded = marksAwarded;
    }
}
