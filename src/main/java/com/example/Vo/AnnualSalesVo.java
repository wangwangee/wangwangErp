package com.example.Vo;

 
//연 매출 그래프를 그리기 위해 AnnualSalesVo를 작성, jsp로 값을 보내기 위한 VO
//Profit 테이블의 mdate와 total_income만 받아온다.
public class AnnualSalesVo {

	private String mdate; //년 ,월
	private int  total_income; //수익
	
	
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public int getTotal_income() {
		return total_income;
	}
	public void setTotal_income(int total_income) {
		this.total_income = total_income;
	}
	
	
	
	
}
