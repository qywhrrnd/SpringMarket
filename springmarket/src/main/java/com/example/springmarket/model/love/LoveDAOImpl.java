package com.example.springmarket.model.love;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoveDAOImpl implements LoveDAO {

	@Autowired
	SqlSession session;
	
	@Override
	public void love_clear(LoveDTO dto) {
		session.delete("love.love_clear", dto);

	}

	@Override
	public void love_apply(LoveDTO dto) {
		session.insert("love.love_apply",dto);
	}

	@Override
	public int love_count(int write_code) {
		Map<String, Object> map = new HashMap<>();
		map.put("write_code", write_code);
		return session.selectOne("love.love_count", map);
	}

	@Override
	public List<LoveDTO> love_list(String userid) {
		List<LoveDTO> lovelist = session.selectList("love.love_list", userid);
		return lovelist;	
	}

	@Override
	public void love_delete(int write_code) {
		session.delete("love.love_delete", write_code);
	}

}
