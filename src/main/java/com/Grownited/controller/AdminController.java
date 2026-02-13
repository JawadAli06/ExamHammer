package com.Grownited.controller;

import com.Grownited.entity.SubjectEntity;
import com.Grownited.repository.SubjectRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.ExamRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private ExamRepository examRepository;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/AdminDashboard";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "admin/UserList";
    }

    @GetMapping("/subjects")
    public String subjects(Model model) {
        model.addAttribute("subjects", subjectRepository.findAll());
        return "admin/SubjectList";
    }

    @GetMapping("/add-subject")
    public String addSubjectPage() {
        return "admin/AddSubject";
    }

    @PostMapping("/save-subject")
    public String saveSubject(SubjectEntity subject) {
        subjectRepository.save(subject);
        return "redirect:/admin/subjects";
    }

    @GetMapping("/exams")
    public String exams(Model model) {
        model.addAttribute("exams", examRepository.findAll());
        return "admin/ExamList";
    }
}
