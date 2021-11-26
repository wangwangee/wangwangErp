 <%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.example.Vo.ImportVo"%>
<%@ page import="com.example.Vo.ExportVo"%>
<%@ page import="com.example.Vo.MapVo"%>
<%@ page import="com.example.Utils.Util"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page import="java.io.*, java.util.Date, java.util.Enumeration" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" > </script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<!-- CSS -->
<link href="${pageContext.request.contextPath }/assets/css/goods.css" rel="stylesheet" type="text/css">      
 
 <!-- 결제 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 아래 제이쿼리는 1.0이상이면 원하는 버전을 사용하셔도 무방합니다. -->
<script>
	$(function(){
		$(".check_module").click(function() {
			//완료되면 버튼 히든해주기 위해서
			var aObj =$(this);
			
			var IMP = window.IMP; // 생략가능
			IMP.init('imp68199186');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			var money = $(this).attr("id");  
 			var seq = $(this).attr("value"); //출고일자의 상품명 가져오기.
			 
			IMP.request_pay({
				pg : 'kakao', // version 1.1.0부터 지원.
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '주문명:결제테스트',
				//결제창에서 보여질 이름
				amount : money,
				m_redirect_url : 'http://localhost:8082/calview/calendar'
			/*
			 모바일 결제시,
			 결제가 끝나고 랜딩되는 URL을 지정
			 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			 */
			}, function(rsp) {
 	
				
				
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.\n';
// 					msg += '고유ID : ' + rsp.imp_uid;
// 					msg += '상점 거래ID : ' + rsp.merchant_uid;
// 					msg += '결제 금액 : ' + rsp.paid_amount;
// 					msg += '카드 승인번호 : ' + rsp.apply_num;
					 
  					
					//결제가 완료되면 AJAX로 컨트롤러에 post방식으로 상품명 name을 전달해주어 결제완료 
					//컨트롤러에서 UPDATE TABLE goods SET pay_fl ='Y' WHERE id ='wp' AND name ='name' ;
					$.ajax({
								method:"post", //전송방식
								url:"/calview/goodsBuying", //요청 URL
								data:{"seq":seq}, //key value형식으로 전송
								dataType :"text", //서버로부터 받는 값의 타입 정의
								async:false, //$.ajax()기본이 비동기식 실행이므로, false로 설정함. 
								success:function(val){
									 
								},
								error: function(){
									alert("테이블에 결제 반영 실패!!");
								}
					});				
							
					
					
					
				} else {
					var msg = '결제가 실패되었십니다.\n';
					msg += ' : ' + rsp.error_msg;
				}
				alert(msg);
			});
		});
	});	
</script>
 
  
 
 
<style  type="text/css">
 	img{ width : 18 px; hegiht: 18px; }
  
</style>

</head>
<!--년월일은 세션을 이용해서 넣어놓고~~어쩌고  -->
<%
	 
	List<ImportVo> import_list = (List <ImportVo>)request.getAttribute("import_list");
	List<ExportVo> export_list = (List <ExportVo>)request.getAttribute("export_list");
	Util util = new Util();
 	int money =0;
	int ex_money =0;
%>
<!-- 컨트롤러로부터 import_store명, latitude, longitude를 가져온다 -->

<%
	List<MapVo> map_list = (List <MapVo>)request.getAttribute("map_list");
 

%>


<body>
	<c:import url="/WEB-INF/jsp/includes/header.jsp" />
	<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
 
<div class="container">
 
