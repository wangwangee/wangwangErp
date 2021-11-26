package com.example.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.Service.GoodsService;
import com.example.Service.ManagementService;
import com.example.Service.MapService;
import com.example.Service.ProfitService;
import com.example.Utils.Util;
import com.example.Vo.CalendarVo;
import com.example.Vo.ExportVo;
import com.example.Vo.GoodsVo;
import com.example.Vo.ImportVo;
import com.example.Vo.ManagementVo;
import com.example.Vo.MapVo;
import com.example.Vo.ProfitVo;
import com.example.Vo.UserVo;

@Controller // String 이나 ModelAndView객체를 반환
// String이나 ModelAndView객체를 반환하는 게 아니면 메소드 위에 @ResponseBody를 넣어주어야 한다.

public class CalController {

	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath*:applicationContext.xml");

	@RequestMapping(value = "/calview/calendar", method = RequestMethod.GET)
	public String Calender(Model model, String year, String month, HttpServletRequest request) {
		// <10.07> 캘린더에 입고일정 구현하기 위해서
		// CalendarService calendarService = (CalendarService)
		// ctx.getBean("calendarService");
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		/************************ 이부분변경 회원가입 세션 생성해주기 ************/
		// String id = "wp"; // 회원관리 기능을 추가하면 세션에서 로그인된 아이디를 구해서 저장

		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "calview/calendar";

		} else {

			// calendar를 요철할 때 년, 월의 값이 전달하지 않으면 현재 달을 보여준다.
			if (year == null || month == null) { // 년월이 null인경우 현재날짜로
				Calendar cal = Calendar.getInstance();
				year = cal.get(Calendar.YEAR) + "";
				month = cal.get(Calendar.MONTH) + 1 + "";
			} else {
				int yearInt = Integer.parseInt(year);
				int monthInt = Integer.parseInt(month);
				// month기능이 한없이 커지고, 마이너스 되는 상황 막기
				// 월이 증가하다가 12보다 커지면 13,14....넘어가는 현상 처리
				if (monthInt > 12) {
					monthInt = 1; // 1월로 변경
					yearInt++; // 년도는 다음해로 넘어가니깐 년도 +1 증가시키기
				}

				if (monthInt < 1) {
					monthInt = 12; // 12월로 변경
					yearInt--; // 년도는 전년도로 넘어가니깐 년도 -1 감소시키기
				}
				year = yearInt + "";
				// year = String.valueOf(yearInt);
				month = String.valueOf(monthInt); // 문자열로 변환, Sring.valueOf도 가능

			}
//<10.07>	Import리스트 출력 구현		
			// 월별 일정에 대해 하루마다 일정 3개씩 표시하기 기능 구현
			HashMap<String, String> hashmap = new HashMap<>();
			String yyyyMM = year + Util.isTwo(month);

			hashmap.put("id", authUser);
			hashmap.put("yyyyMM", yyyyMM);

			List<ImportVo> clist = goodsService.calImportList(hashmap);
			List<ExportVo> clist2 = goodsService.calExportList(hashmap);

			for (ExportVo vo3 : clist2) {

				vo3.setName(vo3.getName() + "출고");
			}

			for (ImportVo vo2 : clist) { // list에 있는 값을 vo에 담아서 출력해보기

				vo2.setName(vo2.getName() + "입고");
//				System.out.println("수량갯수 " + vo2.getImport_amount());
//				System.out.println("가격 " + vo2.getImport_price());
//				System.out.println("수행일자 " + vo2.getImport_mdate());
//				System.out.println("스토어명 " + vo2.getImport_store());
//				System.out.println("---------------");

			}

			model.addAttribute("clist", clist);
			model.addAttribute("clist2", clist2);
			return "calview/calendar";
		}

	}

	// <09.30> 입고추가하는 폼으로 이동
	@RequestMapping(value = "/calview/calImport", method = RequestMethod.GET)
	public String calImport(Model model, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "calview/calImport";
		}
	}

	// <09.30> 입고추가
	@RequestMapping(value = "/calview/calImport", method = RequestMethod.POST)
	public String calImport(Model model, HttpServletRequest request, GoodsVo vo) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
			ProfitService profitService = (ProfitService) ctx.getBean("profitService");
			ManagementService managementService = (ManagementService) ctx.getBean("managementService");
			// (1) <Goods 테이블> madte를 12자리로 만들어서 DB에 저장해야 함
			String mdate = vo.getYear() + Util.isTwo(vo.getMonth()) + Util.isTwo(vo.getDate())
					+ Util.isTwo(vo.getHour()) + Util.isTwo(vo.getMin());
			// GoodsVo vo1 = new GoodsVo(0, authUser, vo.getCategory(),mdate,
			// vo.getName(),vo.getImport_store(),
			// vo.getImport_price(),vo.getImport_amount(),vo.getInfo() );
			vo.setRefund_fl("N");
			vo.setPay("N");
			vo.setId(authUser);
			vo.setImport_mdate(mdate);

			// (2) <Profit 테이블> 년+월을 넣어서 DB에보내주기
			String mdate_pvo = vo.getYear() + Util.isTwo(vo.getMonth());
			// 마이너스로 만들어주기
			int income = 0 - (vo.getImport_price() * vo.getImport_amount());// vo.getExport_price()*vo.getExport_amount()
			System.out.println("마이너스 임폴트금액:" + income);
			ProfitVo pvo = new ProfitVo(0, authUser, mdate_pvo, income, Integer.parseInt(vo.getYear()),
					Integer.parseInt(vo.getMonth()), 0);

			// (3) <management 테이블>

			ManagementVo mvo = new ManagementVo(0, vo.getId(), vo.getName(), vo.getImport_amount());

			// <Goods 테이블>, <Profit 테이블>, <management 테이블> Service
			boolean isS = goodsService.importGoods(vo);
			boolean isSp = profitService.importGoods(pvo);
			managementService.importGoods(mvo);
			if (isS && isSp) {
				return "redirect:calendar? year=" + vo.getYear() + "&month" + vo.getMonth();

			} else {
				model.addAttribute("msg", "일정등록 실패!");
				return "error";// return error 이부분 생각해보기 /*****************여기부분 VO 다시 보고 참고해서
								// 하기!******************************/
			}

		}
	}

	// <09.30> 출고추가하는 폼으로 이동
	@RequestMapping(value = "/calview/calExport", method = RequestMethod.GET)
	public String calExport(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			model.addAttribute("id", authUser); // 회원 아이디값 넣어 jsp로 전달
			return "calview/calExport";
		}
	}

	// <09.30> 출고추가
	@RequestMapping(value = "/calview/calExport", method = RequestMethod.POST)
	public String calExport(Model model, HttpServletRequest request, GoodsVo vo, HttpServletResponse response)
			throws IOException {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
			ProfitService profitService = (ProfitService) ctx.getBean("profitService");
			ManagementService managementService = (ManagementService) ctx.getBean("managementService");

			String name = vo.getName();
			String checkAmount = managementService.improtCheckBeforeExport(name);
			// int checkAmount_2 =managementService.improtCheckBeforeExportAmount(name);
			// (1)입고가 안 된 상품을 출고하려고 할 경우
			if (Objects.isNull(checkAmount)) {

				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('입고가 안 된 상품입니다ㅠㅠ! 입고부터 해주세요'); history.go(-1);</script> ");
				out.flush();
				return " ";

				// (2)입고가 됐지만, 출고되어서 부족한 상품을 출고하려고 할 경우
			} else {
				int checkAmount_2 = managementService.improtCheckBeforeExportAmount(name);
				if (checkAmount_2 == 0) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('상품수량이 부족한 상품입니다ㅠㅠ! 재입고부터 해주세요'); history.go(-1);</script> ");
					out.flush();
					return " ";
					// (3)입고가 되어있고, 입고 재고도 있지만, 더 많은 량을 출고하려 할 경우
				} else if (checkAmount_2 < vo.getExport_amount()) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('상품수량이 부족한 상품입니다ㅠㅠ! 입고수량을 확인하여 재입고부터 해주세요'); history.go(-1);</script> ");
					out.flush();
					return " ";

					// (4)입고가 됐고, 출고상품 재고도 있는 경우
				} else {

					// <Goods 테이블> madte를 12자리로 만들어서 DB에 저장해야 함
					String mdate = vo.getYear() + Util.isTwo(vo.getMonth()) + Util.isTwo(vo.getDate())
							+ Util.isTwo(vo.getHour()) + Util.isTwo(vo.getMin());
					String mdate_pvo = vo.getYear() + Util.isTwo(vo.getMonth());

					vo.setExport_mdate(mdate);
					vo.setExport_year_month(mdate_pvo);
//					System.out.println("상품명 " + vo.getName());
//					System.out.println("수량갯수 " + vo.getExport_amount());
//					System.out.println("가격 " + vo.getExport_price());
//					System.out.println("수행일자 " + vo.getExport_mdate());
//					System.out.println("스토어명 " + vo.getExport_store());
//					System.out.println("---------------");
					// <Profit 테이블> 년+월, 수익 을 넣어서 DB에보내주기

					ProfitVo pvo = new ProfitVo(0, authUser, mdate_pvo, vo.getExport_price() * vo.getExport_amount(),
							Integer.parseInt(vo.getYear()), Integer.parseInt(vo.getMonth()), vo.getExport_amount());

					// (3) <management 테이블>

					ManagementVo mvo = new ManagementVo(0, vo.getId(), vo.getName(), vo.getExport_amount());

					boolean isS = goodsService.exportGoods(vo);
					boolean isSp = profitService.exportGoods(pvo);
					managementService.exportGoods(mvo);
					return "redirect:calendar? year=" + vo.getYear() + "&month=" + vo.getMonth();

				}

			}

		}
	}

	// <10.01> 그날 일정리스트 보여주기
	// 일정 목록보기
	@RequestMapping(value = "/calview/calBoardList", method = RequestMethod.GET) ////////// 여기를 수정했는데 왜 안나올까?? 생각해보자
	public String calBoardList(HttpServletRequest request, Model model, @RequestParam HashMap<String, String> ymd) { /// HttpServletRequest
																														/// request
		MapService mapService = (MapService) ctx.getBean("mapService");
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");

		// 세션에 해쉬맵파라미터로 받아온 년,월,일을 request에서 담고 사용할 수 있도록 한다
		HttpSession session = request.getSession();

		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {

			if (ymd == null || ymd.get("year") == null) {
				// 년이 null값인 경우에 이전 year값을 get한다
				// 년월일 전송 없이 전달 -> 일정목록페이지로 들어온 상태이기 때문에 ymd가 필요없음.(이미 ymd를 세션에 가지고있는 상태)
				ymd = (HashMap<String, String>) session.getAttribute("ymd");
			} else {
				// 새로운 요청의 year값인 경우 set한다
				// 새로운 정보를 통해 새 일정을 실행한다.
				session.setAttribute("ymd", ymd);
			}

			// db에서 처리하도록 8자리 날짜수로 변경하기. (삼항연산자 사용)
			String yyyyMMdd = ymd.get("year") + Util.isTwo(ymd.get("month")) // F3눌러서 가보기
					+ Util.isTwo(ymd.get("date"));

			HashMap<String, String> map = new HashMap<>();

			map.put("id", authUser);
			map.put("yyyyMMdd", yyyyMMdd);

			List<ImportVo> import_list = goodsService.calImportBoardList(map);
			List<ExportVo> export_list = goodsService.calExportBoardList(map);
			// 지도 list- 위치명, 위도,경도 jsp로 보내기
			List<MapVo> map_list = mapService.accountView(yyyyMMdd);

			model.addAttribute("import_list", import_list);
			model.addAttribute("export_list", export_list);
			model.addAttribute("map_list", map_list);
			return "calview/calBoardList";
		}
	}

	// 저장된 일정갯수 보여주기 (ajax처리시, responsebody를 붙여주지 않으면 viewResolver가
	// 실행됨,calCountAjax페이지를 찾아감.
	// 줘야 responsebody 붙여줘야 브라우저쪽, 바디쪽으로 출력해줘라~ , PrinterWriter객체 같음)
	@ResponseBody
	@RequestMapping(value = "/calview/calCountAjax", method = RequestMethod.POST)

	public String calCountAjax(@RequestParam("yyyyMMdd") String ymd, Model model, HttpServletRequest request) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		// vo,list같은 걸 보내야할 때 자바스크립트엔 없음.. ->변형시켜 보내야함.
		// vo, list를 json객체로 변환해서 보내야함.
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기

		HashMap<String, String> hashmap = new HashMap<>();

		hashmap.put("id", authUser);
		hashmap.put("yyyyMMdd", ymd);

		int count = goodsService.ImportcalCount(hashmap);
		int count2 = goodsService.ExportcalCount(hashmap);
		count = count + count2;
		System.out.println("ymd + " + ymd);
		System.out.println("count + " + count);

		return count + "";

	}

	// <10.09>결제 후 처리 Ajax
	@ResponseBody
	@RequestMapping(value = "/calview/goodsBuying", method = RequestMethod.POST)

	public String GoodsBuying(@RequestParam("seq") String seq, Model model, HttpServletRequest request) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		// vo,list같은 걸 보내야할 때 자바스크립트엔 없음.. ->변형시켜 보내야함.
		// vo, list를 json객체로 변환해서 보내야함.
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		String pay = "Y";
		HashMap<String, String> hashmap = new HashMap<>();

		hashmap.put("id", authUser);
		hashmap.put("seq", seq); // 상품명
		hashmap.put("pay", pay);
		boolean test = goodsService.goodsBuying(hashmap);

		System.out.println("name + " + test);
		return test + "";

	}

	// <11.01> 오늘의 입출고 등록
	@RequestMapping(value = "/calview/todayImportExport", method = RequestMethod.GET)
	public String todayImportExport(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			model.addAttribute("id", authUser);
			return "calview/todayImportExport";
		}
	}

	// <11.03> import 일정 자세히 보기
	@RequestMapping(value = "/calview/calDetail", method = RequestMethod.GET)
	public String calDetail(Model model, int seq, HttpServletRequest request) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			GoodsVo vo = goodsService.calDetail(seq);
			model.addAttribute("vo", vo);
			return "calview/calDetail";
		}
	}

	// <11.03> import 수정 페이지 구현 -GET
	// 일정수정폼이동 insert,update쪽이 post
	@RequestMapping(value = "/calview/calUpdateForm", method = RequestMethod.GET)
	public String updateForm(Model model, int seq, HttpServletRequest request, GoodsVo vo) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		System.out.println("seq출력해보기 폼에서부터 출력해보기" + vo.getSeq());
		HttpSession session = request.getSession();
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인 안 한 경우 못하게 막기
		if (authUser == null) {
			return "redirect:/";
		} else {
			vo = goodsService.calDetail(seq);
			model.addAttribute("vo", vo);
			return "calview/calUpdateForm";
		}
	}
	/*****************************여기서부터 다시하기~~~11월 11일************************************/

	// <11.03> import 수정 페이지 구현 - POST
	// 일정수정하기 insert,update쪽이 post
	@RequestMapping(value = "/calview/calUpdateForm", method = RequestMethod.POST)
	public String updateForm2(Model model, HttpServletRequest request, GoodsVo vo, String seq) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		ProfitService profitService = (ProfitService) ctx.getBean("profitService");
		ManagementService managementService = (ManagementService) ctx.getBean("managementService");

		HttpSession session = request.getSession();
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		System.out.println("seq출력해보기" + vo.getSeq());

		int seq2 = Integer.parseInt(request.getParameter("seq"));
		
		
		
		// (1) <Goods 테이블> madte를 12자리로 만들어서 DB에 저장해야 함
		String mdate = vo.getYear() + Util.isTwo(vo.getMonth()) + Util.isTwo(vo.getDate()) + Util.isTwo(vo.getHour())
				+ Util.isTwo(vo.getMin());
		vo.setSeq(seq2);
		vo.setId(authUser);
		vo.setImport_mdate(mdate);
