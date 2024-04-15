package com.example.springmarket.model.good;

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
public class GoodDTO {
	private int goodidx;
	private String goodname;
	private int price;
	private String goodcontent;
	private String filename;
}
