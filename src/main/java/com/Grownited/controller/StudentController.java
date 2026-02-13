package com.Grownited.controller;

import com.Grownited.repository.ExamRepository;
import com.Grownited.repository.ExamAttemptRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private ExamAttemptRepository attemptRepository;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "student/StudentDashboard";
    }

    @GetMapping("/exams")
    public String exams(Model model) {
        model.addAttribute("exams", examRepository.findAll());
        return "student/ExamList";
    }

    @GetMapping("/results")
    public String results(Model model) {
        model.addAttribute("results", attemptRepository.findAll());
        return "student/ResultList";
    }
}
