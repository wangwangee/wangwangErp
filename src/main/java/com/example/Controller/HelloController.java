package com.example.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/*
 * 컨트롤러는 클라이언트에서 요청이 들어올 때,
 * 해당 요청을 수행할 비즈니스 로직을 제어한 객체이다.
 *http://localhost:8080/ URL로 
 *클라이언트가 요청을 하게되면 
 *이 컨트롤러는 home.jsp 파일을 찾아
 * JSP파일이 변환된 HTML파일을 클라이언트에게 넘겨준다.
 * */

@Controller // String이나 ModelAndView객체반환
public class HelloController {

//메인화면
	@GetMapping(value = "/")

	public String hello(Model model) {
		System.out.println("여기홈~~이다~~~~~~~~~~~ ");
		return "index";
	}

}
