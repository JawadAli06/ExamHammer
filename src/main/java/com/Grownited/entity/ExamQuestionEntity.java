package com.Grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "exam_question")
public class ExamQuestionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer examQuestionId;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private ExamEntity exam;

    @ManyToOne
    @JoinColumn(name = "question_id", nullable = false)
    private QuestionBankEntity question;

    public Integer getExamQuestionId() {
        return examQuestionId;
    }

    public void setExamQuestionId(Integer examQuestionId) {
        this.examQuestionId = examQuestionId;
    }

    public ExamEntity getExam() {
        return exam;
    }

    public void setExam(ExamEntity exam) {
        this.exam = exam;
    }

    public QuestionBankEntity getQuestion() {
        return question;
    }

    public void setQuestion(QuestionBankEntity question) {
        this.question = question;
    }
}

