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
	//GET파라미터로 받는다.
	String latitude= request.getParameter("latitude");
	String longitude= request.getParameter("longitude");
	String import_store= request.getParameter("import_store");
	String seq= request.getParameter("seq");
	//세션에서 로그인 해둔 아이디를 받는다
	String id =  (String)request.getAttribute("id");
 
%>
<style>
	th{width :300px;}
 
</style>
 
</head>
 
<body>
 
<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div class="container">
	<form action="nameUpdateForm" class="form-horizontal"  method ="post">
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/design/map2.png" alt="거래처등록"/> &nbsp 거래처 수정</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				<div class="table-responsive">
				<input type="hidden" name="seq" value="<%=seq%>"/>
			  		<table class="table">
			  		 
					    <tr style="line-height:32px;">
							<th >ID</th>
							<td colspan ="8"><input type ="text" name ="id" value ="${id}" readonly/></td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td><input type ="text" name ="import_store" required/></td>
						 </tr>
						 <tr>
							<th>위도</th>
							<td><input type ="text" name ="latitude" value =<%=latitude%> required  readonly/></td>
						</tr>
						
						<tr>
							<th>경도</th>
							<td><input type ="text" name ="longitude" value =<%=longitude%> readonly required   readonly /></td>
						</tr>			
						
						 
						<tr style="line-height:32px;">
							<td colspan="16" style ="text-align: center;">
								<input type ="submit"  class="btn btn-dark"  value ="거래처 수정하기"/> 
								 
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