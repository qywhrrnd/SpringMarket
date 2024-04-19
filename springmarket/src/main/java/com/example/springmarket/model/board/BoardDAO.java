package com.example.springmarket.model.board;

import java.util.List;

import jakarta.servlet.http.HttpSession;

public interface BoardDAO {
	
	List<BoardDTO> list(int pageStart, int pageEnd);
	
	 int count();
	 
	 List<BoardDTO> list_search(String search_option, String key_word, int start, int end);
	 
	 int search_count(String search_option, String keyword);
	 
	 void insert(BoardDTO dto);
	 
	 void update(BoardDTO dto);
	 
	 void delete(int num);
	 
	 void plus_hit(int num, HttpSession count_session);
	 
	 BoardDTO view(int num);
}