package com.Grownited.controller;

import com.Grownited.entity.QuestionBankEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.ExamRepository;
import com.Grownited.repository.QuestionBankRepository;
import com.Grownited.repository.SubjectRepository;
import com.Grownited.entity.ExamEntity;
import com.Grownited.entity.SubjectEntity;


import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/examiner")
public class ExaminerController {

    @Autowired
    private QuestionBankRepository questionBankRepository;

    @Autowired
    private ExamRepository examRepository;
    
    @Autowired
    private SubjectRepository subjectRepository;
    
    

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        if (examiner == null) return "redirect:/login";

        model.addAttribute("totalQuestions", questionBankRepository.count());
        model.addAttribute("myExams", examRepository.findByCreatedBy(examiner).size());

        return "examiner/ExaminerDashboard";
    }

    @GetMapping("/questions")
    public String questionList(@RequestParam(required = false) Integer examId,
                               Model model,
                               HttpSession session) {

        UserEntity examiner = (UserEntity) session.getAttribute("user");
        if (examiner == null) return "redirect:/login";

        if (examId != null) {
            model.addAttribute("questions", questionBankRepository.findByExam_ExamId(examId));
        } else {
            model.addAttribute("questions", questionBankRepository.findAll());
        }

        model.addAttribute("selectedExamId", examId);
        return "examiner/QuestionList";
    }
    
   
   // @GetMapping("/questions")
   // public String questionList(Model model) {
     //   model.addAttribute("questions", questionBankRepository.findAll());
     //   return "examiner/QuestionList";
   // }
    
    @GetMapping("/addQuestion")
    public String addQuestionPage(@RequestParam(required = false) Integer examId, Model model) {
        model.addAttribute("exams", examRepository.findAll());
        model.addAttribute("subjects", subjectRepository.findAll());
        model.addAttribute("selectedExamId", examId);
        return "examiner/AddQuestion";
    }
    
   // @GetMapping("/addQuestion")
    //public String addQuestionPage(Model model) {
      //  model.addAttribute("exams", examRepository.findAll());
        //model.addAttribute("subjects", subjectRepository.findAll());
        //return "examiner/AddQuestion";
    //}

   // @GetMapping("/addQuestion")
    //public String addQuestionPage() {
       // return "examiner/AddQuestion";
   // }

    @PostMapping("/saveQuestion")
    public String saveQuestion(@RequestParam Integer examId,
                               @RequestParam Integer subjectId,
                               @RequestParam String questionText,
                               @RequestParam String optionA,
                               @RequestParam String optionB,
                               @RequestParam String optionC,
                               @RequestParam String optionD,
                               @RequestParam String correctOption,
                               @RequestParam Integer marks,
                               Model model,
                               HttpSession session) {

        UserEntity examiner = (UserEntity) session.getAttribute("user");
        if (examiner == null) return "redirect:/login";

        ExamEntity exam = examRepository.findById(examId).orElse(null);
        var subject = subjectRepository.findById(subjectId).orElse(null);

        if (exam == null || subject == null) {
            model.addAttribute("error", "Please select valid exam and subject.");
            model.addAttribute("exams", examRepository.findByCreatedBy(examiner));
            model.addAttribute("subjects", subjectRepository.findAll());
            return "examiner/AddQuestion";
        }

        // protection: examiner should only add to own exams
        if (exam.getCreatedBy() == null || !exam.getCreatedBy().getUserId().equals(examiner.getUserId())) {
            return "redirect:/login";
        }

        var q = new com.Grownited.entity.QuestionBankEntity();
        q.setExam(exam);
        q.setSubject(subject);
        q.setQuestionText(questionText);
        q.setOptionA(optionA);
        q.setOptionB(optionB);
        q.setOptionC(optionC);
        q.setOptionD(optionD);
        q.setCorrectOption(correctOption);
        q.setMarks(marks);

        questionBankRepository.save(q);

        return "redirect:/examiner/questions?examId=" + examId;
    }
    
    
  /*  @PostMapping("/saveQuestion")
    public String saveQuestion(@RequestParam String questionText,
                               @RequestParam Integer marks) {

        QuestionBankEntity q = new QuestionBankEntity();
        q.setQuestionText(questionText);
        q.setMarks(marks);

        questionBankRepository.save(q);
        return "redirect:/examiner/questions";
    }

    public QuestionBankRepository getQuestionBankRepository() {
		return questionBankRepository;
	}

	public void setQuestionBankRepository(QuestionBankRepository questionBankRepository) {
		this.questionBankRepository = questionBankRepository;
	}

	public ExamRepository getExamRepository() {
		return examRepository;
	}

	public void setExamRepository(ExamRepository examRepository) {
		this.examRepository = examRepository;
	}*/

    @GetMapping("/questions/edit/{id}")
    public String editQuestionPage(@PathVariable Integer id, Model model, HttpSession session) {
        UserEntity examiner = (UserEntity) session.getAttribute("user");
        if (examiner == null) return "redirect:/login";

        var q = questionBankRepository.findById(id).orElse(null);
        if (q == null) return "redirect:/examiner/questions";

        model.addAttribute("question", q);
        model.addAttribute("exams", examRepository.findByCreatedBy(examiner));
        model.addAttribute("subjects", subjectRepository.findAll());
        return "examiner/EditQuestion";
    }
    
    
    @PostMapping("/questions/update")
    public String updateQuestion(@RequestParam Integer questionId,
                                 @RequestParam Integer examId,
                                 @RequestParam Integer subjectId,
                                 @RequestParam String questionText,
                                 @RequestParam String optionA,
                                 @RequestParam String optionB,
                                 @RequestParam String optionC,
                                 @RequestParam String optionD,
                                 @RequestParam String correctOption,
                                 @RequestParam Integer marks,
                                 HttpSession session,
                                 Model model) {

        UserEntity examiner = (UserEntity) session.getAttribute("user");
        if (examiner == null) return "redirect:/login";

        var q = questionBankRepository.findById(questionId).orElse(null);
        var exam = examRepository.findById(examId).orElse(null);
        var subject = subjectRepository.findById(subjectId).orElse(null);

        if (q == null || exam == null || subject == null) {
            return "redirect:/examiner/questions";
        }

        q.setExam(exam);
        q.setSubject(subject);
        q.setQuestionText(questionText);
        q.setOptionA(optionA);
        q.setOptionB(optionB);
        q.setOptionC(optionC);
        q.setOptionD(optionD);
        q.setCorrectOption(correctOption);
        q.setMarks(marks);

        questionBankRepository.save(q);

        return "redirect:/examiner/questions?examId=" + examId;
    }
    
    
	@GetMapping("/deleteQuestion/{id}")
    public String deleteQuestion(@PathVariable Integer id) {
        questionBankRepository.deleteById(id);
        return "redirect:/examiner/questions";
    }

	@GetMapping("/exams")
	public String examinerExams(Model model, HttpSession session) {
	    UserEntity examiner = (UserEntity) session.getAttribute("user");
	    if (examiner == null) return "redirect:/login";

	    model.addAttribute("exams", examRepository.findAll());
	   // model.addAttribute("exams", examRepository.findByStatus(ExamEntity.Status.ACTIVE));
	    return "examiner/ExamList";
	}

    @GetMapping("/profile")
    public String profilePage() {
        return "examiner/Profile";
    }

    @GetMapping("/changePassword")
    public String changePasswordPage() {
        return "examiner/ChangePassword";
    }
    
}