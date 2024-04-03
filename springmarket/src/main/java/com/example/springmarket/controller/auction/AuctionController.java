package com.example.springmarket.controller.auction;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.auction.AuctionDAO;
import com.example.springmarket.model.auction.AuctionDTO;
import com.example.springmarket.model.auction.PageUtil;
import com.example.springmarket.model.member.MemberDAO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class AuctionController {
	@Autowired
	private AuctionDAO auctionDao;

	@Autowired
	private MemberDAO memberDao;

	@GetMapping("auction/list.do")
	public ModelAndView listAuction(@RequestParam(name = "cur_page", defaultValue = "1") int curPage) {
		int count = auctionDao.count();
		PageUtil page = new PageUtil(count, curPage);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<AuctionDTO> list = auctionDao.listAuction(start, end);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("mdao", memberDao);

		return new ModelAndView("auction/auction_list", map);
	}

	@GetMapping("auction/pageauctioninsert.do")
	public ModelAndView pageauctioninsert() {
		return new ModelAndView("auction/auction_write");
	}

	@PostMapping("auction/insert_auction.do")
	public String insertAuction(HttpServletRequest request, @RequestParam(name = "subject") String subject,
			@RequestParam(name = "price") int price, @RequestParam(name = "contents") String contents) {
		ServletContext application = request.getSession().getServletContext();
		String imgPath = application.getRealPath("/resources/images/");
		String filename = "";
		try {
			boolean fileUploaded = false;

			for (Part part : request.getParts()) {
				filename = part.getSubmittedFileName();

				if (filename != null && !filename.trim().equals("")) {
					part.write(imgPath + filename);
					fileUploaded = true;
					break;
				}
			}

			// 파일이 없을 때 기본 이미지를 내 파일에서 가져와 사용
			if (!fileUploaded) {
				// 기본 이미지 파일 경로를 적절히 설정하세요.
				String defaultImagePath = application.getRealPath("/resources/images/nogazi.jpg");

				try (FileInputStream input = new FileInputStream(defaultImagePath);
						FileOutputStream output = new FileOutputStream(imgPath + "nogazi.jpg")) {

					byte[] buffer = new byte[1024];
					int bytesRead;
					while ((bytesRead = input.read(buffer)) != -1) {
						output.write(buffer, 0, bytesRead);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}

				filename = "nogazi.jpg";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		AuctionDTO dto = new AuctionDTO();
		dto.setSubject(subject);
		dto.setPrice(price);
		dto.setContents(contents);
		dto.setUserid(userid);
		dto.setBiduserid(userid);
		dto.setFilename(filename);
		auctionDao.insertAuction(dto);
		return "redirect:/auction/list.do";

	}

	@GetMapping("auction/auctiondetail.do")
	public ModelAndView detailAuction(@RequestParam(name = "auction_code") int auction_code) {
		AuctionDTO dto = auctionDao.detailAuction(auction_code);
		return new ModelAndView("auction/auction_detail", "dto", dto);
	}

	@GetMapping("auction/updatePriceAndBidder.do")
	public Map<String, Object> getAuctionInfo(HttpServletRequest request,
	        @RequestParam(name = "auction_code") int auction_code,
	        @RequestParam(name = "sessionUserId", required = false) String sessionUserId) {
	    AuctionDTO dto = auctionDao.getAuctionInfo(auction_code);
	    
	    // 경매 정보에서 필요한 데이터 추출
	    int price = dto.getPrice();
	    String bidder = dto.getBiduserid();
	    int time = dto.getTime();

	    // 사용자 세션에서 사용자 ID 가져오기
	    HttpSession session = request.getSession();
	    String userid = (String) session.getAttribute("userid");

	    // 만약 클라이언트에서 sessionUserId 파라미터를 보냈다면, 해당 값을 사용하고 아니라면 세션에서 가져온 사용자 ID를 사용합니다.
	    String finalUserId = sessionUserId != null ? sessionUserId : userid;

	    // 반환할 맵 생성 및 데이터 추가
	    Map<String, Object> map = new HashMap<>();
	    map.put("price", price);
	    map.put("bidder", bidder);
	    map.put("time", time);
	    map.put("userid", finalUserId);

	    return map; // 수정: 생성한 맵 반환
	}

}
