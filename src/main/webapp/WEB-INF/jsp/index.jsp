 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<title>재고관리프로그램</title>
<style type="text/css">
 #wrap { 
 
 	 
    }
  
 
</style>
<link href="${pageContext.request.contextPath }/assets/css/main.css" rel="stylesheet" type="text/css">

</head>
 


<body>
<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
	
	<div id="wrap">
			<div id="content">
			<img id="profile" src="${pageContext.request.contextPath }/Image/design/unicorn_main.png">
			 
			<c:choose>
				<c:when test="${empty authUser }">
					<h2 style="margin-top: 30px;">안녕하세요. 일인창업자를 위한 작은 판매관리 시스템에  오신 것을 환영합니다.</h2>
				</c:when>
				<c:otherwise>
					<h2 style="margin-top: 30px;">안녕하세요. ${authUser}님 판매관리 시스템에 오신 것을 환영합니다.</h2>
				</c:otherwise>
			</c:choose>
			<p>
					 
						1) 일인 창업자가 편리하게 관리하도록 만들었습니다. 제작에 사용한 프로그램은 STS4이고 서버는  Apache Tomcat을 사용했습니다.<br>
						3) 메뉴는  연매출확인, 일정확인 및 등록, 거래처 등록, 상품판매순위,오늘 입출고 등록, 오늘 일정확인 있습니다<br>
						4)  사용한 프로그래밍언어 및 마크업언어: JAVA, MYSQL, JSP, JAVASCRIPT, jQuery, HTML/CSS, SPRING BOOT,BootStrap <br><br>
					</p>
				</div>
			</div>
	<c:import url="/WEB-INF/jsp/includes/footer.jsp" />
</body>
</html>