package com.example.springmarket.model.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSession session;

	@Override
	public String login(String userid, String passwd) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		return session.selectOne("member.login", map);
	}

	@Override
	public void join(MemberDTO dto) {
		session.insert("member.join", dto);
	}

	@Override
	public int loginCheck(String userid, String passwd) {
		Map<String,Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		return session.selectOne("member.loginCheck", map);
	}

	@Override
	public String check(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.check", userid);
	}

	@Override
	public String address(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.address", userid);
	}

	@Override
	public MemberDTO mypage(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.mypage", userid);
	}

	@Override
	public void updateMypage(MemberDTO dto) {
		session.update("member.update_mypage", dto);

	}

	@Override
	public String nicknamecheck(String nickname) {
		// TODO Auto-generated method stub
		return session.selectOne("member.nicknamecheck", nickname);
	}

	@Override
	public List<Object> info() {
		// TODO Auto-generated method stub
		return session.selectList("member.info");
	} 

	@Override
	public void updateReport(MemberDTO dto) {
		session.update("member.changeReport", dto);

	}

	@Override
	public String emailcheck(String email) {
		// TODO Auto-generated method stub
		return session.selectOne("member.emailcheck", email);
	}

	@Override
	public String email(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.email", userid);
	}

	@Override
	public String encrypt(String pwd) {
		String salt = "gagimama";
		String result = "";
		try {
			// 1. SHA256 알고리즘 객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			// 2. 비밀번호와 salt 합친 문자열에 SHA 256 적용
			md.update((pwd + salt).getBytes());
			byte[] pwdsalt = md.digest();
			// 3. byte To String (10진수의 문자열로 변경)
			StringBuffer sb = new StringBuffer();
			for (byte b : pwdsalt) {
				sb.append(String.format("%02x", b));
			}
			result = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String findId(String name, String birth, String phone) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("birth", birth);
		map.put("phone", phone);
		return session.selectOne("member.findId", map);
	}

	@Override
	public void findPwd(String userid, String passwd) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		session.update("member.findPwd", map);
	}

	@Override
	public String email_id(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.email_id", userid);
	}

	@Override
	public String mypasswd(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("member.mypasswd", userid);
	}

}
