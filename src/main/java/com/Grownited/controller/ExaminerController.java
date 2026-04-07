package com.Grownited.controller;

import com.Grownited.entity.*;
import com.Grownited.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/examiner")
public class ExaminerController {

    @Autowired private SubjectRepository subjectRepository;
    @Autowired private ExamRepository examRepository;
    @Autowired private ExamAttemptRepository examAttemptRepository;
    @Autowired private ExamQuestionRepository examQuestionRepository;
    @Autowired private DifficultyLevelRepository difficultyRepository;
    @Autowired private QuestionBankRepository questionBankRepository;

    private boolean isExaminer(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && user.getRole() == UserEntity.Role.EXAMINER;
    }

    // =====================
    // DASHBOARD
    // =====================
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        long subjectCount = subjectRepository.countByActiveTrue();
        long examCount    = examRepository.countByStatus(ExamEntity.Status.ACTIVE);
        long questionCount = examQuestionRepository.countByCreatedBy(examiner);
        long resultCount  = examAttemptRepository.countByExamCreatedBy(examiner);

        model.addAttribute("subjectCount",  subjectCount);
        model.addAttribute("examCount",     examCount);
        model.addAttribute("questionCount", questionCount);
        model.addAttribute("resultCount",   resultCount);

        return "examiner/ExaminerDashboard";
    }

    // =====================
    // SUBJECTS
    // =====================
    @GetMapping("/subjects")
    public String subjectList(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        return "examiner/SubjectList";
    }

    @GetMapping("/addSubject")
    public String addSubjectForm(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        return "examiner/SubjectList";
    }

    @PostMapping("/saveSubject")
    public String saveSubject(@ModelAttribute SubjectEntity subject, HttpSession session) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        subject.setCreatedBy(examiner);
        if (subject.getActive() == null) subject.setActive(true);
        subjectRepository.save(subject);
        return "redirect:/examiner/subjects";
    }

    // =====================
    // EXAMS
    // =====================
    @GetMapping("/addExam")
    public String addExam(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("subjects",     subjectRepository.findByActiveTrue());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "examiner/AddExam";
    }

    @PostMapping("/saveExam")
    public String saveExam(@RequestParam("examTitle")    String examTitle,
                           @RequestParam("subjectId")    Integer subjectId,
                           @RequestParam("difficultyId") Integer difficultyId,
                           @RequestParam("duration")     Integer duration,
                           @RequestParam("totalMarks")   Integer totalMarks,
                           @RequestParam("status")       String status,
                           HttpSession session, Model model) {

        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (subject == null || difficulty == null) {
            model.addAttribute("error", "Invalid subject or difficulty.");
            model.addAttribute("subjects",     subjectRepository.findByActiveTrue());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "examiner/AddExam";
        }

        ExamEntity exam = new ExamEntity();
        exam.setExamName(examTitle);
        exam.setSubject(subject);
        exam.setSubjectName(subject.getSubjectName());
        exam.setDifficulty(difficulty);
        exam.setDurationMinutes(duration);
        exam.setTotalMarks(totalMarks);
        exam.setTotalQuestions(0);
        exam.setExamType(ExamEntity.ExamType.SCHOOL);
        exam.setStatus(ExamEntity.Status.valueOf(status.toUpperCase()));
        exam.setCreatedBy(examiner);
        examRepository.save(exam);

        return "redirect:/examiner/myExams";
    }

    // Widget 2 click → ALL active exams
    @GetMapping("/exams")
    public String allExams(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("exams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        model.addAttribute("pageTitle", "All Active Exams");
        return "examiner/MyExams";
    }

    // Sidebar → only this examiner's exams
    @GetMapping("/myExams")
    public String myExams(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        model.addAttribute("exams", examRepository.findByCreatedBy(examiner));
        model.addAttribute("pageTitle", "My Exams");
        return "examiner/MyExams";
    }

    // =====================
    // QUESTIONS
    // =====================
    @GetMapping("/questions")
    public String manageQuestions(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        model.addAttribute("questions", examQuestionRepository.findByCreatedBy(examiner));
        return "examiner/ManageQuestions";
    }

    @GetMapping("/addQuestion")
    public String addQuestionForm(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        List<ExamEntity> exams = examRepository.findByCreatedBy(examiner);
        // if examiner has no exams yet, show all active exams
        if (exams == null || exams.isEmpty()) {
            exams = examRepository.findByStatus(ExamEntity.Status.ACTIVE);
        }
        model.addAttribute("exams",        exams);
        model.addAttribute("subjects",     subjectRepository.findByActiveTrue());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "examiner/AddQuestion";
    }

    @PostMapping("/saveQuestion")
    public String saveQuestion(@RequestParam("examId")        Integer examId,
                               @RequestParam("subjectId")     Integer subjectId,
                               @RequestParam("difficultyId")  Integer difficultyId,
                               @RequestParam("questionText")  String questionText,
                               @RequestParam("optionA")       String optionA,
                               @RequestParam("optionB")       String optionB,
                               @RequestParam("optionC")       String optionC,
                               @RequestParam("optionD")       String optionD,
                               @RequestParam("correctOption") String correctOption,
                               @RequestParam("marks")         Integer marks,
                               HttpSession session, Model model) {

        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        ExamEntity exam = examRepository.findById(examId).orElse(null);
        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (exam == null || subject == null || difficulty == null) {
            model.addAttribute("error", "Please select valid exam, subject and difficulty.");
            List<ExamEntity> exams = examRepository.findByCreatedBy(examiner);
            if (exams == null || exams.isEmpty())
                exams = examRepository.findByStatus(ExamEntity.Status.ACTIVE);
            model.addAttribute("exams",        exams);
            model.addAttribute("subjects",     subjectRepository.findByActiveTrue());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "examiner/AddQuestion";
        }

        // Save to QuestionBankEntity — subject & difficulty are NOT NULL so must be set
        QuestionBankEntity qb = new QuestionBankEntity();
        qb.setQuestionText(questionText);
        qb.setOptionA(optionA);
        qb.setOptionB(optionB);
        qb.setOptionC(optionC);
        qb.setOptionD(optionD);
        qb.setCorrectOption(correctOption);
        qb.setMarks(marks);
        qb.setSubject(subject);        // NOT NULL — must set
        qb.setDifficulty(difficulty);  // NOT NULL — must set
        qb.setExam(exam);
        qb.setCreatedBy(examiner);
        questionBankRepository.save(qb);

        // Link in ExamQuestionEntity
        ExamQuestionEntity eq = new ExamQuestionEntity();
        eq.setExam(exam);
        eq.setQuestion(qb);
        eq.setCreatedBy(examiner);
        examQuestionRepository.save(eq);

        // Update exam's total question count
        exam.setTotalQuestions(examQuestionRepository.findByExam_ExamId(examId).size());
        examRepository.save(exam);

        return "redirect:/examiner/questions";
    }

    @GetMapping("/deleteQuestion/{id}")
    public String deleteQuestion(@PathVariable Integer id, HttpSession session) {
        if (!isExaminer(session)) return "redirect:/login";
        examQuestionRepository.deleteById(id);
        return "redirect:/examiner/questions";
    }

    // =====================
    // RESULTS
    // =====================
    @GetMapping("/results")
    public String results(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        model.addAttribute("results", examAttemptRepository.findByExamCreatedBy(examiner));
        return "examiner/Results";
    }
}