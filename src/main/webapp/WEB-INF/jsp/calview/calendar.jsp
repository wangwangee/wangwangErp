<%@page import="com.example.Utils.Util"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.example.Vo.ImportVo"%>
<%@page import="com.example.Vo.ExportVo"%>
<%@ page import="java.util.List"%>
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
 
<title></title>
 
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script >

 

<style type="text/css">
	#card2 {
		text-align : center;
		margin: 0 auto;
		
	}

 	#calendar{
 		border-collapse: collapse; /* 표의 테두리를 실선으로 표시한다 */
 		border: 1px solid gray;
 
 	}
 	#calendar td{
 		border: 1px solid gray;
 		width: 200px;
 		height: 100px;
 		text-align : left;
 		 vertical-align: top;
 	}
 	
 
 	/*앵커태그의 밑줄을 제거해준다.- css 주석*/
 	
 	a{
 		text-decoration: none;
 	
 	}
 	/* 펜의 이미지크기를 줄여준다.*/
 
 	
 	#container{
 		/*border:1px solid red; ->쓰면 위치파악가능 */
 		width:800px;
 		margin: 0 auto;
 		
 	}
 	#container td > p{
 		margin-bottom:1px;
 		font-size: 5x;
 		background-color : rgba(254, 213, 226,0.5);

 	}
 	td:hover{
 		background-color:rgba(216, 209, 215,0.5);
 	}
 	.cPreview{
 		position: absolute;
  	 
 		background : pink;
 		width :40px;
 		height: 40px;
 		text-align: center;
 		line-height : 40px;
 		font-weight : bold;
 		border-radius: 20px 20px 1px 20px; 
 		background : pink;
 		width :40px;
 		height: 40px;
 		text-align: center;
 		line-height : 40px;
 		font-weight : bold;
 		border-radius: 20px 20px 1px 20px;
 	}
 	td{
 		postion : relative;
 	}
 	
</style>

<script type="text/javascript" >
//값이 1자리이면, 두자리로 만들어주는 기능
	function isTwo(str){
		return str.length<2?"0"+str:str;
	}
//dom탐색 
//$(function(){}) --> window.onload=function(){}
	$(function(){
		$(".countView").hover(function(){
			var aObj =$(this);
			var year = $(".y").text().trim(); //년을 dom에서 가져옴
			var month = $(".m").text().trim(); //월
			var date= $(this).text().trim();    //일
			var yyyyMMdd = year+isTwo(month)+isTwo(date);
			
			//alert(yyyyMMdd);
		
			$.ajax({
				method:"post", //전송방식
				url:"/calview/calCountAjax", //요청 URL
				data:{"yyyyMMdd":yyyyMMdd}, //key value형식으로 전송
				dataType :"text", //서버로부터 받는 값의 타입 정의
				async:false, //$.ajax()기본이 비동기식 실행이므로, false로 설정함. 
				success:function(val){
					//alert("서버통신 성공~~"+val);
					aObj.after("<div class='cPreview'>"+val+"</div>");0
				},
				error: function(){
					alert("서버통신 실패!!");
				}
			});
		},function(){		
			$(".cPreview").remove();	//마우스가 나가면 해당 엘리먼트를 삭제한다.
		}); 
	});
	 
	
</script>
 
 
 
</head>
  <!-- 로그인된 사용자가 아니라면 로그인창으로 돌려줌 -->
<%
	if(session.getAttribute("authUser") == null) {
 		
        String path =request.getContextPath();
		response.sendRedirect(path+"/user/login");
		return;
	}
%>
 


<%
//controller에서 리다이렉트 방식 아니라 forward방식이라
	//(3)달력의 날짜를 바꾸기 위해 전달된 year와 month 파라미터를 받는다. (forward//jsp에서 요청을 GET파라미터로 보내주고 그 값을 다시 컨트롤러에서 받아서,jsp에서 출력해주는 부분)
	String paramYear = request.getParameter("year");
	String paramMonth= request.getParameter("month");

	//(0) 캘랜더 API생성, 현재 년도와 월을 구함
	Calendar cal = Calendar.getInstance(); //new(x)
	int year =cal.get(Calendar.YEAR) ; //현재 년도를 구함
	int month =cal.get(Calendar.MONTH)+1 ; //현재 월을 구함(0~11월)
	
	//(4)만일 paramYear null 이아니라면, jsp에서 화살표 눌러서 요청을 한 경우 ->새로운 년,월기준을 달력 출력해야하므로 바꿔주는 부분
	if(paramYear !=null){
		year=Integer.parseInt(paramYear); //문자열을 숫자로 변환시키는 방법
	}
	if(paramMonth !=null){
		month = Integer.parseInt(paramMonth);
	}
	//(5)month기능이 한없이 커지고, 마이너스 되는 상황 막기
	//월이 증가하다가 12보다 커지면 13,14....넘어가는 현상 처리
	if(month >12){
		month=1; //1월로 변경
		year++; //년도는 다음해로 넘어가니깐 년도 +1 증가시키기
	}
	
	if(month <1){
		month=12; //12월로 변경
		year--; //년도는 전년도로 넘어가니깐 년도 -1 감소시키기
	}
	
	
	//(1)현재 월의 1일에 대한 요일 구하기 : 1~7 --> 1(일요일),2(월),3()....7(토)
	
	//int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);현재의 요일을 구하는 것(ex.4월7일의 요일)
	//set(y,month-1,1) month-1: calendar기준 (0~11), 우리기준 (1~12)
	cal.set(year, month-1, 1); //올헤 4월 1일에 대한 날짜로 변경 ->캘린더에 값전달시 -1헤야 4월을 인식함.
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK); // 1일에대한 요일구함 ->5:목요일
	
	//(2)현재 월의 마지막 날 구하기 (월의 날들 중에 최댓 값)
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	//(7-7강 )해당 달의 모든 일정 받기
	List<ImportVo> clist =(List<ImportVo>)request.getAttribute("clist");
	List<ExportVo> clist2 =(List<ExportVo>)request.getAttribute("clist2");
