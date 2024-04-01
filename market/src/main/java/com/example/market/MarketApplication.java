package com.example.market;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MarketApplication {
@Bean
	public static void main(String[] args) {
		SpringApplication.run(MarketApplication.class, args);
	}

}
