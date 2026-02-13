package com.Grownited.controller;

import com.Grownited.entity.QuestionBankEntity;
import com.Grownited.entity.ExamEntity;
import com.Grownited.repository.QuestionBankRepository;
import com.Grownited.repository.ExamRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/examiner")
public class ExaminerController {

    @Autowired
    private QuestionBankRepository questionRepository;

    @Autowired
    private ExamRepository examRepository;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "examiner/ExaminerDashboard";
    }

    @GetMapping("/questions")
    public String questions(Model model) {
        model.addAttribute("questions", questionRepository.findAll());
        return "examiner/QuestionList";
    }

    @GetMapping("/add-question")
    public String addQuestionPage() {
        return "examiner/AddQuestion";
    }

    @PostMapping("/save-question")
    public String saveQuestion(QuestionBankEntity question) {
        questionRepository.save(question);
        return "redirect:/examiner/questions";
    }

    @GetMapping("/exams")
    public String exams(Model model) {
        model.addAttribute("exams", examRepository.findAll());
        return "examiner/ExamList";
    }

    @GetMapping("/add-exam")
    public String addExamPage() {
        return "examiner/AddExam";
    }

    @PostMapping("/save-exam")
    public String saveExam(ExamEntity exam) {
        examRepository.save(exam);
        return "redirect:/examiner/exams";
    }
}
