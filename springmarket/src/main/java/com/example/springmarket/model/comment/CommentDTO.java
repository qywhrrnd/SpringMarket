package com.example.springmarket.model.comment;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentDTO {
   private int num;  //게시글번호 
   private int comment_num; //댓글번호
   private String userid;
   private String comment_content;
   private Date comment_date;
   
}