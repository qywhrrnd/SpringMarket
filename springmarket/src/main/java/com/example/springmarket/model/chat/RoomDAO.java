package com.example.springmarket.model.chat;

import java.util.List;

public interface RoomDAO {
	List<Room> chatbox(String userid);
	
	void craetechatbox(String userid, String otherid);
}