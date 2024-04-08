package com.example.springmarket.model.love;

import java.util.List;

public interface LoveDAO {

	public void love_clear(LoveDTO dto);

	void love_apply(LoveDTO dto);

	int love_count(int write_code);

	List<LoveDTO> love_list(String userid);

	void love_delete(int write_code);

}