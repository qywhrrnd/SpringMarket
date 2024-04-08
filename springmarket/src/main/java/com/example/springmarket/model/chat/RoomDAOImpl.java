package com.example.springmarket.model.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoomDAOImpl implements RoomDAO {

	@Autowired
	SqlSession session;

	@Override
	public List<Room> chatbox(String userid) {
		return session.selectList("chat.chatbox", userid);
	}

	@Override
	public void craetechatbox(String userid, String otherid) {
		Map <String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("otherid", otherid);
		session.insert("chat.createchatbox", map);
		
	}

}
