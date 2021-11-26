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
							<td colspan ="16">${requestScope.vo.id }</td>
						</tr>
						<tr>
			 				<th>카테고리</th>
							<td colspan ="16">
								${vo.category}
							</td>
						</tr>
			
						<tr>
							<th>출고날짜</th>
							<td colspan ="16">
							    <jsp:setProperty value="${vo.export_mdate}" property="toDates" name="util"/>
								<jsp:getProperty property="toDates" name="util"/>
							</td>
						</tr>		
						<tr>
							<th>상품명</th>
							<td colspan ="8">${vo.name}</td>
						 
							<th>거래처명</th>
							<td  colspan ="8">${vo.export_store}</td>
						</tr>
						
						<tr>
							<th>판매가</th>
							<td colspan ="8">${vo.export_price}</td>
				 
							<th>판매수량</th>
							<td colspan ="8">${vo.export_amount}</td>
						</tr>			
						
						<tr style="line-height:32px;"> 
							<td colspan ="16" style ="text-align: center;">
<%-- 								<button type="button"  value="반품처리" onclick="location.href='returnGoods?seq=${vo.seq}'" class="btn btn-dark"  >반품처리 </button> --%>
								<button type="button"  value="수정하기" onclick="location.href='calUpdateForm_export?seq=${vo.seq}&export_amount=${vo.export_amount}'" class="btn btn-dark"  >수정하기 </button>
								<button type="button"    value="목록으로" onclick="location.href='calBoardList'" class="btn btn-dark"  >목록으로</button>
								<button type="button"    value="달력으로" onclick="location.href= 'calendar?year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'"class="btn btn-dark"> 달력으로</button>
							</td>
						</tr>
						 
					</table>
					
					<br/><br/> 
	   			</div>
    		</div>
		</div>
	</div>		
		
 
</div>
<c:import url="/WEB-INF/jsp/includes/footer.jsp" />		

</body>
 
</html>