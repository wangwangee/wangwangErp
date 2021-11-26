package com.example.Vo;

/*
 * 
 * <<상품 수량 관리 >>22222222222222222
	create table Management(
		seq int not null  primary key auto_increment,
		id varchar(20) not null ,
		name varchar(20) not null UNIQUE KEY, 
    	amount int(12) not null DEFAULT 0  
 
	);

 */

/* 
 * 
 * 새테이블
 	create table Management(
 		seq int not null  primary key auto_increment,
		id varchar(20) not null  ,
		name varchar(20) not null UNIQUE KEY , 
    	amount int(12) not null DEFAULT 0    
	);		
 */



//갯수관리
public class ManagementVo {
	private int seq; // (pk)
	private String id; // 사용자의 아이디
	private String name; //상품명       //얘를 프라이머리키로 지정하고
	private int amount; //총수량
 
	
	
	
	public ManagementVo(int seq, String id, String name, int amount) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.amount = amount;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}


 
	

}
