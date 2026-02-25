package com.Grownited.controller;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;
import jakarta.servlet.http.HttpSession;

import java.util.Optional;

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
    public String register(@ModelAttribute UserEntity user, Model model) {

        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            model.addAttribute("error", "Email is required");
            return "Signup";
        }

        String email = user.getEmail().trim().toLowerCase();
        user.setEmail(email);

        if (userRepository.existsByEmail(email)) {
            model.addAttribute("error", "Email already registered");
            return "Signup";
        }

        if (user.getRole() == null) {
            user.setRole(UserEntity.Role.STUDENT);
        }

        if (user.getActive() == null) {
            user.setActive(true);
        }

        // plain password for now (BCrypt later)
        userRepository.save(user);

        return "redirect:/login";
    }

    // ================== LOGIN ==================

    @GetMapping("/login")
    public String openLoginPage() {
        return "Login";
    }

   
    
    // Authentication
    
    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email,
                               @RequestParam String password,
                               Model model,
                               HttpSession session) {

        String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();

        Optional<UserEntity> op = userRepository.findByEmail(cleanEmail);

        if (op.isPresent()) {
            UserEntity dbUser = op.get();

            // optional: active check
            if (dbUser.getActive() != null && dbUser.getActive() == false) {
                model.addAttribute("invalid", "Account is inactive");
                return "Login";
            }

            // password check
            if (dbUser.getPassword() != null && dbUser.getPassword().equals(password)) {

                // create session only after successful password check
                session.setAttribute("user", dbUser);

                // redirect by role (enum)
                if (dbUser.getRole() == UserEntity.Role.ADMIN) {
                    return "redirect:/admin/dashboard";
                } else if (dbUser.getRole() == UserEntity.Role.EXAMINER) {
                    return "redirect:/examiner/dashboard";
                } else {
                    return "redirect:/student/dashboard";
                }
            }
        }

        model.addAttribute("invalid", "Invalid email or password");
        return "Login";
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

        String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();

        Optional<UserEntity> op = userRepository.findByEmail(cleanEmail);

        if (op.isEmpty()) {
            model.addAttribute("error", "Email not found");
            return "ForgetPassword";
        }

        UserEntity user = op.get();
        user.setPassword(newPassword); // BCrypt later
        userRepository.save(user);

        return "redirect:/login";
    }

    // ================== LOGOUT ==================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}