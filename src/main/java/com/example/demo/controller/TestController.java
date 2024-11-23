package com.example.demo.controller;

import com.example.demo.config.ValueConfig;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.net.InetAddress;
import java.net.UnknownHostException;

@Controller
@RequiredArgsConstructor
public class TestController {

    private final ValueConfig valueConfig;

    @GetMapping("")
    public String index(
            HttpServletRequest request,
            Model model
    ) throws UnknownHostException {
        String address = InetAddress.getLocalHost().getHostAddress();
        int serverPort = request.getServerPort();

        model.addAttribute("address", address);
        model.addAttribute("serverPort", serverPort);
        model.addAttribute("text", valueConfig.getPropertyText());
        return "index";
    }

}