<!--  <form  class="form-horizontal method="post">  -->
         <div class="col-sm-12 pt-3">	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/design/online-shop.png" alt="일정목록"/> 일정목록 보기</h4>
                    <p class="card-catagory"></p>
                </div>	   
			 <div class="card-body">
				<input type="hidden" name="seq" value="0"/>	
				<div class="table-responsive">
 
					<!-- Carlendar에서 forward방식으로 받아와서 파라미터가 살아있음 
					url에 파라미터가 살아있으면 param.으로 사용이 가능하다-->
					<input type="hidden" name="year" value="${param.year}">
					<input type="hidden" name="month" value="${param.month}">
					<input type="hidden" name="date" value="${param.date}">
					<input type="hidden" id="map_list" value="${param.map_list}"/>
					
					<table class ="table table-striped ">
					 
						<tr style="line-height:32px;">
 
							<th>상품명</th>
							<th>업무날짜</th>
							<th>입/출고</th>
							<th>수행내용</th>
							<th>거래처</th>
							<th>수정하기</th>
 
 
					 
						<%
							 if(import_list!=null || import_list.size()!=0 ){
								for(ImportVo vo : import_list){
					 				money = vo.getImport_amount() * vo.getImport_price();
					 			
						%>
									<tr>
 
										<!-- 상품명 -->
										<td class="goods_name"><%= vo.getName()%></td>
										<!-- 일시 -->
										<td> 
											<% util.setToDates(vo.getImport_mdate()); %>
											<%= util.getToDates() %>
										</td>
										<!-- 입/출고 출력-->
										<td> 수량 <%= vo.getImport_amount()%>개 입고</td>
										<!-- 수행내용-->
										<% String pay=vo.getPay();%>
<!-- 										<td> -->
<%-- 										<%= vo.getPay() %> --%>
<!-- 										</td> -->
										<td>
										<!-- 1102 여기 다시하기~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->	
 										<%   if(vo.getPay().equals("N" ))  {  %>
 										  	<%= money %>원 송금하기
		 									<button type="button" class ="check_module" id="<%= money%>" value="<%= vo.getSeq()%>" >  
												<img src="<%=request.getContextPath() %>/Image/design/cash24.png" alt="btnImages" class="btnImages"/>
											</button>
												 
										<%   } %>	
										
										<%   if(vo.getPay().equals("Y" ))  {  %>
 										  	<%= money %>원 결제완료
		 									 
												 
										<%   } %>		
										</td>
										 
										<!-- 거래처-->
										 <td><%= vo.getImport_store()%></td>
										<!-- 일정보기-->
										<td>
											<button type="button"class="btn btn-dark" onclick="location.href='/calview/calDetail?seq=<%=vo.getSeq()%>&name=<%=vo.getName()%>&date=<%=vo.getImport_mdate() %>'";>일정보기
											</button>
										</td>
									</tr>
									
							<%  }  
							} %>
						 	<%   if(export_list!=null || export_list.size()!=0 ){ 
								 	   for(ExportVo vo : export_list){
								 		  ex_money = vo.getExport_amount() * vo.getExport_price();  
								 		   
								 	%>
									<tr>
									 
										<!-- 상품명 -->
										<td><%= vo.getName()%></td>
										<!-- 일시 -->
										<td> 
											<% util.setToDates(vo.getExport_mdate()); %>
											<%= util.getToDates() %>
										</td>
										<!-- 입/출고 출력-->
										<td>수량 <%= vo.getExport_amount()%>개 출고</td>
										<!-- 수행내용-->
										 <td><%=ex_money%>원 입금예정</td>
										<!-- 거래처-->
										 <td><%= vo.getExport_store()%></td>
										<!-- 일정보기-->
										<td>
											<button type="button"class="btn btn-dark" onclick="location.href='/calview/calDetail_export?seq=<%=vo.getSeq()%>&name=<%=vo.getName()%>&date=<%=vo.getExport_mdate() %>'";>일정보기
											</button>
										</td>
									</tr>
									
									 
									 
							 <% 	}  
						   	} %>
						   	<%  if (( export_list.size()==0) && ( import_list.size()==0)){ %>
								<tr><td colspan='5' style ="text-align:center; margin:0 auto ">---작성된 일정이 없습니다.---</td></tr>
							<% } %>
		 
					</table>
						<br/><br/> 
	   			</div>
    		</div>
		</div>
	</div>		
