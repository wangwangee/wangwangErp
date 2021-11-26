package com.example.Utils;

 

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Util {
	//Usebean을 사용하기위해 vo형태로 만든다.
	private String toDates;
	public void setToDates(String mdate) {
  
			//문자열 --> date타입으로 변환 -->하기위해 String을 변환, 문자열을 데이트 패턴으로 수정 -> 데이트타입으로 변환
			//날짜형식 : yyyy-MM-dd hh:mm:ss
			String  m = mdate.substring(0, 4)+"-"
					  + mdate.substring(4, 6)+"-"
					  + mdate.substring(6, 8)+" "
					  + mdate.substring(8, 10)+":"
					  + mdate.substring(10)+":00";
			 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일HH시mm분");
			 
			Timestamp tm = Timestamp.valueOf(m); //문자열을 Date 타입으로 변환
			
			//return sdf.format(tm);
			this.toDates=sdf.format(tm);
  
	}
 
	public String getToDates() {
		return toDates;
	}



	//토요일과 일요일을 확인해서 "blue" , "red" 문자열을 반환하는 메서드
	//자주 사용하는 경우 static선언하면 new로 만들지 않고
	//클래스명.메소드로 호출이 가능하다.
	public static String fontColor(int dayOfweek, int i){ //외부에서 값을 받아온다
		String color ="";
		if((dayOfweek-1+i)%7==0){ //토요일일 경우. 파랑색으로 만들기
			color ="blue";
		}else if((dayOfweek-1+i)%7==1){ //틸요일인 경우,
			color ="red";
		}else{  						//외의 요일인 경우
			color ="black"; 
		}
		return color;
	}
	//1자리 값 문자열을 2자리 문자열로 변환하는 메서드 
	public static String isTwo(String msg) {
	 
		return msg.length()<2? "0"+msg: msg;		
	}
	 
	
 
	
	
}
