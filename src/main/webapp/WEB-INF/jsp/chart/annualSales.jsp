  <%@page import="com.example.Vo.AnnualSalesVo"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
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
 <style>
  	#container{
 		/*border:1px solid red; /*->쓰면 위치파악가능 */
 		width:700px;
 		margin: 0 auto;
 		
 	}
  	#graph{
 		border-collapse: collapse; /* 표의 테두리를 실선으로 표시한다 */
 		border: 1px solid gray;
 
 	}
 </style>
 
 <!-- 로그인된 사용자가 아니라면 로그인창으로 돌려줌 -->
<%
	if(session.getAttribute("authUser") == null) {
 		
        String path =request.getContextPath();
		response.sendRedirect(path+"/user/login");
		return;
	}
	

 
String list = (String)  request.getAttribute("json");
 
%>
 
</head>

<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
 <div id ="container"> 
	<div class='row'>
		<div class="card">
			 <div class="card-header card-header-primary">
				<h4 class="card-title" >  
				<img src="<%=request.getContextPath() %>/Image/design/lineGraph.png" alt="연매출 그래프"/> 연매출그래프</h4>
	                    <p class="card-catagory"></p>
						 
				</h4>
				<script>console.log(list);  </script>
	                
	         </div>	   
		</div>	 
	 
	
	
		<div class='col-md-12 text-center' text-align="center">	
			<div id ="graph">
					<div class="card-body">
		 
								<div>
								 
									<canvas id="line-chart" width="700" height="400"></canvas>
								</div>
					 
					</div>
					<div class="card-footer">
						<div>
							연매출 최고는 <span id ="numberone_month"> </span> , <span id ="numberone"> </span>윈입니다.
							 <img src="<%=request.getContextPath() %>/Image/design/money.png" alt="매출최고"//>
							 </br></br>
							 <img src="<%=request.getContextPath() %>/Image/design/cryUnicorn.png" alt="매출최저"//>
							연매출 최저는 <span id ="last_month"> </span>,  <span id ="last"> </span>원 입니다.
							  
							 </br></br>
						</div>
					</div>
			</div>	
		</div>
	</div>
</div>	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>
 

	
	<script>
	 
 
		var jsonData = ${json} 
		var jsonObject = JSON.stringify(jsonData);
		var jData = JSON.parse(jsonObject);

		var labelList = new Array();
		var valueList = new Array();
 
		//판매순위를 알아내기 위한 배열
		var arrNum =new Array() ;
		//판매순위 결과값 배열
		var result ; 

		for (var i = 0; i < jData.length; i++) {
			var d = jData[i];
			labelList.push(d.mdate);
			valueList.push(d.total_income);
			//판매순위를 알아내기 위한 정렬
			arrNum.push(d.total_income);
			result = arrNum.sort(function(a, b){
				return a - b ;
			}) ;
			 
			 
		}
		console.log( result ) ; 
		var last;
		var numberone;
		//1위 , 마지막 순위를 넣어준다.
		last  =result[0];
		numberone=result[result.length-1];   
	 
	 	//body로 값을 넘겨주기
		 document.getElementById('numberone').innerText =' '+numberone +' ';
		 document.getElementById('last').innerText =' '+last +' ';
		 console.log(last);
		 console.log(numberone);
		  

		 console.log(valueList.indexOf(last));
		 console.log(valueList.indexOf(numberone));
		 
		 console.log(labelList[valueList.indexOf(last)]);
		 console.log( labelList[valueList.indexOf(numberone)]);
		//body로 값을 넘겨주기
		 document.getElementById('numberone_month').innerText =' '+labelList[valueList.indexOf(numberone)]+' ';
		 document.getElementById('last_month').innerText =' '+ labelList[valueList.indexOf(last)]+' ';
 
		 
		var data = {
			labels : labelList,
			datasets : [ {
				data : valueList,
				label : "2021",
				borderColor:"#3e95cd",
				backgroundColor: "rgba(255, 201, 14, 0.5)",
				fill: false
			 
			} ],
			options : {
				title : {
					display : true,
					text : '입력된 달 별 소득수준 출력'
				}
			 
		
		
		
			}
		};

		var ctx1 = document.getElementById("line-chart").getContext('2d');
		new Chart(ctx1, {
			type : 'line',
			data : data
		});
	 
		 
	</script>

	
	<c:import url="/WEB-INF/jsp/includes/footer.jsp" />
</body>

</html>