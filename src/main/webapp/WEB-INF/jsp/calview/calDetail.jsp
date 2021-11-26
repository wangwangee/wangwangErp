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
// 	//GET파라미터로 seq, name, import_date
// 	int year = Integer.parseInt(request.getParameter("seq"));
// 	int month= Integer.parseInt(request.getParameter("name"));
// 	int date = Integer.parseInt(request.getParameter("import_date"));

 
	String id =  (String)request.getAttribute("id");
	
%>
 
 <jsp:useBean id="util" class="com.example.Utils.Util"/>
</head>
  

<body>
<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div class="container">
	<form action="calImport"  class="form-horizontal" method ="post"  >
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/calendar/packing.png" alt="입고"/> 상품입고</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				<input type="hidden" name="seq" value="0"/>
				<div class="table-responsive">
			  		<table class="table"> 
						<tr style="line-height:32px;">
							<th>ID</th>
							<td  colspan ="16" readonly ="redonly">${requestScope.vo.id }</td>
						</tr>
						<tr>
			 				<th>카테고리</th>
							<td colspan ="16">${vo.category}</td>
						</tr>
			
						<tr>
							<th>입고날짜</th>
							<td colspan ="8">
								<!-- property : util의 멤버필드,name은 id  -> set메서드 실행시킨다 -->
								<!-- el은 태그와만 사용가능 -->
								 <jsp:setProperty value="${vo.import_mdate}" property="toDates" name="util"/>
								<jsp:getProperty property="toDates" name="util"/>
							</td>
						</tr>		
						<tr>
							<th>상품명</th>
							<td colspan ="8">${vo.name}</td>
						 
							<th>거래처명</th>
							<td colspan ="8">${vo.import_store}</td>
						</tr>
						
						<tr>
							<th>도매가</th>
							<td colspan ="8">${vo.import_price}</td>
				 
							<th>도매수량</th>
							<td colspan ="8">${vo.import_amount}</td>
						</tr>			
						
						
<!-- 						<tr>	 -->
						 
<!-- 								<th>상품 정보</th> -->
<!-- 								<td colspan ="3"> -->
<!-- 									<textarea class="form-control" rows ="10" cols ="60"  readonly ="redonly"> -->
<%-- 										${vo.info }  --%>
<!-- 									</textarea> -->
<!-- 								</td> -->
							 
<!-- 						</tr> -->
					 
			 
						 	
						 
						<tr> 
							<td  colspan="16" style ="text-align: center;margin: 0 auto;" >
								<button type="button"  value="수정" onclick="location.href='calUpdateForm?seq=${vo.seq}'" class="btn btn-dark" >수정 </button>
								<button type="button"    value="목록" onclick="location.href='calBoardList'" class="btn btn-dark"  >목록</button>
								<button type="button"    value="달력" onclick="location.href= 'calendar?year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'"class="btn btn-dark"> 달력</button>
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