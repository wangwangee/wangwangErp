<%@page import="com.example.Utils.Util"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.example.Vo.ImportVo"%>
<%@page import="com.example.Vo.ExportVo"%>
<%@ page import="java.util.List"%>
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
 
<title></title>
 
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script >

 

<style type="text/css">
	#card2 {
		text-align : center;
		margin: 0 auto;
		
	}

 	#calendar{
 		border-collapse: collapse; /* ǥ�� �׵θ��� �Ǽ����� ǥ���Ѵ� */
 		border: 1px solid gray;
 
 	}
 	#calendar td{
 		border: 1px solid gray;
 		width: 200px;
 		height: 100px;
 		text-align : left;
 		 vertical-align: top;
 	}
 	
 
 	/*��Ŀ�±��� ������ �������ش�.- css �ּ�*/
 	
 	a{
 		text-decoration: none;
 	
 	}
 	/* ���� �̹���ũ�⸦ �ٿ��ش�.*/
 
 	
 	#container{
 		/*border:1px solid red; ->���� ��ġ�ľǰ��� */
 		width:800px;
 		margin: 0 auto;
 		
 	}
 	#container td > p{
 		margin-bottom:1px;
 		font-size: 5x;
 		background-color : rgba(254, 213, 226,0.5);

 	}
 	td:hover{
 		background-color:rgba(216, 209, 215,0.5);
 	}
 	.cPreview{
 		position: absolute;
  	 
 		background : pink;
 		width :40px;
 		height: 40px;
 		text-align: center;
 		line-height : 40px;
 		font-weight : bold;
 		border-radius: 20px 20px 1px 20px; 
 		background : pink;
 		width :40px;
 		height: 40px;
 		text-align: center;
 		line-height : 40px;
 		font-weight : bold;
 		border-radius: 20px 20px 1px 20px;
 	}
 	td{
 		postion : relative;
 	}
 	
</style>

<script type="text/javascript" >
//���� 1�ڸ��̸�, ���ڸ��� ������ִ� ���
	function isTwo(str){
		return str.length<2?"0"+str:str;
	}
//domŽ�� 
//$(function(){}) --> window.onload=function(){}
	$(function(){
		$(".countView").hover(function(){
			var aObj =$(this);
			var year = $(".y").text().trim(); //���� dom���� ������
			var month = $(".m").text().trim(); //��
			var date= $(this).text().trim();    //��
			var yyyyMMdd = year+isTwo(month)+isTwo(date);
			
			//alert(yyyyMMdd);
		
			$.ajax({
				method:"post", //���۹��
				url:"/calview/calCountAjax", //��û URL
				data:{"yyyyMMdd":yyyyMMdd}, //key value�������� ����
				dataType :"text", //�����κ��� �޴� ���� Ÿ�� ����
				async:false, //$.ajax()�⺻�� �񵿱�� �����̹Ƿ�, false�� ������. 
				success:function(val){
					//alert("������� ����~~"+val);
					aObj.after("<div class='cPreview'>"+val+"</div>");0
				},
				error: function(){
					alert("������� ����!!");
				}
			});
		},function(){		
			$(".cPreview").remove();	//���콺�� ������ �ش� ������Ʈ�� �����Ѵ�.
		}); 
	});
	 
	
</script>
 
 
 
</head>
  <!-- �α��ε� ����ڰ� �ƴ϶�� �α���â���� ������ -->
<%
	if(session.getAttribute("authUser") == null) {
 		
        String path =request.getContextPath();
		response.sendRedirect(path+"/user/login");
		return;
	}
%>
 


