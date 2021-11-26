package com.example.Vo;

//list에 출력하기 위한 VO생성

public class ExportVo {
	private int seq;
	private String name; // 상품명
	private int export_amount; //수량
	private int export_price;     //가격
	private String export_mdate; //입출고 수행일짜
	private String export_store; // 거래처명
	
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
	public int getExport_amount() {
		return export_amount;
	}
	public void setExport_amount(int export_amount) {
		this.export_amount = export_amount;
	}
	public int getExport_price() {
		return export_price;
	}
	public void setExport_price(int export_price) {
		this.export_price = export_price;
	}
	public String getExport_mdate() {
		return export_mdate;
	}
	public void setExport_mdate(String export_mdate) {
		this.export_mdate = export_mdate;
	}
	public String getExport_store() {
		return export_store;
	}
	public void setExport_store(String export_store) {
		this.export_store = export_store;
	}
 
 
	
	
	
	 

}
