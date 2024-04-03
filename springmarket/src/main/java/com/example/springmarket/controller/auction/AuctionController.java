package com.example.springmarket.controller.auction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.auction.AuctionDAO;
import com.example.springmarket.model.auction.AuctionDTO;
import com.example.springmarket.model.auction.PageUtil;
import com.example.springmarket.model.member.MemberDAO;

@Controller
public class AuctionController {
    @Autowired
    private AuctionDAO auctionDao;

    @Autowired
    private MemberDAO memberDao;

    @GetMapping("/auction/list.do")
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
}
