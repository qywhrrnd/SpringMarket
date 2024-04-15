package com.example.springmarket.model.comment;

import java.util.List;

public interface CommentDAO {
	void write(CommentDTO dto);
	List<CommentDTO> getList(int num);
	void delete(String userid, int comment_num, int num);
	void update(String comment_content, String userid, int comment_num);

}
