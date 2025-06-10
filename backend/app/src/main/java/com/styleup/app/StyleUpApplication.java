package com.styleup.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootVersion;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Main application for StyleUp Project.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
@SpringBootApplication
@EnableScheduling
public class StyleUpApplication {

	public static void main(String[] args) {
		SpringApplication.run(StyleUpApplication.class, args);
	}

}
