 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<title>���������α׷�</title>
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
					<h2 style="margin-top: 30px;">�ȳ��ϼ���. ����â���ڸ� ���� ���� �ǸŰ��� �ý��ۿ�  ���� ���� ȯ���մϴ�.</h2>
				</c:when>
				<c:otherwise>
					<h2 style="margin-top: 30px;">�ȳ��ϼ���. ${authUser}�� �ǸŰ��� �ý��ۿ� ���� ���� ȯ���մϴ�.</h2>
				</c:otherwise>
			</c:choose>
			<p>
					 
						1) ���� â���ڰ� ���ϰ� �����ϵ��� ��������ϴ�. ���ۿ� ����� ���α׷��� STS4�̰� ������  Apache Tomcat�� ����߽��ϴ�.<br>
						3) �޴���  ������Ȯ��, ����Ȯ�� �� ���, �ŷ�ó ���, ��ǰ�Ǹż���,���� ����� ���, ���� ����Ȯ�� �ֽ��ϴ�<br>
						4)  ����� ���α׷��־�� �� ��ũ�����: JAVA, MYSQL, JSP, JAVASCRIPT, jQuery, HTML/CSS, SPRING BOOT,BootStrap <br><br>
					</p>
				</div>
			</div>
	<c:import url="/WEB-INF/jsp/includes/footer.jsp" />
</body>
</html>