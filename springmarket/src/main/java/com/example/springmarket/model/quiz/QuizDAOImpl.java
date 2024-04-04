package com.example.springmarket.model.quiz;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QuizDAOImpl implements QuizDAO {

	@Autowired
	SqlSession session;

	@Override
	public List<QuizDTO> quiz_view(int num) {
		// TODO Auto-generated method stub
		return session.selectList("quiz.view", num);
	}

	@Override
	public List<QuizDTO> quiz_view_admin() {
		// TODO Auto-generated method stub
		return session.selectList("quiz.view_admin");
	}

	@Override
	public void answer_insert(AnswerDTO dto) {
		session.insert("quiz.insert_answer", dto);

	}

	@Override
	public int check_answer(int quiz_idx) {
		// TODO Auto-generated method stub
		return session.selectOne("quiz.check", quiz_idx);
	}

	@Override
	public String quiz_email(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("quiz.quiz_email", userid);
	}

	@Override
	public int checkevent(String userid) {
		// TODO Auto-generated method stub
		return session.selectOne("quiz.checkevent", userid);
	}

	@Override
	public void insertQuiz(QuizDTO dto) {
		session.insert("quiz.quiz_insert", dto);

	}

}
