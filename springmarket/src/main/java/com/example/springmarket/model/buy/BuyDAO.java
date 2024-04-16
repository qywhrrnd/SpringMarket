package com.example.springmarket.model.buy;

import java.util.List;

public interface BuyDAO {
	void buy(BuyDTO dto);
	
	List<BuyDTO> buylist(String userid); 
}
