package com.example.springmarket.model.auction;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AuctionDTO {
	private int auction_code;
	private String userid;
	private String subject;
	private String contents;
	private int price;
	private String filename;
	private String biduserid;
	private int time;
}