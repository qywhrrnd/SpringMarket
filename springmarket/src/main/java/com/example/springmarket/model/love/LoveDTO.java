package com.example.springmarket.model.love;

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

public class LoveDTO {
   private String userid;
   private int write_code;
   private String subject;
   private int price;
   private String contents;
   private String filename;
   private int idx;
   

}
