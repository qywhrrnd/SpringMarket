package com.example.springmarket.model.member;

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
public class MemberDTO {
	private String userid;
	private String passwd;
	private String name;
	private String nickname;
	private int birth;
	private String phone;
	private String email;
	private String address;
	private int report_code;
	private String report_type;

}
