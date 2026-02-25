package com.Grownited.service;

import com.Grownited.entity.UserEntity;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailerService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendWelcomeMail(UserEntity user) {

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(user.getEmail());
            helper.setSubject("Welcome to ExamHammer");

            String name = (user.getFirstName() == null || user.getFirstName().trim().isEmpty())
                    ? "User"
                    : user.getFirstName().trim();

            String html = """
                <div style="background:#f2f4ff;padding:25px 0;font-family:Arial, sans-serif;">
                  <div style="max-width:520px;margin:0 auto;background:#ffffff;border:1px solid #e6e6e6;border-radius:12px;overflow:hidden;">
                    
                    <div style="background:#2f3cff;color:#ffffff;padding:18px 22px;">
                      <h2 style="margin:0;font-size:20px;">ExamHammer</h2>
                      <p style="margin:6px 0 0;font-size:13px;opacity:0.9;">Welcome email</p>
                    </div>

                    <div style="padding:22px;">
                      <p style="margin:0 0 12px;font-size:15px;color:#111;">
                        Hello <b>%s</b>,
                      </p>

                      <p style="margin:0 0 16px;font-size:14px;color:#333;line-height:1.5;">
                        Your account has been created successfully. You can now login and start using ExamHammer.
                      </p>

                      <div style="margin:18px 0;padding:14px;border:1px solid #eeeeee;background:#fafafa;border-radius:10px;">
                        <p style="margin:0;font-size:13px;color:#444;">
                          Tip: Keep your password safe and do not share it with anyone.
                        </p>
                      </div>

                      <a href="http://localhost:9999/login"
                         style="display:inline-block;margin-top:8px;background:#2f3cff;color:#ffffff;
                                text-decoration:none;padding:10px 16px;border-radius:8px;font-size:14px;">
                        Login Now
                      </a>

                      <p style="margin:20px 0 0;font-size:12px;color:#777;">
                        Regards,<br/>ExamHammer Team
                      </p>
                    </div>

                    <div style="background:#f7f7f7;padding:12px 22px;font-size:11px;color:#777;text-align:center;">
                      This is an automated email. Please do not reply.
                    </div>

                  </div>
                </div>
                """.formatted(name);

            helper.setText(html, true); // true = HTML

            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}