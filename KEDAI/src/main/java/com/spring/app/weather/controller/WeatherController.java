package com.spring.app.weather.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/weather/*")
public class WeatherController {

	@GetMapping("weatherXML.kedai")
	public String weatherXML() {
		
		return "weather/weatherXML";
	}
}
