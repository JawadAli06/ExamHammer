package com.Grownited.controller;

import com.Grownited.entity.ExamAttemptEntity;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.ExamQuestionEntity;
import com.Grownited.entity.QuestionBankEntity;
import com.Grownited.entity.StudentAnswerEntity;
import com.Grownited.entity.StudentProgressEntity;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.ExamAttemptRepository;
import com.Grownited.repository.ExamQuestionRepository;
import com.Grownited.repository.ExamRepository;
import com.Grownited.repository.StudentAnswerRepository;
import com.Grownited.repository.StudentProgressRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.CloudinaryService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired private ExamRepository examRepository;
    @Autowired private ExamQuestionRepository examQuestionRepository;
    @Autowired private ExamAttemptRepository examAttemptRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private CloudinaryService cloudinaryService;
    @Autowired private BCryptPasswordEncoder passwordEncoder;
    @Autowired private StudentAnswerRepository studentAnswerRepository;
    @Autowired private StudentProgressRepository studentProgressRepository;

    private boolean isStudent(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && user.getRole() == UserEntity.Role.STUDENT;
    }

    // =========================
    // DASHBOARD
    // =========================
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (!isStudent(session)) return "redirect:/login";
        UserEntity student = (UserEntity) session.getAttribute("user");

        long activeExamsCount = examRepository.countByStatus(ExamEntity.Status.ACTIVE);
        long resultCount = examAttemptRepository.countByStudent(student);
        long progressCount = studentProgressRepository.findByStudent(student).size();
        

        model.addAttribute("activeExams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        model.addAttribute("activeExamsCount", activeExamsCount);
        model.addAttribute("resultCount", resultCount);
        model.addAttribute("progressCount", progressCount);
        return "student/StudentDashboard";
    }

    // =========================
    // EXAM LIST
    // =========================
    @GetMapping("/exams")
    public String examList(Model model, HttpSession session) {
        if (!isStudent(session)) return "redirect:/login";
        model.addAttribute("exams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
        return "student/ExamList";
    }

    // =========================
    // EXAM DETAILS
    // =========================
    @GetMapping("/exam/{id}")
    public String examDetails(@PathVariable Integer id, Model model, HttpSession session) {
        if (!isStudent(session)) return "redirect:/login";

        ExamEntity exam = examRepository.findById(id).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        model.addAttribute("exam", exam);
        return "student/ExamDetails";
    }

    // =========================
    // START EXAM
    // =========================
    @GetMapping("/startExam/{id}")
    public String startExam(@PathVariable Integer id, Model model, HttpSession session) {
        if (!isStudent(session)) return "redirect:/login";

        ExamEntity exam = examRepository.findById(id).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        model.addAttribute("exam", exam);
        model.addAttribute("examQuestions", examQuestionRepository.findByExam_ExamId(id));

        return "student/StartExam";
    }

    // =========================
    // SUBMIT EXAM
    // =========================
    
    @PostMapping("/submitExam")
    public String submitExam(@RequestParam Integer examId,
                             HttpServletRequest request,
                             Model model, HttpSession session) {

        if (!isStudent(session)) return "redirect:/login";
        UserEntity student = (UserEntity) session.getAttribute("user");

        ExamEntity exam = examRepository.findById(examId).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        List<ExamQuestionEntity> examQuestions =
                examQuestionRepository.findByExam_ExamId(examId);

        int totalQuestions = examQuestions.size();
        int correctAnswers = 0;
        int wrongAnswers   = 0;
        int unanswered     = 0;
        double marksObtained = 0.0;
        double totalMarks    = 0.0;

        // =====================
        // STEP 1: Save ExamAttempt first (needed for StudentAnswer FK)
        // =====================
        ExamAttemptEntity attempt = new ExamAttemptEntity();
        attempt.setExam(exam);
        attempt.setStudent(student);
        attempt.setCreatedBy(exam.getCreatedBy());
        attempt.setStartTime(java.time.LocalDateTime.now());
        attempt.setStatus(ExamAttemptEntity.Status.IN_PROGRESS);
        examAttemptRepository.save(attempt); // save early to get attemptId

        // =====================
        // STEP 2: Process each question + save StudentAnswer
        // =====================
        for (ExamQuestionEntity eq : examQuestions) {
            QuestionBankEntity q = eq.getQuestion();
            if (q == null) continue;

            double qMarks = (q.getMarks() != null) ? q.getMarks() : 0.0;
            totalMarks += qMarks;

            String selected = request.getParameter("answer_" + q.getQuestionId());
            String correct  = q.getCorrectOption();

            boolean isCorrect = false;
            int marksAwarded  = 0;

            if (selected == null || selected.isBlank()) {
                unanswered++;
            } else if (selected.equalsIgnoreCase(correct)) {
                correctAnswers++;
                marksObtained += qMarks;
                isCorrect    = true;
                marksAwarded = q.getMarks() != null ? q.getMarks() : 0;
            } else {
                wrongAnswers++;
                if (Boolean.TRUE.equals(exam.getNegativeMarking())) {
                    marksObtained -= 0.25;
                }
            }

            StudentAnswerEntity answer = new StudentAnswerEntity();
            answer.setAttempt(attempt);
            answer.setQuestion(q);
            answer.setSelectedOption(selected != null ? selected : "");
            answer.setIsCorrect(isCorrect);
            answer.setMarksAwarded(marksAwarded);
            studentAnswerRepository.save(answer);
        }


        // =====================
        // STEP 3: Calculate final scores
        // =====================
        double percentage = (totalMarks > 0)
                ? Math.round((marksObtained / totalMarks) * 10000.0) / 100.0
                : 0.0;
        marksObtained = Math.round(marksObtained * 100.0) / 100.0;

        boolean passed = exam.getPassingScore() != null
                && marksObtained >= exam.getPassingScore();

        // =====================
        // STEP 4: Update ExamAttempt with final results
        // =====================
        attempt.setEndTime(java.time.LocalDateTime.now());
        attempt.setTotalScore(marksObtained);
        attempt.setPercentage(percentage);
        attempt.setStatus(ExamAttemptEntity.Status.COMPLETED);
        attempt.setResult(passed
                ? ExamAttemptEntity.Result.PASS
                : ExamAttemptEntity.Result.FAIL);
        examAttemptRepository.save(attempt);

        // =====================
        // STEP 5: Update StudentProgress per subject
        // =====================
        SubjectEntity subject = exam.getSubject();
        if (subject != null) {
            StudentProgressEntity progress =
                    studentProgressRepository.findByStudentAndSubject(student, subject);

            if (progress == null) {
                progress = new StudentProgressEntity();
                progress.setStudent(student);
                progress.setSubject(subject);
                progress.setTotalAttempts(1);
                progress.setAverageScore(marksObtained);
                progress.setBestScore(marksObtained);
            } else {
                int attempts = progress.getTotalAttempts() + 1;
                double newAvg = ((progress.getAverageScore()
                        * progress.getTotalAttempts()) + marksObtained) / attempts;
                progress.setTotalAttempts(attempts);
                progress.setAverageScore(Math.round(newAvg * 100.0) / 100.0);
                if (marksObtained > progress.getBestScore()) {
                    progress.setBestScore(marksObtained);
                }
            }
            progress.setLastUpdated(java.time.LocalDateTime.now());
            studentProgressRepository.save(progress);
        }

        // =====================
        // STEP 6: Pass data to result page
        // =====================
        model.addAttribute("exam",           exam);
        model.addAttribute("student",        student);
        model.addAttribute("attempt",        attempt);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("correctAnswers", correctAnswers);
        model.addAttribute("wrongAnswers",   wrongAnswers);
        model.addAttribute("unanswered",     unanswered);
        model.addAttribute("marksObtained",  marksObtained);
        model.addAttribute("totalMarks",     totalMarks);
        model.addAttribute("percentage",     percentage);
        model.addAttribute("passed",         passed);

        return "student/ExamResult";
    }
    
    
   /* @PostMapping("/submitExam")
    public String submitExam(@RequestParam Integer examId,
                             HttpServletRequest request,
                             Model model, HttpSession session) {

        if (!isStudent(session)) return "redirect:/login";
        UserEntity student = (UserEntity) session.getAttribute("user");

        ExamEntity exam = examRepository.findById(examId).orElse(null);
        if (exam == null) return "redirect:/student/exams";

        List<ExamQuestionEntity> examQuestions = examQuestionRepository.findByExam_ExamId(examId);

        int totalQuestions = examQuestions.size();
        int correctAnswers = 0;
        int wrongAnswers = 0;
        int unanswered = 0;
        double marksObtained = 0.0;
        double totalMarks = 0.0;

        for (ExamQuestionEntity eq : examQuestions) {
            QuestionBankEntity q = eq.getQuestion();
            if (q == null) continue;

            double qMarks = (q.getMarks() != null) ? q.getMarks() : 0.0;
            totalMarks += qMarks;

            String selected = request.getParameter("answer_" + q.getQuestionId());
            String correct = q.getCorrectOption();

            if (selected == null || selected.isBlank()) {
                unanswered++;
            } else if (selected.equalsIgnoreCase(correct)) {
                correctAnswers++;
                marksObtained += qMarks;
            } else {
                wrongAnswers++;
                if (Boolean.TRUE.equals(exam.getNegativeMarking())) {
                    marksObtained -= 0.25;
                }
            }
        }

        double percentage = (totalMarks > 0)
                ? Math.round((marksObtained / totalMarks) * 10000.0) / 100.0
                : 0.0;
        marksObtained = Math.round(marksObtained * 100.0) / 100.0;

        boolean passed = exam.getPassingScore() != null && marksObtained >= exam.getPassingScore();

        ExamAttemptEntity attempt = new ExamAttemptEntity();
        attempt.setExam(exam);
        attempt.setStudent(student);
        attempt.setCreatedBy(exam.getCreatedBy());
        attempt.setStartTime(java.time.LocalDateTime.now());
        attempt.setEndTime(java.time.LocalDateTime.now());
        attempt.setTotalScore(marksObtained);
        attempt.setPercentage(percentage);
        attempt.setStatus(ExamAttemptEntity.Status.COMPLETED);
        attempt.setResult(passed ? ExamAttemptEntity.Result.PASS : ExamAttemptEntity.Result.FAIL);
        examAttemptRepository.save(attempt);

        model.addAttribute("exam", exam);
        model.addAttribute("student", student);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("correctAnswers", correctAnswers);
        model.addAttribute("wrongAnswers", wrongAnswers);
        model.addAttribute("unanswered", unanswered);
        model.addAttribute("marksObtained", marksObtained);
        model.addAttribute("totalMarks", totalMarks);
        model.addAttribute("percentage", percentage);
        model.addAttribute("passed", passed);

        return "student/ExamResult";
    }*/

    // =========================
    // MY RESULTS
    // =========================
    
    @GetMapping("/results")
    public String studentResults(HttpSession session, Model model) {
        if (!isStudent(session)) return "redirect:/login";
        UserEntity student = (UserEntity) session.getAttribute("user");

        List<ExamAttemptEntity> results = examAttemptRepository.findByStudent(student);

        model.addAttribute("results", results);
        return "student/Results";
    }
    
    // =========================
    // PROGRESS
    // =========================
    
    @GetMapping("/progress")
    public String progress(HttpSession session, Model model) {
        if (!isStudent(session)) return "redirect:/login";
        UserEntity student = (UserEntity) session.getAttribute("user");

        List<StudentProgressEntity> progressList =
                studentProgressRepository.findByStudent(student);

        model.addAttribute("progressList", progressList);
        return "student/Progress";
    }

    // =========================
    // PROFILE
    // =========================
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isStudent(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        model.addAttribute("userData", dbUser);
        return "student/Profile";
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
        if (!isStudent(session)) return "redirect:/login";

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
        return "student/Profile";
    }

    // =========================
    // CHANGE PASSWORD
    // =========================
    @GetMapping("/changePassword")
    public String changePasswordPage(HttpSession session) {
        if (!isStudent(session)) return "redirect:/login";
        return "student/ChangePassword";
    }

    @PostMapping("/updatePassword")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 Model model) {
        if (!isStudent(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        if (!passwordEncoder.matches(currentPassword, dbUser.getPassword())) {
            model.addAttribute("error", "Current password is incorrect.");
            return "student/ChangePassword";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New password and confirm password do not match.");
            return "student/ChangePassword";
        }

        dbUser.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(dbUser);
        session.setAttribute("user", dbUser);

        model.addAttribute("success", "Password changed successfully.");
        return "student/ChangePassword";
    }
}