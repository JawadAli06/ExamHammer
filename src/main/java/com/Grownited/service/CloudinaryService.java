package com.Grownited.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;

    public String uploadProfilePic(MultipartFile file) throws IOException {

        // Upload to Cloudinary under folder "examhammer/profiles"
        Map<?, ?> result = cloudinary.uploader().upload(
            file.getBytes(),
            ObjectUtils.asMap(
                "folder",          "examhammer/profiles",
                "resource_type",   "image",
                "transformation",  "w_200,h_200,c_fill,g_face,r_max"
            )
        );

        // Return the secure HTTPS URL of uploaded image
        return result.get("secure_url").toString();
    }
}