%>




<body>

 




<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div id ="container"> 
 
<h2><img src="<%=request.getContextPath() %>/Image/design/march.png" alt="일정보기"/> 일정보기 </h2>
 
 
 
<div class="col-sm-12 pt-3" id ="card2">	
	<div class="card">
		 <div class="card-header card-header-primary">
			<h4 class="card-title" >  
					 
					<%-- ?뒤에 year, month 값을 가지고 Controller로 간다 --%>
					<a href ="calendar?year=<%=year-1%>&month=<%=month%>">
						 <img src="<%=request.getContextPath() %>/Image/calendar/heart.png" alt="작년"/>
					</a>
					<a href ="calendar?year=<%=year%>&month=<%=month-1%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/next2.png" alt="지난달"/>
					</a>
					 
					<span class="y"><%= year %></span>년 <span class="m"><%=month %></span>월 
					<a href ="calendar?year=<%=year%>&month=<%=month+1%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/next.png" alt="다음달"/>
					</a>
					<a href ="calendar?year=<%=year+1%>&month=<%=month%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/heart.png" alt="내년"/>
					</a>
 	 
			</h4>
               <p class="card-catagory"></p>
         </div>	   
		 
			<div class="table-responsive">
				<table  class ="table-bordered"  id="calendar">
				 
					<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>
					<tr>
						<%	//달력에 시작하는 공백을 출력한다.
						
							//(1) 공백을 출력하는 for문 (목요일이 1일인 경우 앞에 공백을 출력~)
							for(int i=0; i<dayOfweek-1; i++){
								out.print("<td>&nbsp;</td>");
							}
							//(2) 날짜를 출력하는 for문 (1부터 마지막날까지)
							//날짜를 클릭했을 때, ~
							for(int i=1; i<=lastDay; i++ ){
								%>
								<td>
									<%-- 일정을 추가하는 부분 생성  --%>
									<%-- for문안에 i와 dayOfweek를 메소드에 전달해서 String 반환 --%>
									<%--ㅡ Map으로 보내는 방법 이해해보기 --%>
									<a class="countView" style="color:<%=Util.fontColor(dayOfweek,i) %>;" href ="calBoardList?year=<%=year%>&month=<%=month%>&date=<%=i%>"> <%=i %></a>
									<%-- 일정 추가를 년월일 전달해준다 --%>
									<a href ="calImport?year=<%=year%>&month=<%=month%>&date=<%=i%>">
										<img src="<%=request.getContextPath() %>/Image/calendar/packing.png" alt="입고"/>
									</a>
									<a href ="calExport?year=<%=year%>&month=<%=month%>&date=<%=i%>">	
										<img src="<%=request.getContextPath() %>/Image/calendar/ex_goods.png" alt="출고"/>
									</a>
									<%=getCalViewList(i,clist) %>
									<%=getCalViewList2(i,clist2) %>
								</td>
								<%
								//(3) 행을 바꿔주기 ---> 현재일(i)이 토요일인지 확인 : (공백수+현재날짜)한 값이 7로 나눠떨어지면 7의배수
								if((dayOfweek-1+i)%7==0){
									out.print("</tr><tr>");
								}
								
								
				 
							 
							}
							//(4) 나머지 공백 출력 for문 (이빨 빠진 것 채우기) 
							//ㄱ. 빠진 이빨의 갯수 구하기
							int countNbsp = ( 7- (dayOfweek-1 +lastDay)%7 ) %7 ;
							for(int i=0; i<countNbsp; i++){
								out.print("<td>&nbsp</td>");
							}
							
						%>
					</tr>
					
				</table>
			</div>
    	 
	 </div>
</div>						
				
				
 <%!public String getCalViewList (int i, List<ImportVo> clist) {
	 	String d =Util.isTwo(i+"");//달력으로 받는 숫자와 일수의 형일치시키기 위함
	 	String cList=""; //달력에 출력해줄 일정제목을 저장할 변수
	 	for(ImportVo vo: clist){
	 		if( vo.getImport_mdate().substring(6,8).equals(d) ){ //5월5일중 일인 05만짤라오기
	 			
	 			
	 			cList+="<p>"
	 					+( vo.getName().length()>6 ?  vo.getName().substring(0,6)+".." : vo.getName() )
	 					+"</p>";
	 		}
	 	} 
	 	return cList;  //결과 <p> title </p> <p> title</p>
 	}%> 
  <%!public String getCalViewList2 (int i, List<ExportVo> clist2) {
	 	String d =Util.isTwo(i+"");//달력으로 받는 숫자와 일수의 형일치시키기 위함
	 	String cList=""; //달력에 출력해줄 일정제목을 저장할 변수
	 	for(ExportVo vo: clist2){
	 		if( vo.getExport_mdate().substring(6,8).equals(d) ){ //5월5일중 일인 05만짤라오기
	 			cList+="<p>"
	 					+( vo.getName().length()>6 ?  vo.getName().substring(0,6)+".." : vo.getName() )
	 					+"</p>";
	 		}
	 	} 
	 	return cList;  //결과 <p> title </p> <p> title</p>
 	}%> 
 </div>
 
</body>
</html>