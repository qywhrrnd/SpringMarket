package com.example.springmarket.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.board.PageUtil;
import com.example.springmarket.model.board.BoardDAO;
import com.example.springmarket.model.board.BoardDTO;

import jakarta.servlet.http.HttpSession;

@Controller

public class BoardController {

	@Autowired
	BoardDAO boardDao;
	
	@GetMapping("board/list.do")
	public ModelAndView board_list(@RequestParam(name = "cur_page", defaultValue = "1") int curPage) {
		int count = boardDao.count();
		PageUtil page = new PageUtil(count, curPage);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<BoardDTO> list = boardDao.list(start, end);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		return new ModelAndView("board/board_list", "map", map);
	}
	
	@PostMapping("board/search.do")
	public ModelAndView board_search(@RequestParam(name = "search_option") String search_option,
			@RequestParam(name = "keyword") String keyword,
			@RequestParam(name = "cur_page", defaultValue = "1") int cur_Page) {
		int count = boardDao.count();
		PageUtil page = new PageUtil(count, cur_Page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		
		List<BoardDTO> list = boardDao.list_search(search_option, keyword, start, end);
		
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("list", list);
		map.put("page", page);
		
		return new ModelAndView("board/board_list", "map", map);
	}
	
	@GetMapping("board/view.do/{num}")
	public ModelAndView view(@PathVariable(name="num")int num,
			ModelAndView mav) {
		mav.setViewName("board/board_view");
		mav.addObject("dto", boardDao.view(num));
		return mav;
	}
	
	@GetMapping("board/cancle.do")
	public String cancel(@RequestParam(name = "num") int num) {
	    return "redirect:/board/view.do?num=" + num;
	}

	
	@PostMapping("board/back.do/{num}")
	public ModelAndView back(@PathVariable(name="num")int num,
			ModelAndView mav) {
		mav.setViewName("board/board_view");
		mav.addObject("dto", boardDao.view(num));
		return mav;
	}
	
	@GetMapping("board/write.do")
	public String write() {
		return "board/board_write";
	}
	
	@PostMapping("board/insert.do")
	public String insert(BoardDTO dto,HttpSession session ) {
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		boardDao.insert(dto);
		return "redirect:/board/list.do";
	}
	
	@GetMapping("board/edit.do/{num}")
	public ModelAndView edit(@PathVariable(name = "num") int num, ModelAndView mav) {
		mav.setViewName("board/board_edit");
		mav.addObject("dto", boardDao.view(num));
		return mav;
	}
	 
	@PostMapping("board/delete.do")
	public String delete(@RequestParam(name = "num") int num) {
		boardDao.delete(num);
		return "redirect:/board/list.do";
	}
	
	@PostMapping("board/update.do")
	public String update(BoardDTO dto,HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		boardDao.update(dto);
		
		return "redirect:/board/view.do/" + dto.getNum();
	}
	
}
