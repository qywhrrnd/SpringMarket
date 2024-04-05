package com.example.springmarket.model.product;

import java.util.List;
import java.util.Map;

public interface ProductDAO {
   
   List<ProductDTO> list(int pageStart, int pageEnd);
   
   void insert(ProductDTO dto);
   
   ProductDTO detail(int write_code);
   
   void update(ProductDTO dto);
   
   void delete(int write_code);
   
   String file_info(int write_code);
   
   int count();
   
   List<ProductDTO> mylist(String userid);
   
   int loveCheck(String userid, int write_code);
   
   void see(int write_code);
   
   void updateStatus(ProductDTO dto);
   
   List<ProductDTO> search(String keyword, int start, int end);
   
   int count(String keyword);
   
   List<ProductDTO> poplist();
   
   String product_userid(int write_code);

}