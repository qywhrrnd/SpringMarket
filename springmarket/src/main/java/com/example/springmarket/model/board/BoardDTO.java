package com.example.springmarket.model.board;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	private int num;
	private String userid;
	private String nickname;
	private String subject;
	private String content;
	private Date reg_date;
	private int hit;
	private int rn;
}

