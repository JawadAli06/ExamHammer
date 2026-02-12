package com.Grownited.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;

@Controller
public class SessionController {

    @Autowired
    private UserRepository userRepository;

    // ========================
    // SIGNUP
    // ========================
    @GetMapping("/signup")
    public String signup() {
        return "Signup";
    }

    // ========================
    // LOGIN PAGE
    // ========================
    @GetMapping("/login")
    public String login() {
        return "Login";
    }

    // ========================
    // FORGET PASSWORD
    // ========================
    @GetMapping("/forgetPassword")
    public String forgetPassword() {
        return "ForgetPassword";
    }

    // ========================
    // REGISTER USER
    // ========================
    @PostMapping("/register")
    public String register(UserEntity userEntity) {

        if (userRepository.existsByEmail(userEntity.getEmail())) {
            return "Signup";
        }

        userEntity.setRole(UserEntity.Role.STUDENT);
        userEntity.setActive(true);

        userRepository.save(userEntity);

        return "redirect:/login";
    }

    // ========================
    // LOGIN USER
    // ========================
    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session) {

        UserEntity user = userRepository.findByEmail(email);

        if (user == null || !user.getPassword().equals(password)) {
            return "Login";
        }

        if (!user.getActive()) {
            return "Login";
        }

        // store user in session
        session.setAttribute("loggedUser", user);

        // role-based redirection
        if (user.getRole() == UserEntity.Role.ADMIN) {
            return "redirect:/admin/dashboard";
        } 
        else if (user.getRole() == UserEntity.Role.EXAMINER) {
            return "redirect:/examiner/dashboard";
        } 
        else {
            return "redirect:/student/dashboard";
        }
    }

    // ========================
    // LOGOUT
    // ========================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
