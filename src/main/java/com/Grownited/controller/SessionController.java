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
    private UserRepository userRepository;

    @GetMapping("/signup")
    public String openSignupPage() {
        return "Signup";
    }

    @GetMapping("/login")
    public String openLoginpage() {
        return "Login";
    }

    @GetMapping("/forgetPassword")
    public String openForgetPassword() {
        return "ForgetPassword";
    }

    @PostMapping("/register")
    public String register(UserEntity userEntity) {

        // default role for signup
        userEntity.setRole(UserEntity.Role.STUDENT);
        userEntity.setActive(true);

        // save to database
        userRepository.save(userEntity);

        return "Login";
    }
}
