package com.khoa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication(scanBasePackages = {"com.khoa"})
@EnableAspectJAutoProxy(proxyTargetClass=true)
public class App {
    public static void main(String[] args){
        SpringApplication.run(App.class, args);
    }
}
