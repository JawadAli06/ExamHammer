package com;
import java.security.PublicKey;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.cloudinary.Cloudinary;
@SpringBootApplication
public class ExamHammerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ExamHammerApplication.class, args);
	}
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
	    return new BCryptPasswordEncoder();
	}
	
	@Bean
	Cloudinary getCloudinary() {
		Map<String, String> config = new HashMap<>();
		config.put("cloud_name", "dcgmpdcay");
		config.put("api_key", "332456293915496");
		config.put("api_secret", "pcq4IS1NSPvG11tpQJxjiKj0e6U");
		return new Cloudinary(config);
	}

	
}





