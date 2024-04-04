package com.example.springmarket.model.quiz;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AnswerDTO {
	private String userid;
	private int num1;
	private int num2;
	private int num3;
	private int num4;
	
}
