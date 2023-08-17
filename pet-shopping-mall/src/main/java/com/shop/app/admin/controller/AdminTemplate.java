package com.shop.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminTemplate {
	
	@RequestMapping("/admin2")
    public String main(){

        return "index";
    }
}
