 <%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
 
<%
 
	//세션에서 로그인 해둔 아이디를 받는다
	String id =  (String)request.getAttribute("id");
	
%>
  <style>

      th{width :200px;}
 </style>
  <jsp:useBean id="util" class="com.example.Utils.Util"/>
</head>
 
<body>
 
<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div class="container">
	<form action="calUpdateForm_export" class="form-horizontal"  method ="post">
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/calendar/ex_goods.png" alt="출고"/> 상품출고</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				<input type="hidden" name="seq" value="${requestScope.vo.seq}"/>
				<div class="table-responsive">
			  		<table class="table">
					    <tr style="line-height:32px;">
							<th >ID</th>
							<td colspan ="16">${requestScope.vo.id }</td>
						</tr>
						<tr>
			 				<th>카테고리</th>
							<td colspan ="16">
								<select  name="category" id ="category"  class="selectpicker">
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
					<!-- el을 써두면 자바코드와 함께 사용불가. el->목적 :자바코드 줄이고  
						이런 경우 el과 호환이 되는 jstl을 사용하자-->
						<!-- year를 변수로 설정하고 사용 -->
		 						<c:set var="year" value="${fn:substring(vo.export_mdate,0,4) }"></c:set>
								<c:forEach var="i" begin ="${year-5}"
													end="${year+5 }" step="1">
						   			<option ${year==i?"selected":""} value="${i}">${i} </option>
							    </c:forEach>
							
								</select>년
								<select name="month"> 
								  	<c:set var="month" value="${fn:substring(vo.export_mdate,4,6)}"></c:set>
									<c:forEach var="i" begin ="1"
														end="12" step="1">
							   			<option ${month==i?"selected":""} value="${i}">${i} </option>
								    </c:forEach>
								
								</select>월
								<select name="date">
									<c:set var="date" value="${fn:substring(vo.export_mdate,6,8)}"></c:set>
									<c:forEach var="i" begin ="1"
														end="31" step="1">
							   			<option ${date==i?"selected":""} value="${i}">${i} </option>
								    </c:forEach>
								
								
								</select>일
								<select name="hour">
								 `<c:set var="hour" value="${fn:substring(vo.export_mdate,8,10)}"></c:set>
									<c:forEach var="i" begin ="0"
														end="23" step="1">
							   			<option ${hour==i?"selected":""} value="${i}">${i} </option>
								    </c:forEach>
								
								</select>시
								<select name="min">
								 <c:set var="min" value="${fn:substring(vo.export_mdate,10,12)}"></c:set>
									<c:forEach var="i" begin ="0"
														end="59" step="1">
							   			<option ${date==i?"selected":""} value="${i}">${i} </option>
								    </c:forEach>
								</select>분
							</td>
						</tr>		
						<tr>
							<th>상품명</th>
							<td colspan ="8">
								<input type="text" name="name" value="${vo.name}" required />
							</td>
						 
							<th>거래처명</th>
							<td  colspan ="8">
								<input type="text" name="export_store" value="${vo.export_store}" required />
							</td>
						</tr>
						
						<tr>
							<th>판매가</th>
							<td colspan ="8">
								<input type="text" name="export_price" value="${vo.export_price}" required /> 
							</td>
				 
							<th>판매수량</th>
							<td colspan ="8">
								<input type="text" name="export_amount" value=" ${vo.export_amount}" required />
							</td>
						</tr>			
						
						<tr style="line-height:32px;"> 
							 <td colspan="16" style ="text-align: center;">
								<input type="button" value="이전으로" onclick="location.href='calDetail_export?seq=${vo.seq}'" class="btn btn-dark"/>
								<input type="submit" value="수정하기" class="btn btn-dark"/>
								<input type="button" value="목록" onclick="location.href='calBoardList'" class="btn btn-dark"/>
								<input type="button" value="달력" onclick="location.href= 'calendar?year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'" class="btn btn-dark"/>
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