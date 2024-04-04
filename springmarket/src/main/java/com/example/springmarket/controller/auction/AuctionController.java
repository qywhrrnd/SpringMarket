package com.example.springmarket.controller.auction;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
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

	@ResponseBody
	@GetMapping("auction/updatePriceAndBidder.do")
	public ResponseEntity<AuctionDTO> getAuctionInfo(@RequestParam(name = "auction_code") int auctionCode,
			@RequestParam(name = "sessionUserId", required = false) String sessionUserId) {
		// 경매 정보를 가져옵니다.
		AuctionDTO dto = auctionDao.getAuctionInfo(auctionCode);

		// 가져온 정보에 세션 사용자 ID를 설정합니다.
		dto.setUserid(sessionUserId);

		// ResponseEntity를 사용하여 JSON 형식으로 데이터를 반환합니다.
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping("auction/bid.do")
	public ResponseEntity<AuctionDTO> bid(@RequestParam(name = "auction_code") int auctionCode,
			@RequestParam(name = "bidPrice") int bidPrice,
			@RequestParam(name = "biduserid") String biduserid) {
		// 경매 정보를 가져옵니다.
		System.out.println(auctionCode);
		System.out.println(bidPrice);
		System.out.println(biduserid);
		AuctionDTO dto = auctionDao.getAuctionInfo(auctionCode);
		auctionDao.bid(bidPrice, biduserid, auctionCode);
		// 가져온 정보에 세션 사용자 ID를 설정합니다.
		dto.setBiduserid(biduserid);

		// ResponseEntity를 사용하여 JSON 형식으로 데이터를 반환합니다.
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}

}
