package com.example.springmarket.model.quiz;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class QuizDTO {
	private int quiz_idx;
	private String question;
	private String ans1;
	private String ans2;
	private String ans3;
	private String ans4;
	private int status;

}
