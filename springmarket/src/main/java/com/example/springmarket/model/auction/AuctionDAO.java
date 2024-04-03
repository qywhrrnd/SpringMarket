package com.example.springmarket.model.auction;

import java.util.List;


public interface AuctionDAO {

	List<AuctionDTO> listAuction(int pageStart, int pageEnd);
	
	void insertAuction(AuctionDTO dto);
	
	List<AuctionDTO> mylist(String userid);
	
	AuctionDTO detailAuction(int auction_code);
	
	int count();
	
	void bid(int price, String biduserid, int auction_code);
	
	AuctionDTO getAuctionInfo(int auctionCode);
	
	void deleteAuction(int auctionCode);
	
}
