package com.example.springmarket.model.email;

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

public class EmailDTO {
	private String senderName;
	private String senderMail;
	private String email;
	private String userid;
	private String subject;
	private String message;
	

}
