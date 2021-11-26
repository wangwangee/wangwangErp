 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- 아이콘 -->
<script src="https://kit.fontawesome.com/a076d05399.js"  crossorigin="anonymous"></script>

</head>
<!-- 연매출 확인에서 매출을 확인 요청하면 여기서 ???에 보내서 연+달을 입력받아서 year연+달 보여주기!!! -->
 <!-- 연/달/일은 오늘의 입출고 등록시 필요-->
<%
	Calendar cal = Calendar.getInstance(); //new(x)
	int year =cal.get(Calendar.YEAR) ; //현재 년도를 구함
	int month =cal.get(Calendar.MONTH)+1 ; //현재 월을 구함(0~11월)
	int date =cal.get(Calendar.DATE); 
%>
<style>
	 
</style>


<body>
<!-- 메뉴바 -->
  <!-- 메뉴바에는 navbar 클래스를 추가해야한다.  -->
  <nav id="nav" class="navbar navbar-expand-sm navbar-dark bg-secondary"  >
     <!-- Logo -->
	  <a class="navbar-brand" href="/" style="color: black "><i class="fas fa-home"></i>HOME</a>
	  
	   <!-- menu -->
	  <div class="topnav">
	     <a id="menu1"  href="${pageContext.request.contextPath }/chart/annualSales?year=<%=year%>&month=<%=month%>">연매출확인</a>
		 <a id="menu1"  href="${pageContext.request.contextPath }/calview/calendar">일정확인 및 등록</a>
		 <a id="menu1"  href="${pageContext.request.contextPath }/map/accountRecord" >거래처 등록</a> 
		 <a id="menu1"  href="${pageContext.request.contextPath }/chart/bestItems?year=<%=year%>&month=<%=month%>">상품판매순위</a> 
		 <a id="menu1"  href="${pageContext.request.contextPath }/calview/todayImportExport?year=<%=year%>&month=<%=month%>&date=<%=date%>">오늘 입출고 등록</a> 
		 <a id="menu1"  href="${pageContext.request.contextPath }/calview/calBoardList?year=<%=year%>&month=<%=month%>&date=<%=date%>">오늘 일정확인</a>
 
		  
		 <c:choose>
					<c:when test="${empty authUser }">
						<a id="menu2"  href="${pageContext.request.contextPath }/user/join">회원가입</a>
						<a id="menu2"  href="${pageContext.request.contextPath }/user/login">로그인</a>
					</c:when>
					<c:otherwise>
						<a id="menu2"  href="${pageContext.request.contextPath }/user/update">회원정보수정</a>
						<a id="menu2" href ="${pageContext.request.contextPath }/user/logout">로그아웃</a>
					 
					</c:otherwise>
				</c:choose>
    </div>
  </nav>
<!-- jquery -->
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script type="text/javascript"  src="${pageContext.request.contextPath }/assets/javascript/nav.js" charset="utf-8"></script>     
</body>
</html>