<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>회원탈퇴 페이지</title>
</head>
<body>    
      <form role="form" method="post"  autocomplete="off" action="/user/withdraw">
                   <!-- 이름 -->
      <label for="name"><strong>이름</strong></label> 
	  <input type="text"  class="form-control"  id="name"  name="name"  value="${userVo.name}"  required> 
	  
	                              <br/><br/>
                    
      <!-- 아이디 -->
      <label for="id"><strong>아이디</strong></label>               
      <input id="id"  class="form-control" name="id"  type="text"  value="${userVo.id}" required readonly> 
	  
	                            <br/><br/>
                   
      <!-- 비밀번호 -->
      <label for="password"><strong>비밀번호</strong></label>
       <input type="password"  name="pwd" class="form-control"  id="pwd"  required>
       
                                <br/><br/>
                    
      <!-- 비밀번호확인 -->
      <label for="confirmpassword"><strong>비밀번호 확인</strong></label>
      <input type="password"  class="form-control" id="confirmpassword"  required>
      
                                <br/><br/>
 
	  
	                       <br/><br/>
                   
      <button type="submit"  id="submit" class="btn btn-primary"> 회원 탈퇴</button>
      <input type="reset"  value="회원탈퇴취소"  onclick="location.href='/index'">     	
   </form>   
 
 </body>       
</html>