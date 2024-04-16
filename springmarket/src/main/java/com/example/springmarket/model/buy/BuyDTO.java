package com.example.springmarket.model.buy;

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
public class BuyDTO {
	private String userid;
	private String goodname;
	private int price;
	private int amount;
	private String address;
	private String filename;
	private int goodidx;
}
