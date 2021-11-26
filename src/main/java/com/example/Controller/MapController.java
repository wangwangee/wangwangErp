package com.example.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.Service.GoodsService;
import com.example.Service.MapService;
import com.example.Vo.MapVo;

@Controller
public class MapController {
	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath*:applicationContext.xml");
	//거래처 등록하기 
	@RequestMapping(value = "/map/accountRecord", method = RequestMethod.GET)
	public String accountRecordGet(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
		 
			
			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "/map/accountRecord";
		}
	}
	//거래처 등록한 후 페이지 이동
	@RequestMapping(value = "/map/accountRecord", method =  RequestMethod.POST)
	public String accountRecordPost(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			
			
			
			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "/map/accountRecord";
		}
	}
	//거래처 등록페이지 보여주기
	@RequestMapping(value = "/map/enrollment", method = RequestMethod.GET)
	public String enrollmentGet(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "/map/enrollment";
		}
	}
	//거래처 등록페이지 등록하기 
		@RequestMapping(value = "/map/enrollment", method = RequestMethod.POST)
		public String enrollmentPost(Model model, HttpServletRequest request, MapVo vo) {
			HttpSession session = request.getSession(); // session정보를 받아온다.
			String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
			
			// 로그인유무를 확인하는 조건문
			if (authUser == null) {

				return "redirect:/";

			} else {
				MapService mapService = (MapService)ctx.getBean("mapService");
				//테이블에 거래처 정보등록하기
				mapService.accountRecord(vo);
		 
				return "redirect:/";
			}
		}
		
	
	
	//오늘 일정 정보 보여주기
	@RequestMapping(value = "/map/accountView", method = RequestMethod.GET)
	public String accountView(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			MapService mapService = (MapService)ctx.getBean("mapService");
			//테이블에 거래처 정보등록하기
			//yyyyMMdd를.. 
			//mapService.accountView(yyyyMMdd);
			
			return "/map/accountView";
		}
	}
	
	//<11.05>거래처 수정하기 
	@RequestMapping(value = "/map/UpdateDetail", method = RequestMethod.GET)
	public String UpdateDetail(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "/map/UpdateDetail";
		}
	}
	
	//<11.05>거래처명을 수정하기  -GET
	@RequestMapping(value = "/map/nameUpdateForm", method = RequestMethod.GET)
	public String nameUpdateForm(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "/map/nameUpdateForm";
		}
	}
	//<11.05>거래처명을 수정하기  -POST
	@RequestMapping(value = "/map/nameUpdateForm", method = RequestMethod.POST)
	public String nameUpdateForm(Model model, HttpServletRequest request,MapVo vo, String seq) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		int seq2 = Integer.parseInt(request.getParameter("seq"));
		vo.setSeq(seq2);
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			MapService mapService = (MapService)ctx.getBean("mapService");
			//map테이블에 거래처 수정하기
			mapService.accountUpdate(vo);
			return "redirect:/";
		}
	}
	
	
	//<11.05>장소 위치를 수정하기 map -GET
	@RequestMapping(value = "/map/mapUpdateForm", method = RequestMethod.GET)
	public String mapUpdateForm(Model model, HttpServletRequest request,String seq) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
	 
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser);
			//goods테이블에 거래처 수정하기
			return "/map/mapUpdateForm";
		}
	}
	
	//<11.05>장소 위치를 수정하기 마지막 수정 플랫폼 추가 -GET
	@RequestMapping(value = "/map/mapUpdateFormEnrollment", method = RequestMethod.GET)
	public String mapUpdateFormEnrollment(Model model, HttpServletRequest request,MapVo vo) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		int seq2 = Integer.parseInt(request.getParameter("seq"));
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser);
			//goods테이블에 거래처 수정하기
			return "/map/mapUpdateFormEnrollment";
		}
	}
	
	//<11.05>장소 위치를 수정하기 마지막 수정 플랫폼 추가  -POST
	@RequestMapping(value = "/map/mapUpdateFormEnrollment", method = RequestMethod.POST)
	public String mapUpdateFormEnrollment(Model model, HttpServletRequest request,MapVo vo, String seq) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		int seq2 = Integer.parseInt(request.getParameter("seq"));
		vo.setSeq(seq2);
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			MapService mapService = (MapService)ctx.getBean("mapService");
			//map테이블에 거래처 수정하기
			mapService.accountUpdate(vo);
			 
			return "redirect:/";
		}
	}
	//nameUpdateDetail.jsp
	@RequestMapping(value = "/map/nameUpdateDetail", method = RequestMethod.GET)
	public String nameUpdateDetail(Model model, HttpServletRequest request, String seq, String import_store,MapVo vo) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		
		int seq2 = Integer.parseInt(request.getParameter("seq"));
		vo.setSeq(seq2);
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			MapService mapService = (MapService)ctx.getBean("mapService");
			//map테이블에 거래처 수정하기
			MapVo vo2 =mapService.nameUpdateDetail(seq2);
			model.addAttribute("vo", vo2);
			return "/map/nameUpdateDetail";
		}
	}
	
	
	/******************거래처 삭제하기**************************/
	@RequestMapping(value = "/map/remove", method = RequestMethod.GET)
	public String accountRemove(Model model, HttpServletRequest request, @RequestParam("seq") Integer seq) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		
		//int seq2 = Integer.parseInt(request.getParameter("seq"));
		 
		System.out.println(seq);
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {
			
			return "redirect:/";

		} else {
			MapService mapService = (MapService)ctx.getBean("mapService");
			//map테이블에서 삭제
			mapService.accountRemove(seq);
			//model.addAttribute("result","removeOK");
			return "redirect:/";
		}
	}
	
}
