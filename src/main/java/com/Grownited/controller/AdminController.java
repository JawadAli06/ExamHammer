package com.Grownited.controller;

import com.Grownited.entity.DifficultyLevelEntity;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.SubjectEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.DifficultyLevelRepository;
import com.Grownited.repository.ExamRepository;
import com.Grownited.repository.SubjectRepository;
import com.Grownited.repository.UserRepository;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;


import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private UserRepository userRepository;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private ExamRepository examRepository;
    @Autowired private DifficultyLevelRepository difficultyRepository;
    
    // ================= DASHBOARD =================
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalSubjects", subjectRepository.count());
        model.addAttribute("totalExams", examRepository.count());
        model.addAttribute("activeExams", examRepository.countByStatus(ExamEntity.Status.ACTIVE));
        return "admin/AdminDashboard";
    }
    
   // @GetMapping("/dashboard")
   // public String dashboard() {
     //   return "admin/AdminDashboard";
   // }

    // ================= USER CRUD =================
    @GetMapping("/users")
    public String userList(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "admin/UserList";
    }

    @GetMapping("/users/add")
    public String addUserForm(Model model) {
        model.addAttribute("user", new UserEntity());
        return "admin/AddUser";
    }

    @PostMapping("/users/save")
    public String saveUser(@ModelAttribute UserEntity user) {
        if (user.getRole() == null) user.setRole(UserEntity.Role.STUDENT);
        if (user.getActive() == null) user.setActive(true);
        userRepository.save(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUser(@PathVariable Integer id, Model model) {
        model.addAttribute("user", userRepository.findById(id).orElse(null));
        return "admin/AddUser";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Integer id) {
        userRepository.deleteById(id);
        return "redirect:/admin/users";
    }

    // ================= SUBJECT CRUD =================
    @GetMapping("/subjects")
    public String subjectList(Model model) {
        model.addAttribute("subjects", subjectRepository.findAll());
        return "admin/SubjectList";
    }

    @GetMapping("/subjects/add")
    public String addSubjectPage(Model model) {
        model.addAttribute("subject", new SubjectEntity());
        return "admin/AddSubject";
    }

    // ✅ IMPORTANT: mapping is "/subjects/save" (NOT "/admin/subjects/save")
    @PostMapping("/subjects/save")
    public String saveSubject(@ModelAttribute SubjectEntity subject) {
        if (subject.getActive() == null) subject.setActive(true);
        subjectRepository.save(subject);
        return "redirect:/admin/subjects";
    }

    @GetMapping("/subjects/edit/{id}")
    public String editSubject(@PathVariable Integer id, Model model) {
        model.addAttribute("subject", subjectRepository.findById(id).orElse(null));
        return "admin/AddSubject";
    }

    // ✅ FIXED delete: use @PathVariable and soft delete
    @GetMapping("/subjects/delete/{id}")
    public String deleteSubject(@PathVariable Integer id) {
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
    public String examList(@RequestParam(required = false) ExamEntity.Status status, Model model) {
        if (status != null) model.addAttribute("exams", examRepository.findByStatus(status));
        else model.addAttribute("exams", examRepository.findAll());
        return "admin/ExamList";
    }
    
  // @GetMapping("/exams")
    //public String examList(Model model) {
      //  model.addAttribute("exams", examRepository.findAll());
        //return "admin/ExamList";
    //}

    @GetMapping("/exams/add")
    public String addExamForm(Model model) {
        model.addAttribute("exam", new ExamEntity());

        // you can use findAll() OR only active:
        model.addAttribute("subjects", subjectRepository.findAll());
        // model.addAttribute("subjects", subjectRepository.findByActiveTrue());

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

        System.out.println("SESSION USER = " + session.getAttribute("user"));
        UserEntity logged = (UserEntity) session.getAttribute("user");

        System.out.println("LOGGED = " + logged);
        System.out.println("ROLE   = " + (logged == null ? "null" : logged.getRole()));
        System.out.println("EMAIL  = " + (logged == null ? "null" : logged.getEmail()));
        System.out.println("SESSION ID = " + session.getId());

        // 1) Session check
        if (logged == null) return "redirect:/login";
        if (logged.getRole() != UserEntity.Role.ADMIN) return "redirect:/login";

        // 2) Fetch subject + difficulty
        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (subject == null || difficulty == null) {
            model.addAttribute("error", "Please select valid subject and difficulty");
            model.addAttribute("subjects", subjectRepository.findAll());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "admin/AddExam";
        }

        // Optional validation
        if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
            model.addAttribute("error", "End date must be after start date");
            model.addAttribute("subjects", subjectRepository.findAll());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "admin/AddExam";
        }

        // 3) Set relations
        exam.setSubject(subject);
        exam.setDifficulty(difficulty);

        // IMPORTANT: because exam.subject_name is NOT NULL in DB
        exam.setSubjectName(subject.getSubjectName());

        // created_by NOT NULL
        exam.setCreatedBy(logged);

        // 4) Fields
        exam.setNegativeMarking(negativeMarking != null ? negativeMarking : false);
        exam.setPassingScore(passingScore);
        exam.setStartDate(startDate);
        exam.setEndDate(endDate);

        // 5) Default status
        if (exam.getStatus() == null) {
            exam.setStatus(ExamEntity.Status.ACTIVE);
        }

        examRepository.save(exam);
        return "redirect:/admin/exams";
    }
    
   /* @PostMapping("/exams/save")
    public String saveExam(ExamEntity exam,
                           @RequestParam Integer subjectId,
                           @RequestParam Integer difficultyId,
                           
                           HttpSession session,
                           Model model) {
    	
    	System.out.println("SESSION USER = " + session.getAttribute("user"));
    	UserEntity logged = (UserEntity) session.getAttribute("user");

    	System.out.println("LOGGED = " + logged);
    	System.out.println("ROLE   = " + (logged == null ? "null" : logged.getRole()));
    	System.out.println("EMAIL  = " + (logged == null ? "null" : logged.getEmail()));
    	System.out.println("SESSION ID = " + session.getId());
        // 1) Session check
    	
        //UserEntity logged = (UserEntity) session.getAttribute("user");
        if (logged == null) {
            return "redirect:/login";
        }
        if (logged.getRole() != UserEntity.Role.ADMIN) {
            return "redirect:/login";
        }

        // 2) Fetch subject + difficulty
        SubjectEntity subject = subjectRepository.findById(subjectId).orElse(null);
        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId).orElse(null);

        if (subject == null || difficulty == null) {
            model.addAttribute("error", "Please select valid subject and difficulty");
            model.addAttribute("subjects", subjectRepository.findAll());
            model.addAttribute("difficulties", difficultyRepository.findAll());
            return "admin/AddExam";
        }

     // 3) Set relations
        exam.setSubject(subject);
        exam.setDifficulty(difficulty);
        
      
        // IMPORTANT: because exam.subject_name is NOT NULL in DB
        exam.setSubjectName(subject.getSubjectName());

        // IMPORTANT: created_by is NOT NULL in DB
        exam.setCreatedBy(logged);
        
        // 5) Default status
        if (exam.getStatus() == null) {
            exam.setStatus(ExamEntity.Status.ACTIVE);
        }

        examRepository.save(exam);
        return "redirect:/admin/exams";
    }*/

    // ✅ IMPORTANT: mapping is "/exams/save" (NOT "/admin/exams/save")
  /*  @PostMapping("/exams/save")
    public String saveExam(@ModelAttribute ExamEntity exam,
                           @RequestParam("subjectId") Integer subjectId,
                           @RequestParam("difficultyId") Integer difficultyId,
                           HttpSession session) {

        UserEntity admin = (UserEntity) session.getAttribute("user");
        if (admin == null) return "redirect:/login";

        SubjectEntity subject = subjectRepository.findById(subjectId)
                .orElseThrow(() -> new RuntimeException("Invalid subjectId: " + subjectId));

        DifficultyLevelEntity difficulty = difficultyRepository.findById(difficultyId)
                .orElseThrow(() -> new RuntimeException("Invalid difficultyId: " + difficultyId));

        exam.setSubject(subject);
        exam.setSubjectName(subject.getSubjectName()); // IMPORTANT (DB needs subject_name)
        exam.setDifficulty(difficulty);
      


        // ✅ REQUIRED because created_by is nullable=false in entity/table
        exam.setCreatedBy(admin);

        if (exam.getStatus() == null) exam.setStatus(ExamEntity.Status.ACTIVE);

        examRepository.save(exam);
        return "redirect:/admin/exams";
    }*/

    @GetMapping("/exams/edit/{id}")
    public String editExam(@PathVariable Integer id, Model model) {
        model.addAttribute("exam", examRepository.findById(id).orElse(null));
        model.addAttribute("subjects", subjectRepository.findAll());
        model.addAttribute("difficulties", difficultyRepository.findAll());
        return "admin/AddExam";
    }

    @GetMapping("/exams/delete/{id}")
    public String deleteExam(@PathVariable Integer id) {
        examRepository.deleteById(id);
        return "redirect:/admin/exams";
    }
    
    
 // ================= PROFILE =================
    @GetMapping("/profile")
    public String profilePage() {
        return "admin/Profile";  // create Profile.jsp
    }

    
    
    
}