//		// (2) 일정수정할 때, import_price, import_amount가져와서 수정과 다른지 비교하기 위한 select
		// 기존의 vo -> vo2
		GoodsVo vo2 = goodsService.compareProfitAmount(seq2);

		// (2) <Profit 테이블> 년+월을 넣어서 DB에보내주기
		String mdate_pvo = vo2.getImport_mdate();
		// 플러스로 만들어주기 (기존에 마이너스한 금액 더하기)
		int income = 0 + (vo2.getImport_price() * vo2.getImport_amount());// vo.getExport_price()*vo.getExport_amount()
 
		ProfitVo pvo = new ProfitVo(0, authUser, (vo2.getImport_mdate().substring(0, 6)), income,
				Integer.parseInt(vo2.getImport_mdate().substring(0, 4)),
				Integer.parseInt(vo2.getImport_mdate().substring(4, 6)), 0);

		// 마이너스로도 만들어주기 (변경한 금액 빼기)
		String mdate_pvo2 = vo.getImport_mdate();
		int income2 = 0 - (vo.getImport_price() * vo.getImport_amount());// vo.getExport_price()*vo.getExport_amount()
		System.out.println("마이너스 임폴트금액:" + income2);
		ProfitVo pvo2 = new ProfitVo(0, authUser, vo.getImport_mdate().substring(0, 6), income2,
				Integer.parseInt(vo.getImport_mdate().substring(0, 4)),
				Integer.parseInt(vo.getImport_mdate().substring(4, 6)), 0);

		// (3) <management 테이블>
		System.out.println(" 입력받은 값" + vo.getImport_amount());
		System.out.println(" 원래값" + vo2.getImport_amount());

		int newAmount = 0 + vo.getImport_amount() - vo2.getImport_amount();
		System.out.println(" 뺀 값" + newAmount);
 
