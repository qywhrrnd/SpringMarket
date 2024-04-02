package com.example.springmarket.model.member;

import java.util.List;


public interface MemberDAO {

	String login(String userid, String passwd);

	void join(MemberDTO dto);

	int loginCheck(MemberDTO dto);

	String check(String userid);

	String address(String userid);

	MemberDTO mypage(String userid);

	void updateMypage(MemberDTO dto);

	String nicknamecheck(String nickname);

	List<Object> info();
	
	void updateReport(MemberDTO dto);
	
	String emailcheck(String email);
	
	String email(String userid);
	
	String encrypt(String pwd);
	
	String findId(String name, String birth, String phone);
	
	void findPwd(String userid, String passwd);
	
	String email_id(String userid);
	
	String mypasswd(String userid);
}
