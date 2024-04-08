package com.example.springmarket.model.chat;

import java.util.List;

public interface ChatDAO {
	List<Chat> loadchat(int roomnumber);

	void savechat(Chat chat);
}
