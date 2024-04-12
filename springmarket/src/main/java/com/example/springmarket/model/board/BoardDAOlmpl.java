package com.example.springmarket.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.servlet.http.HttpSession;

@Repository
public class BoardDAOlmpl implements BoardDAO {
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<BoardDTO> list(int pageStart, int pageEnd) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", pageStart);
		map.put("end", pageEnd);
		List<BoardDTO> list = session.selectList("board.list", map);
		return list; 
	}

	@Override
	public int count() {
		return session.selectOne("board.count");
	}

	@Override
	public List<BoardDTO> list_search(String search_option, String key_word, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("key_word", key_word);
		map.put("start", start);
		map.put("end", end);
		
		List<BoardDTO> list = session.selectList("board.search_list", map);
		
		for (BoardDTO dto : list) {
			String nickname = dto.getNickname();
			String subject = dto.getSubject();

			switch (search_option) {
			case "all":
				nickname.replace(key_word, "<span style='color:red'>" + key_word + "</span>");
				subject.replace(key_word, "<span style='color:red'>" + key_word + "</span>");
				break;

			case "nickname":
				nickname.replace(key_word, "<span style='color:red'>" + key_word + "</span>");
				break;

			case "subject":
				subject.replace(key_word, "<span style='color:red'>" + key_word + "</span>");
				break;
			}
			dto.setNickname(nickname);
			dto.setSubject(subject);
		}
		return list;
	}

	@Override
	public int search_count(String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return session.selectOne("board.search_count", map);
	}

	@Override
	public void insert(BoardDTO dto) {
		String contents = dto.getContent();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("\n", "<br>");
		contents = contents.replace("  ", "&nbsp;&nbsp;");
		dto.setContent(contents);
		session.insert("board.insert", dto);

	}

	@Override
	public void update(BoardDTO dto) {
		String contents = dto.getContent();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("\n", "<br>");
		contents = contents.replace("  ", "&nbsp;&nbsp;");
		dto.setContent(contents);
		session.update("board.update", dto);

	}

	@Override
	public void delete(int num) {
		session.delete("board.delete", num);

	}

	@Override
	public void plus_hit(int num, HttpSession count_session) {
		long read_time = 0;
		if (count_session.getAttribute("read_time_" + num) != null) {
			read_time = (long) count_session.getAttribute("read_time_" + num);
		}
		long current_time = System.currentTimeMillis();

		if (current_time - read_time > 5 * 1000) {
			session.update("board.plus_hit", num);
			count_session.setAttribute("read_time_" + num, current_time);
		}
	}

	@Override
	public BoardDTO view(int num) {
		return session.selectOne("board.view", num);
	}

}
