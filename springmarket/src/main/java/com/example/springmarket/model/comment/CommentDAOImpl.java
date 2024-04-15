package com.example.springmarket.model.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAOImpl implements CommentDAO {
	@Autowired
	SqlSession session;
	
	@Override
	public void write(CommentDTO dto) {
		String contents = dto.getComment_content();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("\n", "<br>");
		contents = contents.replace("  ", "&nbsp;&nbsp;");
		dto.setComment_content(contents);
		session.insert("comment.write",dto);

	}

	@Override
	public List<CommentDTO> getList(int num) {
		List<CommentDTO>list = session.selectList("comment.get_list", num);
		return list;
		
	}

	@Override
	public void delete(String userid, int comment_num, int num) {
		Map<String, Object>map = new HashMap<>();
		map.put("userid",userid);
		map.put("comment_num",comment_num);
		map.put("num",num);
		session.delete("comment.delete",map);

	}

	@Override
	public void update(String comment_content, String userid, int comment_num) {
		Map<String, Object>map = new HashMap<>();
		map.put("comment_content",comment_content);
		map.put("userid",userid);
		map.put("comment_num",comment_num);
		session.update("comment.update",map);

	}

}
