package com.example.springmarket.model.email;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailFindPwd {
	public void mailSender2(EmailDTO dto) throws Exception {
	      String host = "smtp.gmail.com";
	      String username = "rhwls159";
	      String password = "wpuf maza ynqd saib";
	      int port = 587;

	      String senderMail = "rhwls159@naver.com";
	      String senderName ="가지나라";
	      String recipient = dto.getEmail();
	      String subject = "가지나라 임시 비밀번호 설정 메일";
	      String body =
	      "<html>" +
	        "<body>" +
	        "<div align='center'>" +            
	        "<h2>임시 비밀번호 발급</h2>" +
	        "<hr>"+
	        "<img src='https://ogq-sticker-global-cdn-z01.afreecatv.com/sticker/16f23d18dca64b7/main.png'>" +
	        "<div>임시 비밀번호 발급을 완료하였습니다.</div>"+
	        "<div> 현재 비밀번호가 a123456789 로 변경되었습니다.</div>"+
	        "<div> 내 정보에서 비밀번호를 다시 변경해주시길 바랍니다.</div>"+
	        "<div>가지나라는 언제나 당신 곁에 있습니다 gagi is near </div>"+
	        "<a href='http://localhost/market/login/login.jsp'>로그인</a></p>" +
	        "</div>"+
	        "</body>" +
	        "</html>";
	      Properties props = System.getProperties();
	      props.put("mail.smtp.host", host);
	      props.put("mail.smtp.port", port);
	      props.put("mail.transport.protocol", "smtp");
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.ssl.protocols", "TLSv1.2");

	      Session session = Session.getDefaultInstance(props, new Authenticator() {
	         String un = username;
	         String pw = password;

	         
	         protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(un, pw);
	         }
	      });
	      session.setDebug(true);
	      Message mimeMessage = new MimeMessage(session);
	      mimeMessage.addFrom(new InternetAddress[] { new InternetAddress(senderMail, senderName) });//
	      mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));//수신자 주소
	      mimeMessage.setSubject(subject);
	      mimeMessage.setContent(body, "text/html; charset=utf-8");
	      Transport.send(mimeMessage);

	   }
}
