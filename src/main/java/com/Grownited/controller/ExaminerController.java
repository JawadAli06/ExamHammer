package com.Grownited.controller;

import com.Grownited.entity.*;
import com.Grownited.repository.*;
import com.Grownited.service.CloudinaryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    @Autowired private UserRepository userRepository;
    @Autowired private CloudinaryService cloudinaryService;
    @Autowired private BCryptPasswordEncoder passwordEncoder;

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

        long subjectCount  = subjectRepository.countByActiveTrue();
        long examCount     = examRepository.countByStatus(ExamEntity.Status.ACTIVE);

        // FIXED: directly count questions created by this examiner
        // exam_question.created_by = 2 (Yuvraj) → returns 3 correctly
        long questionCount = examQuestionRepository.countByCreatedBy(examiner);

        long resultCount   = examAttemptRepository.count();

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
       // model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        model.addAttribute("subjects",
            subjectRepository.findVisibleSubjects(examiner.getUserId()));
        return "examiner/SubjectList";
    }

    @GetMapping("/addSubject")
    public String addSubjectForm(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        return "examiner/AddSubject"; 
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
        model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "examiner/AddExam";
    }

    @PostMapping("/saveExam")
    public String saveExam(@RequestParam("examTitle") String examTitle,
                           @RequestParam("subjectId") Integer subjectId,
                           @RequestParam("difficultyId") Integer difficultyId,
                           @RequestParam("duration") Integer duration,
                           @RequestParam("totalMarks") Integer totalMarks,
                           @RequestParam("status") String status,
                           HttpSession session, Model model) {

        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (subject == null || difficulty == null) {
            model.addAttribute("error", "Invalid subject or difficulty.");
            model.addAttribute("subjects", subjectRepository.findByActiveTrue());
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

    @GetMapping("/exams")
    public String allExams(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        model.addAttribute("exams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        model.addAttribute("pageTitle", "All Active Exams");
        return "examiner/MyExams";
    }

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
    

    
    @GetMapping("/addQuestion")
    public String addQuestionPage(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        List<ExamEntity> allActiveExams = examRepository
                .findByStatus(ExamEntity.Status.ACTIVE);

       // List<ExamEntity> exams = examRepository.findByCreatedBy(examiner);
       // if (exams == null || exams.isEmpty()) {
        //    exams = examRepository.findByStatus(ExamEntity.Status.ACTIVE);
      //  }

        model.addAttribute("exams", allActiveExams);
        model.addAttribute("subjects", subjectRepository.findByActiveTrue());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "examiner/AddQuestion";
    }

  /*  @GetMapping("/questions")
    public String manageQuestions(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        
        List<ExamQuestionEntity> questions =
                examQuestionRepository.findByCreatedBy(examiner);

        model.addAttribute("questions", questions);
        
     //   model.addAttribute("questions", examQuestionRepository.findByCreatedBy(examiner));
        return "examiner/ManageQuestions";
    }*/

 // =========================
 // QUESTIONS - EXAM LIST VIEW
 // =========================
 @GetMapping("/questions")
 public String manageQuestions(HttpSession session, Model model) {
     if (!isExaminer(session)) return "redirect:/login";
     UserEntity examiner = (UserEntity) session.getAttribute("user");

     // Show ALL active exams — admin + examiner created
     List<ExamEntity> allExams = examRepository.findByStatus(ExamEntity.Status.ACTIVE);

     // For each exam, count how many questions exist
     java.util.Map<Integer, Long> questionCountMap = new java.util.LinkedHashMap<>();
     for (ExamEntity exam : allExams) {
         long count = examQuestionRepository.findByExam_ExamId(exam.getExamId()).size();
         questionCountMap.put(exam.getExamId(), count);
     }

     model.addAttribute("exams", allExams);
     model.addAttribute("questionCountMap", questionCountMap);
     return "examiner/ManageQuestions";
 }

 // =========================
 // QUESTIONS - BY EXAM
 // =========================
 @GetMapping("/questions/exam/{examId}")
 public String questionsByExam(@PathVariable Integer examId,
                                HttpSession session, Model model) {
     if (!isExaminer(session)) return "redirect:/login";

     ExamEntity exam = examRepository.findById(examId).orElse(null);
     if (exam == null) return "redirect:/examiner/questions";

     List<ExamQuestionEntity> questions =
             examQuestionRepository.findByExam_ExamId(examId);

     model.addAttribute("exam",      exam);
     model.addAttribute("questions", questions);
     return "examiner/QuestionsByExam";
 }
    
    @PostMapping("/saveQuestion")
    public String saveQuestion(@RequestParam Integer examId,
                               @RequestParam Integer subjectId,
                               @RequestParam Integer difficultyId,
                               @RequestParam String questionText,
                               @RequestParam String optionA,
                               @RequestParam String optionB,
                               @RequestParam String optionC,
                               @RequestParam String optionD,
                               @RequestParam String correctOption,
                               @RequestParam Integer marks,
                               HttpSession session,
                               Model model) {

        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");

        ExamEntity exam = examRepository.findById(examId).orElse(null);
        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (exam == null || subject == null || difficulty == null) {
            model.addAttribute("error", "Please select valid exam, subject and difficulty.");
            List<ExamEntity> exams = examRepository.findByCreatedBy(examiner);
            if (exams == null || exams.isEmpty()) exams = examRepository.findByStatus(ExamEntity.Status.ACTIVE);
            model.addAttribute("exams", exams);
            model.addAttribute("subjects", subjectRepository.findByActiveTrue());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "examiner/AddQuestion";
        }

        QuestionBankEntity qb = new QuestionBankEntity();
        qb.setQuestionText(questionText);
        qb.setOptionA(optionA);
        qb.setOptionB(optionB);
        qb.setOptionC(optionC);
        qb.setOptionD(optionD);
        qb.setCorrectOption(correctOption);
        qb.setMarks(marks);
        qb.setSubject(subject);
        qb.setDifficulty(difficulty);
        qb.setExam(exam);
        qb.setCreatedBy(examiner);
        questionBankRepository.save(qb);

        ExamQuestionEntity eq = new ExamQuestionEntity();
        eq.setExam(exam);
        eq.setQuestion(qb);
        eq.setCreatedBy(examiner);
        examQuestionRepository.save(eq);

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
    
    // both exam result
    
    @GetMapping("/results")
    public String results(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";

        // Show ALL results
        List<ExamAttemptEntity> results = examAttemptRepository.findAll();
        model.addAttribute("results", results);
        return "examiner/Results";
    }
    
    
    /*@GetMapping("/results")
    public String results(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        model.addAttribute("results", examAttemptRepository.findByExamCreatedBy(examiner));
        return "examiner/Results";
    }*/

    // =====================
    // PROFILE
    // =====================
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isExaminer(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        model.addAttribute("userData", dbUser);
        return "examiner/Profile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam String firstName,
                                @RequestParam String lastName,
                                @RequestParam(required = false) String gender,
                                @RequestParam(required = false) String contactNum,
                                @RequestParam(required = false) Integer birthYear,
                                @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
                                HttpSession session,
                                Model model) {
        if (!isExaminer(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        dbUser.setFirstName(firstName);
        dbUser.setLastName(lastName);
        dbUser.setGender(gender);
        dbUser.setContactNum(contactNum);
        dbUser.setBirthYear(birthYear);

        if (profilePic != null && !profilePic.isEmpty()) {
            try {
                String picUrl = cloudinaryService.uploadProfilePic(profilePic);
                dbUser.setProfilePicURL(picUrl);
            } catch (Exception e) {
                model.addAttribute("error", "Profile picture upload failed.");
            }
        }

        userRepository.save(dbUser);
        session.setAttribute("user", dbUser);

        model.addAttribute("success", "Profile updated successfully.");
        model.addAttribute("userData", dbUser);
        return "examiner/Profile";
    }

    // =====================
    // CHANGE PASSWORD
    // =====================
    @GetMapping("/changePassword")
    public String changePasswordPage(HttpSession session) {
        if (!isExaminer(session)) return "redirect:/login";
        return "examiner/ChangePassword";
    }

    @PostMapping("/updatePassword")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 Model model) {
        if (!isExaminer(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        if (!passwordEncoder.matches(currentPassword, dbUser.getPassword())) {
            model.addAttribute("error", "Current password is incorrect.");
            return "examiner/ChangePassword";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New password and confirm password do not match.");
            return "examiner/ChangePassword";
        }

        dbUser.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(dbUser);
        session.setAttribute("user", dbUser);

        model.addAttribute("success", "Password changed successfully.");
        return "examiner/ChangePassword";
    }
}