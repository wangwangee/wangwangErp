<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>회원가입 페이지</title>            
 
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
</head>
<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
	<div id="wrap">	
      <form role="form"  method="post"  autocomplete="off">
       <!-- 이미지사진 -->
	  <div>
		 <img src="${pageContext.request.contextPath }/Image/design/human.png"  id="login_img">
	 </div>
      
      <!-- 이름 -->
       <div class="form-group">
     	 <label for="name"><strong>이름</strong></label> 
	 	 <input type="text"  class="form-control"  id="name"  name="name"  value=""  required> 
	  </div>
                  
      <!-- 아이디 -->
      <div class="form-group">
     	 <label for="id"><strong>아이디</strong></label>               
    	  <input id="id"  class="form-control" name="id"  type="text"  value="" required> 
	  </div>
                   
      <!-- 비밀번호 -->
      <div class="form-group"> 
     	 <label for="pwd"><strong>비밀번호</strong></label>
     	  <input type="password"  name="pwd" class="form-control"  id="pwd"  required>
       </div>
                                 
                    
      <!-- 비밀번호확인 -->
      <div class="form-group">
   	   <label for="confirmpassword"><strong>비밀번호 확인</strong></label>
     	 <input type="password"  class="form-control" id="confirmpassword"  required>
      </div>
 
                   
                   
      <button type="submit"  id="submit" class="btn btn-primary"> 회원가입</button>
      
      </form>
      </div>
<c:import url="/WEB-INF/jsp/includes/footer.jsp" />	
 
  
</body>       
</html>