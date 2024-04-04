package com.example.springmarket.model.quiz;

import java.util.List;

public interface QuizDAO {
	List<QuizDTO> quiz_view(int num);

	List<QuizDTO> quiz_view_admin();

	void answer_insert(AnswerDTO dto);

	int check_answer(int quiz_idx);

	String quiz_email(String userid);

	int checkevent(String userid);

	void insertQuiz(QuizDTO dto);

}
