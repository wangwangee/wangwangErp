package com.example.Controller;

 
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.Service.ChartService;
import com.example.Utils.Util;
import com.example.Vo.AnnualSalesVo;
import com.example.Vo.GoodsVo;
import com.google.gson.Gson;
@Controller
public class ChartController {

	
	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath*:applicationContext.xml");
	ChartService chartService = (ChartService)ctx.getBean("chartService");

 
  
 
	/////2021년 , wp인 곳의 12개월동안의 수익을 어레이로 받아와서 jsp에 보내기
	@RequestMapping(value = "chart/annualSales", method = RequestMethod.GET)
	public String test2(  Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
			if (authUser == null) {
	
				return "chart/annualSales";
	
			} else {
		
				HashMap<String, String> hashmap = new HashMap<>();
				//if(로그인되있으면 ) authUser를 세션으로부터 가져오고~~
				//2021은... jsp에서 누르면  보내주는 걸로 만들기...
				//
				String year_send = request.getParameter("year");
				 
				hashmap.put("id",  authUser);
				hashmap.put("year", year_send);
				 
				//list로 해당 아이디의, 년도에 수익값과 월,달을 list로 받아온다 
				List<AnnualSalesVo> list = chartService.annualSaleChart(hashmap);
				/****************************에러처리 고민하기****     여기 안 되는중!!!!!!!!!!!!!!!!!!!!!**********************/
				//년도 값이 null인 경우에 return해줄 페이지만들기..
				if(list   ==null) { 
							System.out.println("에러 페이지 만들어주기");
							return "error";
				}else {
				
						//for문을 돌려서 mdate의 년 / 월을 짤라서 보내준다.
							for (AnnualSalesVo vo2 : list) { 
	 
								String year = vo2.getMdate().substring(0,4) +"년";
								//System.out.println("년 확인 ::  "+year);
								String month = vo2.getMdate().substring(4,6)+"월";
								//System.out.println("월 확인 ::  "+month);
								vo2.setMdate(year+month);
								//System.out.println( "다시 넣은 :::"+vo2.getMdate());  
							}
						
						
						Gson gson = new Gson();
						String json = gson.toJson(list);
						model.addAttribute("json", json);
						return "/chart/annualSales";
				}
				 
		}
	}
	
	/////2021년 , wp인 곳의 12개월동안의 수익을 어레이로 받아와서 jsp에 보내기
	@RequestMapping(value = "chart/bestItems", method = RequestMethod.GET)
	public String bestItems(  Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
			if (authUser == null) {
	
				return "chart/bestItems";
	
			} else {
		
				HashMap<String, String> hashmap = new HashMap<>();
				//if(로그인되있으면 ) authUser를 세션으로부터 가져오고~~
				//2021은... jsp에서 누르면  보내주는 걸로 만들기...
				//
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				String yyyyMM = year + Util.isTwo(month);
				hashmap.put("id",  authUser);
				hashmap.put("yyyyMM", yyyyMM);
	 
				 
				//list로 해당 아이디의, 년도에 수익값과 월,달을 list로 받아온다 
				List<GoodsVo> list = chartService.bestItems(hashmap);
 
				 
				//년도 값이 null인 경우에 에러처리
				if(list   ==null) { 
							 
							return "error";
				}else {
		 
						//for문을 돌려서 mdate의 년 / 월을 짤라서 보내준다.
							for (GoodsVo vo2 : list) { 
	 
								String name = vo2.getName();
								System.out.println("이름 확인 ::  "+name);
								int export_amount = vo2.getExport_amount();
								System.out.println("수량확인 ::  "+export_amount);
 
							}
						
						
						Gson gson = new Gson();
						String json = gson.toJson(list);
						model.addAttribute("json", json);
						return "chart/bestItems";
				}
				 
		}
	}
	//상품별 재고량 확인하는 페이지
	@RequestMapping(value = "/chart/bestItemsDetails", method = RequestMethod.GET)
	public String insertCalForm(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			System.out.println("인설트 ");
			return "/chart/bestItemsDetails";
		}
	}
	
	
	
	
	
	
	
}
 