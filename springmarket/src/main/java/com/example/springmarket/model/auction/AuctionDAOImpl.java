package com.example.springmarket.model.auction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AuctionDAOImpl implements AuctionDAO {

	@Autowired
	SqlSession session;

	@Override
	public List<AuctionDTO> listAuction(int pageStart, int pageEnd) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", pageStart);
		map.put("end", pageEnd);
		return session.selectList("auction.list_auction", map);
	}

	@Override
	public void insertAuction(AuctionDTO dto) {
		String contents = dto.getContents();
		contents = contents.replace("&lt;", "<");
		contents = contents.replace("&gt;", ">");
		contents = contents.replace("<br>", "\n");
		contents = contents.replace("&nbsp;&nbsp;", "  ");
		dto.setContents(contents);
		session.insert("auction.insert", dto);

	}

	@Override
	public List<AuctionDTO> mylist(String userid) {
		// TODO Auto-generated method stub
		return session.selectList("auction.mylist", userid);
	}

	@Override
	public AuctionDTO detailAuction(int auction_code) {
		// TODO Auto-generated method stub
		return session.selectOne("auction.detail_auction", auction_code);
	}

	@Override
	public int count() {
		// TODO Auto-generated method stub
		return session.selectOne("auction.count");
	}

	@Override
	public void bid(int price, String biduserid, int auction_code) {
		Map<String, Object> map = new HashMap<>();
		map.put("price", price);
		map.put("biduserid", biduserid);
		map.put("auction_code", auction_code);
		session.selectOne("auction.bid", map);
	}

	
	@Override
	public AuctionDTO getAuctionInfo(int auctionCode) {
		// TODO Auto-generated method stub
		return session.selectOne("auction.getAuctionInfo", auctionCode);
	}

	@Override
	public void deleteAuction(int auctionCode) {
		session.delete("auction.delete", auctionCode);

	}

}
