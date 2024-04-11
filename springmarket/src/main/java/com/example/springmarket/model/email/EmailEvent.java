package com.example.springmarket.model.email;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class EmailEvent {
	public void mailSender3(EmailDTO dto) throws Exception {
	      String host = "smtp.gmail.com";
	      String username = "rhwls159";
	      String password = "wpuf maza ynqd saib";
	      int port = 587;

	      String senderMail = "rhwls159@naver.com";
	      String senderName ="가지나라";
	      String recipient = dto.getEmail();
	      String subject = "가지나라 이벤트 당첨";
	      String body =
	      "<html>" +
	        "<body>" +
	        "<div align='center'>" +            
	        "<h2>축하합니다~</h2>" +
	        "<hr>"+
	        "<img src='https://mblogthumb-phinf.pstatic.net/MjAyMTAyMjhfMjI1/MDAxNjE0NTAxNTM3NjM1.aUs7L9fjpf3af7vMM4OXjcc37WAU4n36f05GbZdlUl4g.ENivieAGg3UxurJmiBPN773jZdgvIa3Ue_6pG_67WXwg.JPEG.mercigod0422/SE-86131F65-2491-4969-A4F3-2570E0F9754F.jpg?type=w800'>" +
	        "<div>가지나라의 이벤트에 참여해주셔서 감사합니다</div>"+
	        "<div></div>"+
	        "<div>정답을 모두 맞추셔서 감사의 의미로 소정의 선물을 드립니다</div>"+
	        "<div>자세한 사용방법은 상품설명 참고 바랍니다</div>"+
	        "<div>가지나라는 언제나 당신 곁에 있습니다 gagi is near </div>"+
	        "<a href='http://localhost//member/pagelogin.do'>로그인</a></p>" +
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
