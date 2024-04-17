package com.example.springmarket.model.buy;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BuyDAOImpl implements BuyDAO {

	@Autowired
	SqlSession session;

	@Override
	public void buy(BuyDTO dto) {
		session.insert("buy.buy", dto);

	}

	@Override
	public List<BuyDTO> buylist(String userid) {
		// TODO Auto-generated method stub
		return session.selectList("buy.buylist", userid);
	}

	@Override
	public List<BuyDTO> adminbuylist() {
		// TODO Auto-generated method stub
		return session.selectList("buy.adminbuylist");
	}

}
