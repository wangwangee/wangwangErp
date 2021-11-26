<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html xmlns:th="http://www.thymeleaf.org">

<meta charset="utf-8">

<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css"> 
 
 <!-- 로그인된 사용자가 아니라면 로그인창으로 돌려줌 -->
<%
	if(session.getAttribute("authUser") == null) {
 		
        String path =request.getContextPath();
		response.sendRedirect(path+"/user/login");
		return;
	}
%>
  <style>
  	#container{
 		/*border:1px solid red; /*->쓰면 위치파악가능 */
 		width:300px;
 		margin: 0 auto;
 		
 	}
 	
 	 #chart{
 		border-collapse: collapse; /* 표의 테두리를 실선으로 표시한다 */
 		border: 1px solid gray;
 		margin: 0 auto;
 		width:300;
 		height:300;
 	}
 </style>	
</head>

<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
 
<div class='container'>
	<div class="card">
		 <div class="card-header card-header-primary">
			<h4 class="card-title" >  
			<img src="<%=request.getContextPath() %>/Image/design/Bestchart.png" alt="출고"/> 이번달 판매순위</h4>
                    <p class="card-catagory"></p>
					 
			</h4>
                
         </div>	   
	</div>	 



	<div class='col-md-12 text-center' text-align="center">	
		<div  id ="chart">
				<div class="card-body">
<%-- 				<c:set var="jData" value="${jData}" /> --%>
<%-- 				 <c:if test="${empty jData }"> --%>
<!-- 							 	<div class="card-body" style="width:80%;height:50px;float:none; text-align:center; margin:0 auto"> -->
<!-- 							 		-- 출고가 등록되지 않아 판매순위가 없습니다.--  -->
<!-- 								</div> -->
<%-- 					</c:if> --%>
<%-- 				<c:if test="${!empty jData }"> --%>
			
						<div >
						 
							<canvas id="myChart"  style="width:30% heght:20%";></canvas>
						</div>
						
						
						 
				    	</div>
    </div>
<%-- 				</c:if> --%>
		</div>
	</div>	
</div>
</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- 	<script -->
<!-- 		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script> -->
    
    <script src="https://code.jquery.com/jquery-latest.min.js"></script> 

 
    <!-- chart js 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.0/chart.min.js"></script>

	
	<script>
	 
 
		var jsonData = ${json} 
		var jsonObject = JSON.stringify(jsonData);
		var jData = JSON.parse(jsonObject);

		var labelList = new Array();
		var valueList = new Array();
 

		for (var i = 0; i < jData.length; i++) {
			var d = jData[i];
			labelList.push(d.name);
			valueList.push(d.export_amount);
 
		}

		var data = {
			labels : labelList,
			datasets : [ {
				axis: 'y',
				data : valueList,
 				label : "2021년 11월",
 				borderColor:'rgb(255, 99, 132)',
 				backgroundColor: [
 				      'rgba(255, 99, 132, 0.2)',
 				      'rgba(255, 159, 64, 0.2)',
 				      'rgba(255, 205, 86, 0.2)',
 				      'rgba(75, 192, 192, 0.2)',
 				      'rgba(54, 162, 235, 0.2)'
 				 ]     
				// backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
			//	backgroundColor: [ 'red', 'blue', 'green' ], 
			//	borderColor: 'rgb(255, 99, 132)',
			 
			} ],
 
		 
		};

		var ctx1 = document.getElementById("myChart").getContext('2d');
		new Chart(ctx1, {
			type : 'bar',
			data : data,
			options: {  
				indexAxis: 'y', //***가로형 막대로 바꾸는 옵션*** 
			
			}
 	 
		});
	</script>


	 
</body>

</html>