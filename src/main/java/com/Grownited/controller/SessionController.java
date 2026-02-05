package com.Grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.UserEntity;

@Controller
public class SessionController {

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

        // Set default role for signup
        userEntity.setRole(UserEntity.Role.STUDENT);

        System.out.println(userEntity.getFirstName());
        System.out.println(userEntity.getLastName());

        return "Login";
    }
}
