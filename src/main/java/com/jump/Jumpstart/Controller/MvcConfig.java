package com.jump.Jumpstart.Controller;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class MvcConfig implements WebMvcConfigurer{
	
	 @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	        Path postUploadDir = Paths.get("./product-photo");
	        String postUploadPath = postUploadDir.toFile().getAbsolutePath();
	        
	        registry.addResourceHandler("/product-photo/**").addResourceLocations("file:/"+ postUploadPath + "/");
	    }

}
