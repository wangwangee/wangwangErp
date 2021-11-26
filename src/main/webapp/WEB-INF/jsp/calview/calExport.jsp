<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>InsertCalFrom - 일정추가</title>
  
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
 <!-- 귀여운 alert -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
 <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<%
	//GET파라미터로 년 월 일을 받는다.
	int year = Integer.parseInt(request.getParameter("year"));
	int month= Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));

	//현재시간 구하기
	Calendar cal = Calendar.getInstance();
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min =cal.get(Calendar.MINUTE);
	
	//세션에서 로그인 해둔 아이디를 받는다
	String id =  (String)request.getAttribute("id");
	
%>

 



<script type="text/javascript">
	function calendar(){
		location.href ="<%=request.getContextPath() %>/calview/calendar?year=<%=year%>&month=<%=month%>&date=<%=date%>";
	}
// 	function check_onclick(){
// 		theForm =document.frm1;
// 		if(theForm.name.value==""||theForm.export_store.value==""||theForm.export_price.value==""||theForm.export_amount.value==""){
// 			if(theForm.name.value==""){	
// 				alert("필수입력, 이름이 비어있습니다. 확인해주세요");
// 				return theForm.name.focus();
// 			}else if(theForm.export_store.value==""){	
// 				alert("필수입력, 거래처명이 비어있습니다. 확인해주세요");
// 				return theForm.export_store.focus();
// 			}else if(theForm.export_price.value==""){	
// 				alert("필수입력, 거래처명이 비어있습니다. 확인해주세요");
// 				return theForm.export_price.focus();
// 			}else if(theForm.export_amount.value==""){	
// 				alert("필수입력, 수량이 비어있습니다. 확인해주세요");
// 				return theForm.export_amount.focus();
// 			}
// 		}
// 	} onclick="check_onclick()"
</script>
 
</head>
 
<body>
 
<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div class="container">
	<form action="calExport" class="form-horizontal"  method ="post">
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/calendar/ex_goods.png" alt="출고"/> 상품출고</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				<input type="hidden" name="seq" value="0"/>	
				<div class="table-responsive">
			  		<table class="table">
					    <tr style="line-height:32px;">
							<th >ID</th>
							<td colspan ="8"><input type ="text" name ="id" value ="${id}" readonly/></td>
						</tr>
						<tr>
			 				<th>카테고리</th>
							<td colspan ="8">
								<select  name="category">
									<option>아우터</option>
									<option>상의</option>
									<option>하의</option>
									<option>신발</option>
								</select>
							</td>
						</tr>
			
						<tr>
							<th>출고날짜</th>
							<td colspan ="8">
								<select name="year">
									<% for(int i = year-5; i<year+5; i++){ 
										%>
										<!-- value이 부분이 중요함, 년도를 현재 년도부분으로 먼저나오게 selected한다 --> 
										<option <%= year == i ? "selected" :"" %> value="<%=i %>"><%=i %></option>
										<%
									} 
									%>
								
								</select>년
								<select name="month"> 
									<% for(int i =1; i<13; i++){ 
										%>
										<!-- value이 부분이 중요함, 년도를 현재 년도부분으로 먼저나오게 selected한다 --> 
										<option <%=month == i ? "selected" :"" %> value="<%=i %>"><%=i %></option>
										<%
									} 
									%>
								
								</select>월
								<select name="date">
									<% for(int i = 1; i<31; i++){ 
										%>
										<!-- value이 부분이 중요함, 년도를 현재 년도부분으로 먼저나오게 selected한다 --> 
										<option <%=date == i ? "selected" :"" %> value="<%=i %>"><%=i %></option>
										<%
									} 
									%>
								
								
								</select>일
								<select name="hour">
									<% for(int i = 0; i<24; i++){ 
										%>
										<!-- value이 부분이 중요함, 년도를 현재 년도부분으로 먼저나오게 selected한다 --> 
										<option <%=hour == i ? "selected" :"" %> value="<%=i %>"><%=i %></option>
										<%
									} 
									%>
								
								
								</select>시
								<select name="min">
									<% for(int i = 0; i<60; i++){ 
										%>
										<!-- value이 부분이 중요함, 년도를 현재 년도부분으로 먼저나오게 selected한다 --> 
										<option <%=min == i ? "selected" :"" %> value="<%=i %>"><%=i %></option>
										<%
									} 
									%>
								</select>분
								
							</td>
						</tr>		
						<tr>
							<th>상품명</th>
							<td><input type ="text" name ="name" /></td>
						 
							<th>거래처명</th>
							<td><input type ="text" name ="export_store" required /></td>
						</tr>
						
						<tr>
							<th>판매가</th>
							<td><input type ="text" name ="export_price" required /></td>
				 
							<th>판매수량</th>
							<td><input type ="text"  name="export_amount" id="export_amount" required /></td>
						</tr>			
						
						 
						<tr style="line-height:32px;">
							<td  colspan="16" style ="text-align: center;margin: 0 auto;" >
								<input type ="submit"   class="btn btn-dark"  value ="출고작성"/> 
								<input type ="button"  class="btn btn-dark" value ="돌아가기"  onclick="calendar()"/>
							</td>
						</tr>	
						 
					</table>
					
					<br/><br/> 
	   			</div>
    		</div>
		</div>
	</div>		
		
	</form>
</div>
<c:import url="/WEB-INF/jsp/includes/footer.jsp" />		

</body>
 
</html>