package com.Grownited.controller;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.CloudinaryService;
import com.Grownited.service.MailerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

@Controller
public class SessionController {

    @Autowired private UserRepository userRepository;
    @Autowired private MailerService mailerService;
    @Autowired private BCryptPasswordEncoder passwordEncoder;
    @Autowired private CloudinaryService cloudinaryService;

    // ================== SIGNUP ==================

    @GetMapping("/signup")
    public String openSignupPage() {
        return "Signup";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam("firstName")  String firstName,
            @RequestParam("lastName")   String lastName,
            @RequestParam("email")      String email,
            @RequestParam("password")   String password,
            @RequestParam("gender")     String gender,
            @RequestParam("contactNum") String contactNum,
            @RequestParam("birthYear")  Integer birthYear,
            @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
            Model model) {

        // Validate email
        String cleanEmail = email.trim().toLowerCase();
        if (cleanEmail.isEmpty()) {
            model.addAttribute("error", "Email is required");
            return "Signup";
        }

        if (userRepository.existsByEmail(cleanEmail)) {
            model.addAttribute("error", "Email already registered");
            return "Signup";
        }

        // Build user
        UserEntity user = new UserEntity();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(cleanEmail);
        user.setPassword(passwordEncoder.encode(password));
        user.setGender(gender);
        user.setContactNum(contactNum);
        user.setBirthYear(birthYear);
        user.setRole(UserEntity.Role.STUDENT);
        user.setActive(true);

        // Upload profile pic to Cloudinary if provided
        if (profilePic != null && !profilePic.isEmpty()) {
            try {
                String picUrl = cloudinaryService.uploadProfilePic(profilePic);
                user.setProfilePicURL(picUrl);
            } catch (Exception e) {
                // Don't block signup if upload fails — just skip pic
                System.err.println("Cloudinary upload failed: " + e.getMessage());
            }
        }

        userRepository.save(user);
        mailerService.sendWelcomeMail(user);

        return "redirect:/login";
    }

    // ================== LOGIN ==================

    @GetMapping("/login")
    public String openLoginPage() {
        return "Login";
    }

    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email,
                               @RequestParam String password,
                               Model model,
                               HttpSession session) {

        String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();
        Optional<UserEntity> op = userRepository.findByEmail(cleanEmail);

        if (op.isEmpty()) {
            model.addAttribute("invalid", "Invalid email or password");
            return "Login";
        }

        UserEntity dbUser = op.get();

        if (dbUser.getActive() != null && !dbUser.getActive()) {
            model.addAttribute("invalid", "Account is inactive");
            return "Login";
        }

        if (dbUser.getPassword() == null ||
            !passwordEncoder.matches(password, dbUser.getPassword())) {
            model.addAttribute("invalid", "Invalid email or password");
            return "Login";
        }

        // Store full user (with profilePicURL) in session
        session.setAttribute("user", dbUser);

        if (dbUser.getRole() == UserEntity.Role.ADMIN) {
            return "redirect:/admin/dashboard";
        } else if (dbUser.getRole() == UserEntity.Role.EXAMINER) {
            return "redirect:/examiner/dashboard";
        } else {
            return "redirect:/student/dashboard";
        }
    }

    // ================== FORGET PASSWORD ==================

    @GetMapping("/forget-password")
    public String openForgetPasswordPage() {
        System.out.println("Forget Password HIT");
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
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        return "redirect:/login";
    }

    @PostMapping("/sendOtp")
    public String sendOtp(@RequestParam String email,
                          Model model, HttpSession session) {
        String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();
        Optional<UserEntity> op = userRepository.findByEmail(cleanEmail);
        if (op.isEmpty()) {
            model.addAttribute("error", "Email not found");
            return "ForgetPassword";
        }
        UserEntity user = op.get();
        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
        user.setOtp(otp);
        userRepository.save(user);
        session.setAttribute("otpEmail", cleanEmail);
        session.setAttribute("otpTime", System.currentTimeMillis());
        mailerService.sendOtpMail(user.getEmail(), user.getFirstName(), otp);
        model.addAttribute("msg", "OTP sent to your email");
        return "VerifyOtp";
    }

    @PostMapping("/verifyOtpAndReset")
    public String verifyOtpAndReset(@RequestParam String otp,
                                    @RequestParam String newPassword,
                                    Model model, HttpSession session) {
        Object emailObj = session.getAttribute("otpEmail");
        Object timeObj  = session.getAttribute("otpTime");

        if (emailObj == null || timeObj == null) {
            model.addAttribute("error", "Session expired. Please try again.");
            return "ForgetPassword";
        }

        String email   = emailObj.toString();
        long otpTime   = (long) timeObj;

        if (System.currentTimeMillis() - otpTime > 10 * 60 * 1000) {
            model.addAttribute("error", "OTP expired. Please request again.");
            return "ForgetPassword";
        }

        Optional<UserEntity> op = userRepository.findByEmail(email);
        if (op.isEmpty()) {
            model.addAttribute("error", "User not found");
            return "ForgetPassword";
        }

        UserEntity user = op.get();
        if (user.getOtp() == null || !user.getOtp().equals(otp)) {
            model.addAttribute("error", "Invalid OTP");
            return "VerifyOtp";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setOtp(null);
        userRepository.save(user);
        session.removeAttribute("otpEmail");
        session.removeAttribute("otpTime");
        return "redirect:/login";
    }

    // ================== LOGOUT ==================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}