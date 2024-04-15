package com.example.springmarket.model.good;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GoodDAOImpl implements GoodDAO {

	@Autowired
	SqlSession session;

	@Override
	public List<GoodDTO> listgood() {
		// TODO Auto-generated method stub
		return session.selectList("good.goodlist");
	}

	@Override
	public GoodDTO detailGood(int goodidx) {
		// TODO Auto-generated method stub
		return session.selectOne("good.detailgood", goodidx);
	}

}
