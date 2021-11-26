package com.example.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.Service.UserService;
import com.example.Vo.UserVo;

//요청 URL을 어떤 메서드가 처리할지 여부를 결정하는 것이 @RequestMapping
//GET 사이트를 보여준다, POST 사이트안에 있는 정보를 가져다준다
@Controller
@RequestMapping("/user")
public class UserController {

	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath*:applicationContext.xml");

//*********회원가입********
	// GET 사이트를 보여준다
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {

		return "user/join";

	}

	// POST 사이트안에 있는 정보를 가져다준다
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(UserVo vo) {

		UserService userservice = (UserService) ctx.getBean("userService");
		userservice.join(vo);
		return "redirect:/"; // 루트 jsp로 가기

	}

//*********로그인********
	// GET 사이트를 보여준다
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "user/login"; // WEB-INF/views/user/login.jsp
	}

	// POST 사이트안에 있는 정보를 가져다준다
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(UserVo vo, HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {

		UserService userservice = (UserService) ctx.getBean("userService");

		if (userservice.login(vo) != null) { // 로그인정보일치 (UserVO를 받아오면)

			HttpSession session = request.getSession(); // session생성

			session.setAttribute("authUser", vo.getId()); // 이정보를 가지고jsp로 가기
			mav.setViewName("redirect:/"); // 루트 jsp로 가기

		} else { // 로그인정보 불일치

			mav.addObject("fail", "fail");
			mav.setViewName("redirect:/user/login"); // login.jsp로 가기

		}

		return mav;
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(); // session생성
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기

		if (authUser == null) {

			return "redirect:/";

		} else {
			UserService userService = (UserService) ctx.getBean("userService");

			UserVo userVo = userService.getUser(authUser);
			// getUser함수에서 정보를 가져와서
			// jsp로 Vo를 보내주면, 거기에서 사용자 이름과,아이디를 넣어서 수정쉽게 돕는다.
			model.addAttribute("userVo", userVo);

			return "user/update";

		}
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(HttpServletRequest request, UserVo vo) {

		HttpSession session = request.getSession(); // session생성
		// UserVo authUser = (UserVo) session.getAttribute("authUser");
		String authUser = (String) session.getAttribute("authUser");
		// String id = authUser.getId();

		vo.setId(authUser);

		UserService userService = (UserService) ctx.getBean("userService");

		userService.update(vo);
		// jsp에서 받은vo를 넣어서 업데이트한다.
		session.removeAttribute("authUser"); // java to jsp
		session.invalidate();

		return "redirect:/user/login";
	}

	//로그아웃

	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
/*
	//회원탈퇴 
	@RequestMapping(value = "/withdraw", method = RequestMethod.GET)
	public String withdraw(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(); // session생성
		String authUser = (String) session.getAttribute("authUser"); // 세션을 가져오기

		if (authUser == null) {

			return "redirect:/";

		} else {
			UserService userService = (UserService) ctx.getBean("userService");

			UserVo userVo = userService.getUser(authUser);
			// getUser함수에서 정보를 가져와서
			// jsp로 Vo를 보내주면, 거기에서 사용자 이름과,아이디를 넣어서 수정쉽게 돕는다.
			model.addAttribute("userVo", userVo);

			return "user/withdraw";

		}
	}
	*/
	/*
	@RequestMapping(value = "/withdraw", method = RequestMethod.POST)
	public String withdraw_delete(HttpServletRequest request, UserVo vo) {
		
		HttpSession session = request.getSession(); // session생성
		String authUser = (String) session.getAttribute("authUser");
		
		//기존 세션의 정보를 get해서 가져오고, 
		
		 //파리미터로 받아온 pwd와 두 pwd가 같은 경우
		if(vo.getPwd() ==  userVo.getPwd()) {
		UserService userService = (UserService) ctx.getBean("userService");
		//회원을 탈퇴시켜준다	
		userService.withdraw(vo);
		// jsp에서 받은vo를 넣어서 업데이트한다.
		session.removeAttribute("authUser"); // java to jsp
		session.invalidate();

		 
		}
		return "redirect::/";
	}
	*/
}