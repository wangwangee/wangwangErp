package com.example.Vo;

//list에 출력하기 위한 VO생성

public class ImportVo {
	private int seq;
	private String name; // 상품명
	private int import_amount; //수량
	private int import_price;     //가격
	private String import_mdate; //입출고 수행일짜
	private String import_store; // 거래처명
	private String pay;  //결제 or안됨 
	private String refund; //환불결제 or 안됨
	
	
	
	
	public ImportVo(int seq, String name, int import_amount, int import_price, String import_mdate, String import_store) {
		super();
		this.seq = seq;
		this.name = name;
		this.import_amount = import_amount;
		this.import_price = import_price;
		this.import_mdate = import_mdate;
		this.import_store = import_store;
 
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getImport_amount() {
		return import_amount;
	}
	public void setImport_amount(int import_amount) {
		this.import_amount = import_amount;
	}
	public int getImport_price() {
		return import_price;
	}
	public void setImport_price(int import_price) {
		this.import_price = import_price;
	}
	public String getImport_mdate() {
		return import_mdate;
	}
	public void setImport_mdate(String import_mdate) {
		this.import_mdate = import_mdate;
	}
	public String getImport_store() {
		return import_store;
	}
	public void setImport_store(String import_store) {
		this.import_store = import_store;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getRefund() {
		return refund;
	}
	public void setRefund_fl(String refund) {
		this.refund = refund;
	}
	
 
	
	
	
	 

}
