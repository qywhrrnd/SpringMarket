package com.example.springmarket.model.good;

import java.util.List;

import com.example.springmarket.model.auction.AuctionDTO;

public interface GoodDAO {
	List<GoodDTO> listgood();
	
	GoodDTO detailGood(int goodidx);
}
