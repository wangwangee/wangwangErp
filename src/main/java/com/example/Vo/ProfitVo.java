package com.example.Vo;

 

/*
 * <<수익 테이블>>
 create table profit(
 	seq int not null primary key auto_increment,
 	id varchar(20) not null,
 	mdate varchar(6) not null UNIQUE KEY,  
 	total_income int(12) not null DEFAULT 0,
 	year  int(12) not null,
 	month  int(12) not null, 
 	month_amount int(12)
  );
 
 
 * 
 */






public class ProfitVo {
	//수익테이블
	private int seq =0; //프라이머리키
	private String id; //아이디
	private String mdate; //수익이 난 날짜       -><10.01>날짜랑  조회해서 재고알림
	private int total_income =0; //총수익
	//<<09.26 추가 부분>>
	private int year; //수익 난 년도
	private int month ; //수익 난 달
	private int month_amount; //출고달의 수량     -><10.01>수량을 조회해서 재고알림
	
	 
	
	public ProfitVo(int seq, String id, String mdate, int total_income, int year, int month, int month_amount) {
		super();
		this.seq = seq;
		this.id = id;
		this.mdate = mdate;
		this.total_income = total_income;
		this.year = year;
		this.month = month;
		this.month_amount = month_amount;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
 


	public int getYear() {
		return year;
	}


	public void setYear(int year) {
		this.year = year;
	}


	public int getMonth() {
		return month;
	}


	public void setMonth(int month) {
		this.month = month;
	}

	public int getMonth_amount() {
		return month_amount;
	}

	public void setMonth_amount(int month_amount) {
		this.month_amount = month_amount;
	}
	
	
	
	
}
