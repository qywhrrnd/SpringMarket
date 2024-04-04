package com.example.springmarket.controller.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.member.MemberDAO;
import com.example.springmarket.model.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
    @Autowired
    MemberDAO memberDao;

    @GetMapping("member/pagelogin.do")
    public ModelAndView login() {
        return new ModelAndView("member/login");
    }

    @GetMapping("member/pagejoin.do")
    public ModelAndView join() {
        return new ModelAndView("member/join");
    }

    @PostMapping("member/login.do")
    public ModelAndView login_check(@RequestParam(name = "userid") String userid,
                                    @RequestParam(name = "passwd") String passwd, HttpSession session) {
        String pass = memberDao.encrypt(passwd);
        String nickname = memberDao.login(userid, pass);
        String message = "";
        String url = "";
        if (nickname == null) { // 로그인 실패
            message = "로그인 정보가 정확하지 않습니다.";
            url = "member/login";
        } else { // 로그인 성공
            message = nickname + "님 환영합니다.";
            url = "main/main";
            // 세션변수 등록
            session.setAttribute("userid", userid);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("message", message);
        return new ModelAndView(url, "map", map);
    }

    @GetMapping("member/logout.do")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화
        return "redirect:/member/pagelogin.do";
    }

    @PostMapping("member/join.do")
    public String join(@RequestParam(name = "userid") String userid,
                       @RequestParam(name = "passwd") String passwd,
                       @RequestParam(name = "name") String name,
                       @RequestParam(name = "nickname") String nickname,
                       @RequestParam(name = "birth") int birth,
                       @RequestParam(name = "phone") String phone,
                       @RequestParam(name = "email") String email,
                       @RequestParam(name = "address1") String address1,
                       @RequestParam(name = "address2") String address2)
    {
        String address = address1 + address2;
        String pass = memberDao.encrypt(passwd);
        MemberDTO dto = new MemberDTO();
        dto.setUserid(userid);
        dto.setPasswd(pass);
        dto.setName(name);
        dto.setNickname(nickname);
        dto.setBirth(birth);
        dto.setPhone(phone);
        dto.setEmail(email);
        dto.setAddress(address);
        memberDao.join(dto); // document 저장
        return "redirect:/member/pagelogin.do";
    }

    @GetMapping("member/pagefindId.do")
    public ModelAndView pagefindId() {
        return new ModelAndView("member/findid");
    }

    @GetMapping("member/pagefindPwd.do")
    public ModelAndView pagefindPwd() {
        return new ModelAndView("member/findpwd");
    }

    // 비밀번호 변경 메소드로 변경
    @PostMapping("member/findPwd.do")
    public String changePwd(@RequestParam(name = "userid") String userid) {
        // TODO: 비밀번호 변경 로직 수행
        String pwd = memberDao.encrypt("a12345");
        System.out.println(pwd);
        memberDao.findPwd(userid, pwd);

        return "redirect:/member/pagelogin.do";
    }

    // RESTful API 엔드포인트로 변경
    @PostMapping("member/findId.do")
    public ResponseEntity<Map<String, Object>> findId(@RequestParam(name = "name") String name,
                                                      @RequestParam(name = "birth") String birth,
                                                      @RequestParam(name = "phone") String phone) {
        String userid = memberDao.findId(name, birth, phone);
        String message = "";
        String url = "";
        if(userid == null) {
            message = "로그인 정보가 정확하지 않습니다.";
            url = "/member/pagefindId.do";
        }else {
            message = "당신의 아이디는 " + userid + "입니다.";
            url = "/member/pagelogin.do";
        }
        Map<String, Object> map = new HashMap<>();
        map.put("message", message);
        map.put("url", url);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
    
    @PostMapping("member/check.do")
    public ResponseEntity<String> check(@RequestParam(name = "userid") String userid) {
        // TODO: 비밀번호 변경 로직 수행
        String count = memberDao.check(userid);
        if (count == null) {
            count = "true"; // count가 null이면 "true" 문자열로 설정
        }
        System.out.println(count);
        return new ResponseEntity<>(count, HttpStatus.OK);
    }
    
    @PostMapping("member/emailcheck.do")
    public ResponseEntity<String> emailcheck(@RequestParam(name = "email") String email) {
        // TODO: 비밀번호 변경 로직 수행
        String count1 = memberDao.emailcheck(email);
        if (count1 == null) {
            count1= "true"; // count가 null이면 "true" 문자열로 설정
        }
        System.out.println(count1);
        return new ResponseEntity<>(count1, HttpStatus.OK);
    }
}