<!-- 지도 list들 저장 -->	
	<c:forEach items="${map_list}" var="data">
		<input type="hidden" id= "${data.latitude}" class="${data.longitude}" name="map" value="${data.import_store}"/>
	</c:forEach>
 
 
<!-- 	지도일정을 표기해주기 ------>
          <div class="col-sm-12 pt-3" >	
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">  <img src="<%=request.getContextPath() %>/Image/design/map.png" alt="입고일정"/> 입고일정 지도보기</h4>
                </div>
			     <!-- -----------------null처리하기---------------- -->
			  	<c:set var="map_list" value="${map_list}" />
			 	<c:if test="${empty map_list  }">
				 	<div class="card-body" style="width:80%;height:50px;float:none; text-align:center; margin:0 auto">
				 		--입고일정이 없거나 거래처가 등록되지 않았습니다.-- 
					</div>
				</c:if>
				<!-- -----------------null이 아닌 경우 처리하기---------------- -->
                <c:if test="${!empty map_list }">	
					<div class="card-body" id="map" style="width:80%;height:250px;float:none; margin:0 auto">
					</div>
				   <div class="card-footer text-muted">
				   	 	[ 입고예정 거래처 ] </br>
				   		<c:forEach var="item" items="${map_list}">
 						    ●  ${item.import_store}  
 						 	     <button type="button"class="btn btn-dark" onclick="location.href='/map/UpdateDetail?import_store=${item.import_store}&latitude=${item.latitude}&longitude=${item.longitude}&seq=${item.seq}'";>수정</button>
 						    
 						    </br>
						  
						</c:forEach>
 
				   </div>
			   </c:if>
			</div>
			 <div class="card-footer" style ="text-align:center">
				<button onclick="setBounds()" class="btn btn-dark" >
					오늘의 일정 확인
					 <img src="<%=request.getContextPath() %>/Image/design/map.png" alt="버튼 출고이미지" class="btnImages"  />
				</button>
				<button  type ="button" class="btn btn-dark" onclick= "location.href='/calview/calendar?year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'">
					달력보기
					<img src="<%=request.getContextPath() %>/Image/design/calendar3.png" alt="버튼 출고이미지" class="btnImages"  />
				</button>
			</div>	 
		</div>		 
</div>		
 
 	<!-- 지도 API -->
 
	 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8840fe0237d080e22274b64afa93c87e"></script>
	<script>
	var script = document.createElement('script');
	script.src ="https://t1.daumcdn.net/mapjsapi/js/main/4.4.2/kakao.js";
 
	document.head.appendChild(script);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.53942161485577, 126.98748004846598), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		 
		// 마커를 표시할 위치와 title 객체 배열입니다 
		//for문돌면서 바꾸기로 바꿔보기
		var positions =[];
 
	 
		var grpl = $("input[name=map]").length;
				//배열 생성
		var grparr = new Array(grpl);
				//배열에 값 주입
		for(var i=0; i<grpl; i++){                          
				  
			var place = $("input[name=map]").eq(i).val(); //장소명
			var latitude = $("input[name=map]").eq(i).attr("id"); //위도
			var longitude = $("input[name=map]").eq(i).attr("class"); //경도
 
			positions.push({
				 title: place
						 ,latlng:new kakao.maps.LatLng(latitude,longitude)  
			});	
		}
 
 	 	
		// 마커 이미지의 이미지 주소입니다
	 
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		var bounds = new kakao.maps.LatLngBounds();    
		
		for (var i = 0; i < positions.length; i ++) {
		    
 
		 
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
 
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
 
		        position: positions[i].latlng, // 마커를 표시할 위치
 		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
 
		    });
		    marker.setMap(map);
		    // LatLngBounds 객체에 좌표를 추가합니다
     	    bounds.extend(positions[i].latlng);   
		 
		    
 		}
		function setBounds() {
		    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
		    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
		    map.setBounds(bounds);
		}
 
	</script>
 
<c:import url="/WEB-INF/jsp/includes/footer.jsp" />			 	
</body>
 




 