//		// 기존 수량은 마이너스로 해주기 (플러스된 수량을 뺀다)
//		managementService.exportGoods(mvo);
		ManagementVo mvo2 = new ManagementVo(0, authUser, vo.getName(), newAmount);
		// 입고 새로된 수량으로 수정해주기
		managementService.importGoods(mvo2);

		// <goods를 업데이트 하기>
		boolean isS = goodsService.calUpdate(vo);
		// <Profit 테이블 업데이트하기>
		boolean isSp = profitService.importGoods(pvo);
		boolean isSp2 = profitService.importGoods(pvo2);
		String name = vo.getName();

		if (isS) { // 업데이트가 잘 된 경우

			// return "redirect:/";
			return "redirect:calDetail?seq=" + vo.getSeq() + "&name=" + name + "&date=" + mdate; // 리다이렉트: 브라우저에게 다시 요청을
																									// 해줘~,
			// 쿼리를 실해앻서 결과를 보여줘야하면 리다이렉트를 통해 controller를 통해 결과 가지고 갈 수 있음
		} else { // 업데이트시 실패가 났다면
			model.addAttribute("msg", "일정수정실패");
			return "error";
		}

	}

	// <11.04> export 일정 자세히 보기
	@RequestMapping(value = "/calview/calDetail_export", method = RequestMethod.GET)
	public String calDetail_export(Model model, int seq, HttpServletRequest request) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		HttpSession session = request.getSession(); // session정보를 받아온다.
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인유무를 확인하는 조건문
		if (authUser == null) {

			return "redirect:/";

		} else {
			GoodsVo vo = goodsService.calDetail_export(seq);
			model.addAttribute("vo", vo);
			// model.addAttribute("id", authUser); // 회원 아이디값 넣어
			return "calview/calDetail_export";
		}
	}

	// <11.04> export 수정 페이지 구현 -GET
	// 일정수정폼이동 insert,update쪽이 post
	@RequestMapping(value = "/calview/calUpdateForm_export", method = RequestMethod.GET)
	public String calUpdateForm_export(Model model, int seq, HttpServletRequest request, GoodsVo vo,int export_amount) {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		//System.out.println("seq출력해보기 폼에서부터 출력해보기" + vo.getSeq());
//		ManagementService managementService = (ManagementService) ctx.getBean("managementService");
//		String name = vo.getName();
//		int checkAmount_2 =managementService.improtCheckBeforeExportAmount(name);
//		int total_amount =checkAmount_2+ export_amount;	
//		
//		
//		System.out.println("출고 했던 수량 출력"+export_amount);
//		System.out.println("지금 출고하려고 하는 수량 출력"+vo.getExport_amount());
//		System.out.println("출고 했던 수량 + 현재남은 상품 총량을 계산하는 부분"+ total_amount);
		
		HttpSession session = request.getSession();
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		// 로그인 안 한 경우 못하게 막기
		if (authUser == null) {
			return "redirect:/";
		} else {
			vo = goodsService.calDetail_export(seq);
			model.addAttribute("vo", vo);
			return "calview/calUpdateForm_export";
		}
	}

	// <11.04> export 수정 페이지 구현 - POST
	// 일정수정하기 insert,update쪽이 post
	@RequestMapping(value = "/calview/calUpdateForm_export", method = RequestMethod.POST)
	public String calUpdateForm_export(Model model, HttpServletRequest request, GoodsVo vo,String seq , HttpServletResponse response) throws IOException {
		GoodsService goodsService = (GoodsService) ctx.getBean("goodsService");
		ProfitService profitService = (ProfitService) ctx.getBean("profitService");
		ManagementService managementService = (ManagementService) ctx.getBean("managementService");
		
		HttpSession session = request.getSession();
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기
		//System.out.println("seq출력해보기" + vo.getSeq());
		//System.out.println("출고 했던 수량 출력"+export_amount);
		 int seq2 = Integer.parseInt(request.getParameter("seq"));
		String name = vo.getName();
		String checkAmount = managementService.improtCheckBeforeExport(name);
			//(1)입고가 안 된 상품을 출고 수정을 하려고 할 경우 수정을 막는다.
		if(Objects.isNull(checkAmount)){
				
				response.setContentType("text/html; charset=UTF-8");
	 			PrintWriter out = response.getWriter();
	 			out.println("<script>alert('입고가 안 된 상품입니다ㅠㅠ! 입고부터 해주세요'); history.go(-1);</script> "); 
	 			out.flush();
	 			return " ";
				
	 		 
		}  else{ 
			/********************컨트롤러에서 select해오는 걸로 변경하기************************/
				int checkAmount_2 =managementService.improtCheckBeforeExportAmount(name);
				int export_amount =goodsService.previousAmountCount(Integer.parseInt(seq));
				int total_amount =checkAmount_2+ export_amount;	
				System.out.println("출고 했던 수량 출력"+export_amount);
				System.out.println("지금 출고하려고 하는 수량 출력"+vo.getExport_amount());
				System.out.println("출고 했던 수량 + 현재남은 상품 총량을 계산하는 부분"+ total_amount);
				//(2)입고가 됐지만, 출고되어서 부족한 상품을 출고하려고 할 경우	 수정을 막는다.
				if(checkAmount_2 ==0) {
					response.setContentType("text/html; charset=UTF-8");
		 			PrintWriter out = response.getWriter();
		 			out.println("<script>alert('상품수량이 부족한 상품입니다ㅠㅠ! 재입고부터 해주세요'); history.go(-1);</script> "); 
		 			out.flush();
		 			return " ";
		 	//(3)입고가 되어있고, 입고 재고도 있지만, 더 많은 량을 출고하려 할 경우 수정을 막는다.	
		 		/*******************여기 다시해주기~~~~~~~~~~~~~~~~******************/	
		 		 
				}else if( total_amount < vo.getExport_amount()) {
					response.setContentType("text/html; charset=UTF-8");
		 			PrintWriter out = response.getWriter();
		 			out.println("<script>alert('상품수량이 부족한 상품입니다ㅠㅠ! 재입고부터 해주세요'); history.go(-1);</script> "); 
		 			out.flush();
		 			return " ";
						
		 	//(4)입고가 됐고, 출고상품 재고도 있는 경우
				}else{
						// (1) <Goods 테이블> madte를 12자리로 만들어서 DB에 저장해야 함
					String mdate = vo.getYear() + Util.isTwo(vo.getMonth()) + Util.isTwo(vo.getDate()) + Util.isTwo(vo.getHour())+ Util.isTwo(vo.getMin());
					vo.setSeq(seq2);
					vo.setId(authUser);
					vo.setExport_mdate(mdate);
					// (2) 일정수정할 때, export_price, export_amount가져와서 수정과 다른지 비교하기 위한 select
					// 기존의 vo -> vo2
					GoodsVo previous_vo  = goodsService.compareProfitAmount_export(seq2);
			 
					// (2) <Profit 테이블> 년+월을 넣어서 DB에보내주기
					String mdate_pvo = previous_vo.getExport_mdate();
					// 마이너스로 만들어주기 (기존에 플러스한 금액 빼기)
					int income = 0 - (previous_vo.getExport_price() * previous_vo.getExport_amount());// vo.getExport_price()*vo.getExport_amount()
		 
					 
					ProfitVo pvo = new ProfitVo(0, authUser, (previous_vo.getExport_mdate().substring(0, 6)), income,
							Integer.parseInt(previous_vo.getExport_mdate().substring(0, 4)),
							Integer.parseInt(previous_vo.getExport_mdate().substring(4, 6)), 0);

					// 플러스로도 만들어주기 (변경한 금액 매출이니까 더해주기)
					String mdate_pvo2 = vo.getExport_mdate();
					int income2 = 0 + (vo.getExport_price() * vo.getExport_amount());// vo.getExport_price()*vo.getExport_amount()
					System.out.println("플러스 익스폴트금액:" + income2);
					ProfitVo pvo2 = new ProfitVo(0, authUser, vo.getExport_mdate().substring(0, 6), income2, 
							Integer.parseInt(vo.getExport_mdate().substring(0, 4)),
							Integer.parseInt(vo.getExport_mdate().substring(4, 6)), 0);

					
					// (3) <management 테이블>
		 
					int newAmount = 0+ +vo.getExport_amount() - previous_vo.getExport_amount();
					System.out.println (" 뺀 값"+ newAmount);
		 
		//			// 기존 수량은 마이너스로 해주기 (플러스된 수량을 뺀다)
		//			managementService.exportGoods(mvo);
					ManagementVo mvo2 = new ManagementVo(0, authUser, vo.getName(), newAmount);
					// 입고 새로된 수량으로 수정해주기
					managementService.exportGoods(mvo2);
				 
					// <goods를 업데이트 하기>
					
					boolean isS = goodsService.calUpdate_export(vo);;
					//<Profit 테이블 업데이트하기>
					boolean isSp = profitService.exportGoods(pvo);
					boolean isSp2 = profitService.exportGoods(pvo2);
					String name2 = vo.getName();

					//boolean isS = goodsService.calUpdate_export(vo);

					if(isS)
					{ // 업데이트가 잘 된 경우
				
						// return "redirect:/";
						return "redirect:calDetail_export?seq=" + vo.getSeq() + "&name=" + name2 + "&date=" + mdate; // 리다이렉트: 브라우저에게 다시 요청을
																												// 해줘~,
						// 쿼리를 실해앻서 결과를 보여줘야하면 리다이렉트를 통해 controller를 통해 결과 가지고 갈 수 있음
					}else
					{ // 업데이트시 실패가 났다면
						model.addAttribute("msg", "일정수정실패");
						return "error";
					}
				
				
				}
		}	
	
	}
	
}
