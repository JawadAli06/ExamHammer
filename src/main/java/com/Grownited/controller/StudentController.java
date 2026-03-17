package com.Grownited.controller;

import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.ExamAttemptRepository;
import com.Grownited.repository.ExamQuestionRepository;
import com.Grownited.repository.ExamRepository;
import jakarta.servlet.http.HttpSession;
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
    private ExamQuestionRepository examQuestionRepository;

    @Autowired(required = false)
    private ExamAttemptRepository examAttemptRepository;

    public ExamRepository getExamRepository() {
		return examRepository;
	}

	public void setExamRepository(ExamRepository examRepository) {
		this.examRepository = examRepository;
	}

	public ExamQuestionRepository getExamQuestionRepository() {
		return examQuestionRepository;
	}

	public void setExamQuestionRepository(ExamQuestionRepository examQuestionRepository) {
		this.examQuestionRepository = examQuestionRepository;
	}

	public ExamAttemptRepository getExamAttemptRepository() {
		return examAttemptRepository;
	}

	public void setExamAttemptRepository(ExamAttemptRepository examAttemptRepository) {
		this.examAttemptRepository = examAttemptRepository;
	}

	@GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        UserEntity student = (UserEntity) session.getAttribute("user");
        if (student == null || student.getRole() != UserEntity.Role.STUDENT) {
            return "redirect:/login";
        }

        model.addAttribute("activeExams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        model.addAttribute("activeExamsCount", examRepository.countByStatus(ExamEntity.Status.ACTIVE));

        // if result module not ready yet, keep 0
        model.addAttribute("resultCount", 0);

        return "student/StudentDashboard";
    }

    @GetMapping("/exams")
    public String examList(Model model, HttpSession session) {
        UserEntity student = (UserEntity) session.getAttribute("user");
        if (student == null || student.getRole() != UserEntity.Role.STUDENT) {
            return "redirect:/login";
        }

        model.addAttribute("exams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        return "student/ExamList";
    }

    @GetMapping("/exam/{id}")
    public String examDetails(@PathVariable Integer id, Model model, HttpSession session) {
        UserEntity student = (UserEntity) session.getAttribute("user");
        if (student == null || student.getRole() != UserEntity.Role.STUDENT) {
            return "redirect:/login";
        }

        ExamEntity exam = examRepository.findById(id).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        model.addAttribute("exam", exam);
        return "student/ExamDetails";
    }

    @GetMapping("/startExam/{id}")
    public String startExam(@PathVariable Integer id, Model model, HttpSession session) {
        UserEntity student = (UserEntity) session.getAttribute("user");
        if (student == null || student.getRole() != UserEntity.Role.STUDENT) {
            return "redirect:/login";
        }

        ExamEntity exam = examRepository.findById(id).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        model.addAttribute("exam", exam);
        model.addAttribute("examQuestions", examQuestionRepository.findByExam_ExamId(id));

        return "student/StartExam";
    }

    @GetMapping("/results")
    public String resultsPage() {
        return "student/ResultList";
    }
}