<%
//controller���� �����̷�Ʈ ��� �ƴ϶� forward����̶�
	//(3)�޷��� ��¥�� �ٲٱ� ���� ���޵� year�� month �Ķ���͸� �޴´�. (forward//jsp���� ��û�� GET�Ķ���ͷ� �����ְ� �� ���� �ٽ� ��Ʈ�ѷ����� �޾Ƽ�,jsp���� ������ִ� �κ�)
	String paramYear = request.getParameter("year");
	String paramMonth= request.getParameter("month");

	//(0) Ķ���� API����, ���� �⵵�� ���� ����
	Calendar cal = Calendar.getInstance(); //new(x)
	int year =cal.get(Calendar.YEAR) ; //���� �⵵�� ����
	int month =cal.get(Calendar.MONTH)+1 ; //���� ���� ����(0~11��)
	
	//(4)���� paramYear null �̾ƴ϶��, jsp���� ȭ��ǥ ������ ��û�� �� ��� ->���ο� ��,�������� �޷� ����ؾ��ϹǷ� �ٲ��ִ� �κ�
	if(paramYear !=null){
		year=Integer.parseInt(paramYear); //���ڿ��� ���ڷ� ��ȯ��Ű�� ���
	}
	if(paramMonth !=null){
		month = Integer.parseInt(paramMonth);
	}
	//(5)month����� �Ѿ��� Ŀ����, ���̳ʽ� �Ǵ� ��Ȳ ����
	//���� �����ϴٰ� 12���� Ŀ���� 13,14....�Ѿ�� ���� ó��
	if(month >12){
		month=1; //1���� ����
		year++; //�⵵�� �����ط� �Ѿ�ϱ� �⵵ +1 ������Ű��
	}
	
	if(month <1){
		month=12; //12���� ����
		year--; //�⵵�� ���⵵�� �Ѿ�ϱ� �⵵ -1 ���ҽ�Ű��
	}
	
	
	//(1)���� ���� 1�Ͽ� ���� ���� ���ϱ� : 1~7 --> 1(�Ͽ���),2(��),3()....7(��)
	
	//int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);������ ������ ���ϴ� ��(ex.4��7���� ����)
	//set(y,month-1,1) month-1: calendar���� (0~11), �츮���� (1~12)
	cal.set(year, month-1, 1); //���� 4�� 1�Ͽ� ���� ��¥�� ���� ->Ķ������ �����޽� -1��� 4���� �ν���.
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK); // 1�Ͽ����� ���ϱ��� ->5:�����
	
	//(2)���� ���� ������ �� ���ϱ� (���� ���� �߿� �ִ� ��)
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	//(7-7�� )�ش� ���� ��� ���� �ޱ�
	List<ImportVo> clist =(List<ImportVo>)request.getAttribute("clist");
	List<ExportVo> clist2 =(List<ExportVo>)request.getAttribute("clist2");
%>




<body>

 




<c:import url="/WEB-INF/jsp/includes/header.jsp" />
<c:import url="/WEB-INF/jsp/includes/nav.jsp" />
<div id ="container"> 
 
<h2><img src="<%=request.getContextPath() %>/Image/design/march.png" alt="��������"/> �������� </h2>
 
 
 
