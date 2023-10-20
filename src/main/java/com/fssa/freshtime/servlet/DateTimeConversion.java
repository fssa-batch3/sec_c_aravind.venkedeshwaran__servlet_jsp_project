package com.fssa.freshtime.servlet;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeConversion {
	public static void main(String[] args) {
		// Input date and time in the format "September 29, 2023 4:00 pm"
		String inputDateTime = "October 19, 2023 10:00 am";

		// Define a formatter for the input format
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("MMMM d, yyyy h:mm a");

		// Parse the input date and time
		LocalDateTime dateTime = LocalDateTime.parse(inputDateTime, inputFormatter);

		// Print the resulting LocalDateTime
		System.out.println(dateTime);
	}
}
