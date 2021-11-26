 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
<%
//controller에서 리다이렉트 방식 아니라 forward방식이라
	//(3)달력의 날짜를 바꾸기 위해 전달된 year와 month 파라미터를 받는다. (forward//jsp에서 요청을 GET파라미터로 보내주고 그 값을 다시 컨트롤러에서 받아서,jsp에서 출력해주는 부분)
	String import_store = request.getParameter("import_store");
	String latitude= request.getParameter("latitude"); 
	String longitude= request.getParameter("longitude"); 
	String seq= request.getParameter("seq"); 
 %>
 
<meta charset="EUC-KR">
<title>오늘의 입출고 등록</title>
</head>
<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
	<div class="container">
 
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/design/unicorn5.png" alt="거래처 수정하기"/>거래처 수정하기</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				 <div class="table-responsive">
				  		<table class="table"> 
<!-- 							<tr style="line-height:32px;"> -->
<!-- 								<th>ID</th> -->
<%-- 								<td><input type ="text" class="form-control" name ="id" value ="${id}" readonly ="redonly"/></td> --%>
<!-- 							</tr> -->
							<tr style="line-height:32px;">
				 				 
								<td>
 
										 	<button type="button" onclick="location.href='nameUpdateDetail?import_store=<%=import_store%>&latitude=<%=latitude%>&longitude=<%=longitude%>&seq=<%=seq%>'"  class="btn btn-outline-secondary btn-lg"> 
										 		 거래처명 수정/거래처 삭제하기
										 		 <img src="<%=request.getContextPath() %>/Image/design/store.png" alt="거래처명 수정/삭제" class="btnImages" class="btn btn-secondary"/>
											</button>
								</td>
								<td>
 
										 	<button type="button" onclick="location.href='mapUpdateForm?import_store=<%=import_store%>&seq=<%=seq%>'"  class="btn btn-outline-secondary btn-lg"> 
										 		 거래처위치 수정하기
										 		 <img src="<%=request.getContextPath() %>/Image/design/map2.png" alt="버튼 출고이미지" class="btnImages"  />
											</button>
								</td>
								
 
 
							</tr>
						</table>
				</div>					 
			 </div>
			</div>
		</div>	
 
	</div>		 
	
</body>
</html>
