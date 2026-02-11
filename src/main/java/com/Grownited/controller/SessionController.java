package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;

@Controller
public class SessionController {

    @Autowired
    UserRepository userRepository;

    @GetMapping("/signup")
    public String signup() {
        return "Signup";
    }

    @GetMapping("/login")
    public String login() {
        return "Login";
    }

    @GetMapping("/forgetPassword")
    public String forgetPassword() {
        return "ForgetPassword";
    }

    // SAVE USER
    @PostMapping("/register")
    public String register(UserEntity userEntity) {

        // prevent duplicate email
        if (userRepository.existsByEmail(userEntity.getEmail())) {
            return "Signup";
        }

        // default role
        userEntity.setRole(UserEntity.Role.STUDENT);

        userRepository.save(userEntity);

        return "redirect:/login";
    }
}
