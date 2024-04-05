package com.example.springmarket.model.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO {

   @Autowired
   SqlSession session;
   
   
   
   @Override
   public List<ProductDTO> list(int pageStart, int pageEnd) {
      Map<String,Object> map = new HashMap<>();
      map.put("start", pageStart);
      map.put("end", pageEnd);
      return session.selectList("product.list_product",map);

   }

   @Override
   public void insert(ProductDTO dto) {
      session.insert("product.insert_product", dto);

   }

   @Override
   public ProductDTO detail(int write_code) {
      return session.selectOne("product.detail_product",write_code);

   }

   @Override
   public void update(ProductDTO dto) {
      session.update("product.update_product",dto);


   }

   @Override
   public void delete(int write_code) {
      session.delete("product.delete_product",write_code);

   }
   
   @Override
   public String file_info(int write_code){
   return session.selectOne("product.file_info", write_code);
   }

   @Override
   public int count() {
      return session.selectOne("product.count");
   }

   @Override
   public List<ProductDTO> mylist(String userid) {
      return session.selectList("product.mylist",userid);
   }

   @Override
   public int loveCheck(String userid, int write_code) {
      Map<String, Object> map = new HashMap<>();
      map.put("userid", userid);
      map.put("write_code", write_code);
      return session.selectOne("product.love_check",map);
   }

   @Override
   public void see(int write_code) {
      session.update("product.see",write_code);

   }

   @Override
   public void updateStatus(ProductDTO dto) {
      session.update("product.status",dto);

   }

   @Override
   public List<ProductDTO> search(String keyword, int start, int end) {
      Map<String, Object> map = new HashMap<>();
      map.put("keyword", keyword);
      map.put("start", start);
      map.put("end", end);
      return session.selectList("product.search",map);
   }

   @Override
   public int count(String keyword) {
      return session.selectOne("product.search_count",keyword);
   }

   @Override
   public List<ProductDTO> poplist() {
      return session.selectList("product.list_pop");
   }

   @Override
   public String product_userid(int write_code) {
      return session.selectOne("product.product_userid",write_code);
   }

}