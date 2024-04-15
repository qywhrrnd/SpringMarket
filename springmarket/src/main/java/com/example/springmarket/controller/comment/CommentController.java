package com.example.springmarket.controller.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.comment.CommentDAO;
import com.example.springmarket.model.comment.CommentDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommentController {
	
	@Autowired
	CommentDAO commentDao;
	

	@PostMapping("comment/write.do")
	@ResponseBody
	public void write(@RequestParam(name="comment_content") String comment_content,
			@RequestParam(name="num") int num,
			@RequestParam(name="userid")String userid
			) {		
		CommentDTO dto = new CommentDTO();
		dto.setComment_content(comment_content);
        dto.setUserid(userid);
        dto.setNum(num);
	
		commentDao.write(dto);
	}
	
	@GetMapping("comment/list.do")
	@ResponseBody
	public List<CommentDTO> list(@RequestParam(name = "num") int num) {
	    List<CommentDTO> list = commentDao.getList(num);
	    return list;
	}
	
	@GetMapping("comment/delete.do")
	@ResponseBody
	public void delete(@RequestParam(name="userid")String userid,
			@RequestParam(name="comment_num")int comment_num,
			@RequestParam(name="num")int num) {
		
		commentDao.delete(userid, comment_num, num);
		
	}
	
	@PostMapping("comment/update.do")
	@ResponseBody
	public void update(@RequestParam(name="comment_content") String comment_content,
			@RequestParam(name="comment_num")int comment_num,
			@RequestParam(name="userid")String userid) {
	
		commentDao.update(comment_content, userid, comment_num);
	}
	
	
	
}