<div class="col-sm-12 pt-3" id ="card2">	
	<div class="card">
		 <div class="card-header card-header-primary">
			<h4 class="card-title" >  
					 
					<%-- ?�ڿ� year, month ���� ������ Controller�� ���� --%>
					<a href ="calendar?year=<%=year-1%>&month=<%=month%>">
						 <img src="<%=request.getContextPath() %>/Image/calendar/heart.png" alt="�۳�"/>
					</a>
					<a href ="calendar?year=<%=year%>&month=<%=month-1%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/next2.png" alt="������"/>
					</a>
					 
					<span class="y"><%= year %></span>�� <span class="m"><%=month %></span>�� 
					<a href ="calendar?year=<%=year%>&month=<%=month+1%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/next.png" alt="������"/>
					</a>
					<a href ="calendar?year=<%=year+1%>&month=<%=month%>">
						<img src="<%=request.getContextPath() %>/Image/calendar/heart.png" alt="����"/>
					</a>
 	 
			</h4>
               <p class="card-catagory"></p>
         </div>	   
		 
			<div class="table-responsive">
				<table  class ="table-bordered"  id="calendar">
				 
					<tr>
						<th>��</th>
						<th>��</th>
						<th>ȭ</th>
						<th>��</th>
						<th>��</th>
						<th>��</th>
						<th>��</th>
					</tr>
					<tr>
						<%	//�޷¿� �����ϴ� ������ ����Ѵ�.
						
							//(1) ������ ����ϴ� for�� (������� 1���� ��� �տ� ������ ���~)
							for(int i=0; i<dayOfweek-1; i++){
								out.print("<td>&nbsp;</td>");
							}
							//(2) ��¥�� ����ϴ� for�� (1���� ������������)
							//��¥�� Ŭ������ ��, ~
							for(int i=1; i<=lastDay; i++ ){
								%>
								<td>
									<%-- ������ �߰��ϴ� �κ� ����  --%>
									<%-- for���ȿ� i�� dayOfweek�� �޼ҵ忡 �����ؼ� String ��ȯ --%>
									<%--�� Map���� ������ ��� �����غ��� --%>
									<a class="countView" style="color:<%=Util.fontColor(dayOfweek,i) %>;" href ="calBoardList?year=<%=year%>&month=<%=month%>&date=<%=i%>"> <%=i %></a>
									<%-- ���� �߰��� ����� �������ش� --%>
									<a href ="calImport?year=<%=year%>&month=<%=month%>&date=<%=i%>">
										<img src="<%=request.getContextPath() %>/Image/calendar/packing.png" alt="�԰�"/>
									</a>
									<a href ="calExport?year=<%=year%>&month=<%=month%>&date=<%=i%>">	
										<img src="<%=request.getContextPath() %>/Image/calendar/ex_goods.png" alt="���"/>
									</a>
									<%=getCalViewList(i,clist) %>
									<%=getCalViewList2(i,clist2) %>
								</td>
								<%
								//(3) ���� �ٲ��ֱ� ---> ������(i)�� ��������� Ȯ�� : (�����+���糯¥)�� ���� 7�� ������������ 7�ǹ��
								if((dayOfweek-1+i)%7==0){
									out.print("</tr><tr>");
								}
								
								
				 
							 
							}
							//(4) ������ ���� ��� for�� (�̻� ���� �� ä���) 
							//��. ���� �̻��� ���� ���ϱ�
							int countNbsp = ( 7- (dayOfweek-1 +lastDay)%7 ) %7 ;
							for(int i=0; i<countNbsp; i++){
								out.print("<td>&nbsp</td>");
							}
							
						%>
					</tr>
					
				</table>
			</div>
    	 
	 </div>
</div>						
				
				
 <%!public String getCalViewList (int i, List<ImportVo> clist) {
	 	String d =Util.isTwo(i+"");//�޷����� �޴� ���ڿ� �ϼ��� ����ġ��Ű�� ����
	 	String cList=""; //�޷¿� ������� ���������� ������ ����
	 	for(ImportVo vo: clist){
	 		if( vo.getImport_mdate().substring(6,8).equals(d) ){ //5��5���� ���� 05��©�����
	 			
	 			
	 			cList+="<p>"
	 					+( vo.getName().length()>6 ?  vo.getName().substring(0,6)+".." : vo.getName() )
	 					+"</p>";
	 		}
	 	} 
	 	return cList;  //��� <p> title </p> <p> title</p>
 	}%> 
  <%!public String getCalViewList2 (int i, List<ExportVo> clist2) {
	 	String d =Util.isTwo(i+"");//�޷����� �޴� ���ڿ� �ϼ��� ����ġ��Ű�� ����
	 	String cList=""; //�޷¿� ������� ���������� ������ ����
	 	for(ExportVo vo: clist2){
	 		if( vo.getExport_mdate().substring(6,8).equals(d) ){ //5��5���� ���� 05��©�����
	 			cList+="<p>"
	 					+( vo.getName().length()>6 ?  vo.getName().substring(0,6)+".." : vo.getName() )
	 					+"</p>";
	 		}
	 	} 
	 	return cList;  //��� <p> title </p> <p> title</p>
 	}%> 
 </div>
 
</body>
</html>