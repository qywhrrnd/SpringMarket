package com.example.springmarket.model.chat;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAOImpl implements ChatDAO {
	@Autowired
	SqlSession session;

	@Override
	public List<Chat> loadchat(int roomnumber) {
		// TODO Auto-generated method stub
		return session.selectList("chat.loadchat", roomnumber);
	}

	@Override
	public void savechat(Chat chat) {
		session.insert("chat.savechat", chat);

	}

}
