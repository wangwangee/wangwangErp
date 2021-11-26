<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>로그인 페이지</title>
</head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
</head>
  
 
    <title>로그인 폼</title>
 
<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />

	<!-- 로그인 form -->
<div class="container login-container">
   <div class="row">
      <div class="col-md-6 login-form-1">
         <h3>Login for Form 1</h3>
			 
			<form method="post" autocomplete="off"">
			<h5 class="form-signin-heading">로그인 정보를 입력하세요</h5>
				<div class="form-group">
					<label  for="id"><strong>Your id</strong></label> 
					<input type="text" class="form-control" placeholder="Your Email *" name="id" id="id" autofocus required> <br />
				</div>
				<div class="form-group">
					<label  class="sr-only" for="pwd"><strong>Password</strong></label> 
					<input  class="form-control" placeholder="Your Password *" type="password" name="pwd" id="pwd" required>  
				</div>
				<div class="form-group">
					<c:if test="${'fail' == param.fail }">
						<p>로그인이 실패 했습니다.</p>
					</c:if>
				</div>
				<button type="submit" class="btn btn-secondary btn-block"  id="login-submit">로그인</button>
			 
			</form>
	 		 
		</div>
	</div>
</div>			
<c:import url="/WEB-INF/jsp/includes/footer.jsp" />		
</body>
</html>