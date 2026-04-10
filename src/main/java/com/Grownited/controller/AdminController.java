package com.Grownited.controller;

import com.Grownited.entity.DifficultyLevelEntity;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.DifficultyLevelRepository;
import com.Grownited.repository.ExamAttemptRepository;
import com.Grownited.repository.ExamRepository;
import com.Grownited.repository.SubjectRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.CloudinaryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private UserRepository userRepository;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private ExamRepository examRepository;
    @Autowired private DifficultyLevelRepository difficultyRepository;
    @Autowired private ExamAttemptRepository examAttemptRepository;
    @Autowired private CloudinaryService cloudinaryService;
    @Autowired private BCryptPasswordEncoder passwordEncoder;

    private boolean isAdmin(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && user.getRole() == UserEntity.Role.ADMIN;
    }

    // ================= DASHBOARD =================

    @GetMapping("/dashboard")
    public String dashboard(Model model) {

        // ================= TOP WIDGETS =================
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalSubjects", subjectRepository.count());
        model.addAttribute("totalExams", examRepository.count());
        model.addAttribute("activeExams", examRepository.countByStatus(ExamEntity.Status.ACTIVE));
        model.addAttribute("totalAttempts", examAttemptRepository.count());
        
        // ================= CHART 1: USERS BY ROLE =================
        long adminCount = userRepository.countByRole(UserEntity.Role.ADMIN);
        long examinerCount = userRepository.countByRole(UserEntity.Role.EXAMINER);
        long studentCount = userRepository.countByRole(UserEntity.Role.STUDENT);

        model.addAttribute("adminCount", adminCount);
        model.addAttribute("examinerCount", examinerCount);
        model.addAttribute("studentCount", studentCount);

        // ================= CHART 2: EXAMS BY STATUS =================
        long activeExamCount = examRepository.countByStatus(ExamEntity.Status.ACTIVE);
        long inactiveExamCount = examRepository.countByStatus(ExamEntity.Status.INACTIVE);

        model.addAttribute("activeExamCount", activeExamCount);
        model.addAttribute("inactiveExamCount", inactiveExamCount);

        // ================= CHART 3: SUBJECT-WISE EXAM COUNT =================
        List<SubjectEntity> subjects = subjectRepository.findAll();

        StringBuilder subjectLabels = new StringBuilder();
        StringBuilder subjectExamCounts = new StringBuilder();

        for (int i = 0; i < subjects.size(); i++) {
            SubjectEntity subject = subjects.get(i);
            long examCount = examRepository.countBySubject(subject);

            subjectLabels.append("'").append(subject.getSubjectName()).append("'");
            subjectExamCounts.append(examCount);

            if (i < subjects.size() - 1) {
                subjectLabels.append(",");
                subjectExamCounts.append(",");
            }
        }

        model.addAttribute("subjectLabels", subjectLabels.toString());
        model.addAttribute("subjectExamCounts", subjectExamCounts.toString());
        model.addAttribute("totalAttempts", examAttemptRepository.count());
        return "admin/AdminDashboard";
    }
    // ================= USER CRUD =================

    @GetMapping("/users")
    public String userList(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("users", userRepository.findAll());
        return "admin/UserList";
    }

    @GetMapping("/users/add")
    public String addUserForm(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("user", new UserEntity());
        return "admin/AddUser";
    }

    @PostMapping("/users/save")
    public String saveUser(@ModelAttribute UserEntity user, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";

        if (user.getRole() == null) user.setRole(UserEntity.Role.STUDENT);
        if (user.getActive() == null) user.setActive(true);

        // If password is plain text from AddUser form, encode it
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$") && !user.getPassword().startsWith("$2b$")) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        userRepository.save(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUser(@PathVariable Integer id, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("user", userRepository.findById(id).orElse(null));
        return "admin/AddUser";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Integer id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        userRepository.deleteById(id);
        return "redirect:/admin/users";
    }

    // ================= SUBJECT CRUD =================

    @GetMapping("/subjects")
    public String subjectList(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("subjects", subjectRepository.findAll());
        return "admin/SubjectList";
    }

    @GetMapping("/subjects/add")
    public String addSubjectPage(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("subject", new SubjectEntity());
        return "admin/AddSubject";
    }

    @PostMapping("/subjects/save")
    public String saveSubject(@ModelAttribute SubjectEntity subject, HttpSession session) {
        UserEntity admin = (UserEntity) session.getAttribute("user");

        if (admin == null || admin.getRole() != UserEntity.Role.ADMIN) {
            return "redirect:/login";
        }

        subject.setCreatedBy(admin);

        if (subject.getActive() == null) {
            subject.setActive(true);
        }

        subjectRepository.save(subject);
        return "redirect:/admin/subjects";
    }

    @GetMapping("/subjects/edit/{id}")
    public String editSubject(@PathVariable Integer id, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("subject", subjectRepository.findById(id).orElse(null));
        return "admin/AddSubject";
    }

    @GetMapping("/subjects/delete/{id}")
    public String deleteSubject(@PathVariable Integer id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        SubjectEntity s = subjectRepository.findById(id).orElseThrow();
        s.setActive(false);
        subjectRepository.save(s);
        return "redirect:/admin/subjects";
    }

    @GetMapping("/addSubject")
    public String redirectAddSubject() {
        return "redirect:/admin/subjects/add";
    }

    @GetMapping("/deleteSubject/{id}")
    public String redirectDeleteSubject(@PathVariable Integer id) {
        return "redirect:/admin/subjects/delete/" + id;
    }

    // ================= EXAM CRUD =================

    @GetMapping("/exams")
    public String examList(@RequestParam(required = false) ExamEntity.Status status, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";

        if (status != null) model.addAttribute("exams", examRepository.findByStatus(status));
        else model.addAttribute("exams", examRepository.findAll());

        return "admin/ExamList";
    }

    @GetMapping("/exams/add")
    public String addExamForm(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";

        model.addAttribute("exam", new ExamEntity());
        model.addAttribute("subjects", subjectRepository.findAll());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "admin/AddExam";
    }

    @PostMapping("/exams/save")
    public String saveExam(ExamEntity exam,
                           @RequestParam Integer subjectId,
                           @RequestParam Integer difficultyId,
                           @RequestParam(required = false) Boolean negativeMarking,
                           @RequestParam(required = false) Integer passingScore,
                           @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                           @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                           HttpSession session,
                           Model model) {

        UserEntity logged = (UserEntity) session.getAttribute("user");

        if (logged == null) return "redirect:/login";
        if (logged.getRole() != UserEntity.Role.ADMIN) return "redirect:/login";

        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (subject == null || difficulty == null) {
            model.addAttribute("error", "Please select valid subject and difficulty");
            model.addAttribute("subjects", subjectRepository.findAll());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "admin/AddExam";
        }

        if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
            model.addAttribute("error", "End date must be after start date");
            model.addAttribute("subjects", subjectRepository.findAll());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "admin/AddExam";
        }

        exam.setSubject(subject);
        exam.setDifficulty(difficulty);
        exam.setSubjectName(subject.getSubjectName());
        exam.setCreatedBy(logged);

        exam.setNegativeMarking(negativeMarking != null ? negativeMarking : false);
        exam.setPassingScore(passingScore);
        exam.setStartDate(startDate);
        exam.setEndDate(endDate);

        if (exam.getStatus() == null) {
            exam.setStatus(ExamEntity.Status.ACTIVE);
        }

        examRepository.save(exam);
        return "redirect:/admin/exams";
    }

    // ================= PROFILE =================

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        model.addAttribute("userData", dbUser);
        return "admin/Profile";
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
        if (!isAdmin(session)) return "redirect:/login";

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
        return "admin/Profile";
    }

    // ================= CHANGE PASSWORD =================

    @GetMapping("/changePassword")
    public String changePasswordPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/ChangePassword";
    }

    @PostMapping("/updatePassword")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        UserEntity dbUser = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (dbUser == null) return "redirect:/login";

        if (!passwordEncoder.matches(currentPassword, dbUser.getPassword())) {
            model.addAttribute("error", "Current password is incorrect.");
            return "admin/ChangePassword";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New password and confirm password do not match.");
            return "admin/ChangePassword";
        }

        dbUser.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(dbUser);
        session.setAttribute("user", dbUser);

        model.addAttribute("success", "Password changed successfully.");
        return "admin/ChangePassword";
    }
}