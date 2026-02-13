package com.Grownited.controller;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class SessionController {

    @Autowired
    private UserRepository userRepository;

    // ================== SIGNUP ==================

    @GetMapping("/signup")
    public String openSignupPage() {
        return "Signup";
    }

    @PostMapping("/register")
    public String register(UserEntity user, Model model) {

        if (userRepository.existsByEmail(user.getEmail())) {
            model.addAttribute("error", "Email already registered");
            return "Signup";
        }

        // Default role (optional if you allow selection)
        if (user.getRole() == null) {
            user.setRole(UserEntity.Role.STUDENT);
        }

        userRepository.save(user);
        model.addAttribute("success", "Registration successful. Please login.");

        return "Login";
    }

    // ================== LOGIN ==================

    @GetMapping("/login")
    public String openLoginPage() {
        return "Login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        UserEntity user = userRepository.findByEmail(email);

        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid email or password");
            return "Login";
        }

        session.setAttribute("user", user);

        if (user.getRole() == UserEntity.Role.ADMIN) {
            return "redirect:/admin/dashboard";
        } else if (user.getRole() == UserEntity.Role.EXAMINER) {
            return "redirect:/examiner/dashboard";
        } else {
            return "redirect:/student/dashboard";
        }
    }

    // ================== FORGET PASSWORD ==================

    @GetMapping("/forgetPassword")
    public String openForgetPasswordPage() {
        return "ForgetPassword";
    }

    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam String email,
                                @RequestParam String newPassword,
                                Model model) {

        UserEntity user = userRepository.findByEmail(email);

        if (user == null) {
            model.addAttribute("error", "Email not found");
            return "ForgetPassword";
        }

        user.setPassword(newPassword);
        userRepository.save(user);

        model.addAttribute("success", "Password updated successfully. Please login.");
        return "Login";
    }

    // ================== LOGOUT ==================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
