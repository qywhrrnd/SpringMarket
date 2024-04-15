package com.example.springmarket.model.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

public class PageUtil {
   public static final int PAGE_SCALE = 10;
   //페이지당 게시물 수
   
   public static final int BLOCK_SCALE = 10;
   //페이지 블록 단위(한 화면에 보여둘 페이지 수)
   
   private int curPage;   //현재 페이지
   private int prevPage;  //이전 페이지
   private int nextPage;  //다음 페이지
   private int totPage;   //전체 페이지 개수
   private int totBlock;  //전체 블록 개수
   private int curBlock;  //현재 페이지 블록
   private int prevBlock; //이전 페이지 블록
   private int nextBlock; //다음 페이지 불록
   private int pageBegin; //현재 페이지 시작번호
   private int pageEnd;   //현재 페이지 끝번호
   private int blockStart;//현재 블록의 시작번호
   private int blockEnd;  //현재 블록의 끝번호
   
   
   private int totalCount; //전체 게시글의 총 수 =? => select count(*) from board 
   
   
                    //  991       1
   public PageUtil(int count,int curPage) {
      curBlock = 1;    
      this.curPage = curPage;
      setTotPage(count); //전체 페이지 개수 설정
      setPageRange();   
      setTotBlock();     //전체 페이지 블록 개수 설정
      setBlockRange();  
      totalCount = count;
      // curPage가 속한 페이지 블록의 시작번호,끝번호 계산
      //setTotalCount();
      // 전체 게시글 개수
   }

   
   
   public void setTotalCount(int totalCount) {
      this.totalCount = totalCount;
                     
   }

   public void setTotBlock() {
      // 전체 페이지 개수 / 페이지 블록 단위
      totBlock =(int) Math.ceil(totPage*1.0/BLOCK_SCALE);
      // 블록 => 밑에 페이지 숫자
   }
   
   public void setBlockRange() {
      // curPage가 몇번째 페이지 블록에 속하는지 계산
      curBlock = (int) Math.ceil((curPage-1) /BLOCK_SCALE) + 1;
      
      //현재 페이지 블록의 시작, 끝번호 설정
      blockStart = (curBlock -1) * BLOCK_SCALE + 1;
      blockEnd = blockStart + BLOCK_SCALE - 1;
      
      //마지막 블록이 범위를 초과하지 않도록 처리
      if (blockEnd > totPage) {
         blockEnd = totPage;
      }
      
      //[이전]을 눌렀을 때 이동할 페이지
      prevPage = curBlock == 1 ? 1 : (curBlock - 1) * BLOCK_SCALE;
      
      //[다음]을 눌렀을 때 이동할 페이지
      nextPage = curBlock > totBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;
      
      //마지막 페이지가 범위를 초과하지 않도록 처리
      if (nextPage >= totPage) {
         nextPage = totPage;
      }
   }
   
   // curPage(현재 페이지)의 시작번호, 끝번호 계산
   public void setPageRange() {
      //시작번호: (현재페이지 -1) * 페이지당 게시물 수 + 1
      pageBegin = (curPage - 1) * PAGE_SCALE + 1;
      
      //끝번호: 시작번호 + 페이지당 게시물 수 - 1
      pageEnd = pageBegin + PAGE_SCALE - 1;
   }
   
   public void setTotPage(int count) {
      totPage = (int) Math.ceil(count * 1.0 / PAGE_SCALE);
   }   // 991 / 10 => 99.1 => 올림 하면 100페이지

   public int getCurPage() {
      return curPage;
   }

   public void setCurPage(int curPage) {
      this.curPage = curPage;
   }

   public int getPrevPage() {
      return prevPage;
   }

   public void setPrevPage(int prevPage) {
      this.prevPage = prevPage;
   }

   public int getNextPage() {
      return nextPage;
   }

   public void setNextPage(int nextPage) {
      this.nextPage = nextPage;
   }

   public int getTotBlock() {
      return totBlock;
   }

   public void setTotBlock(int totBlock) {
      this.totBlock = totBlock;
   }

   public int getCurBlock() {
      return curBlock;
   }

   public void setCurBlock(int curBlock) {
      this.curBlock = curBlock;
   }

   public int getPrevBlock() {
      return prevBlock;
   }

   public void setPrevBlock(int prevBlock) {
      this.prevBlock = prevBlock;
   }

   public int getNextBlock() {
      return nextBlock;
   }

   public void setNextBlock(int nextBlock) {
      this.nextBlock = nextBlock;
   }

   public int getPageBegin() {
      return pageBegin;
   }

   public void setPageBegin(int pageBegin) {
      this.pageBegin = pageBegin;
   }

   public int getPageEnd() {
      return pageEnd;
   }

   public void setPageEnd(int pageEnd) {
      this.pageEnd = pageEnd;
   }

   public int getBlockStart() {
      return blockStart;
   }

   public void setBlockStart(int blockStart) {
      this.blockStart = blockStart;
   }

   public int getBlockEnd() {
      return blockEnd;
   }

   public void setBlockEnd(int blockEnd) {
      this.blockEnd = blockEnd;
   }

   public int getTotPage() {
      return totPage;
   }
   
   public int getTotalCount() {
      return totalCount;
   }
}

// 이거 html그대로 가져다 쓰기

//</c:forEach>   <!-- 여기는 페이지 관련 부분 -->
//<tr align="center">
//   <td colspan="7">
//   <c:if test="${page.curPage > 1}">
//      <a href="#" onclick="list('1')">[처음]</a>
//   </c:if>         
//   <c:if test="${page.curBlock > 1}">
//      <a href="#" onclick="list('${page.prevPage}')">[이전]</a>
//   </c:if>   
//
//   <c:forEach var="num" begin="${page.blockStart}" 
//   end="${page.blockEnd}">
//      <c:choose>
//         <c:when test="${num == page.curPage}">
//            <span style="color:red">${num}</span>
//         </c:when>
//         <c:otherwise>
//            <a href="#" onclick="list('${num}')">${num}</a>   
//         </c:otherwise>
//      </c:choose>
//   </c:forEach>   
//   <c:if test="${page.curBlock < page.totBlock}">
//      <a href="#" onclick="list('${page.nextPage}')">[다음]</a>
//   </c:if>
//   <c:if test="${page.curPage < page.totPage}">
//      <a href="#" onclick="list('${page.totPage}')">[마지막]</a>
//   </c:if>      
//   </td>
//</tr>   