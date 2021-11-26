package com.example.Vo;
/*
 * 
 * <<상품 테이블 구현>>
	create table goods(
		seq int not null  primary key auto_increment,
		id varchar(20) not null,
		category varchar(20) not null,
	    import_mdate varchar(12) not null,
    	export_mdate varchar(12),  
    	export_year_month varchar(8), 
		name varchar(20) not null,
		import_store varchar(20) not null,
    	export_store varchar(20),  
		import_price int(12) not null,
    	export_price int(12), 
 		import_amount int(12) not null,
    	export_amount int(12),  
		info varchar(4000),
		pay varchar(1),
		refund varchar(1) 
	);

 */

public class GoodsVo {
	// Goods 테이블
	private int seq; // (pk)
	private String id; // 사용자의 아이디
	private String category; // 카테고리
	private String import_mdate; // 입고날짜
	private String export_mdate ; // 출고날짜
	private String export_year_month; // 수익 년달 (출고년월)
//	private String mdate; // <10.01>    입고,출고 상관없이 일정을 조회해서 보여줄 때 필요한 필드를 추가
	private String name; // 상품명
	private String import_store; // 입고거래처
	private String export_store; // 출고거래처
	private int import_price; // 입고가격 (도매가)
	private int export_price = 0; // 출고가격 (판매가)
	private int import_amount; // 입고갯수
	private int export_amount= 0; // 출고갯수
	private String info; // 상품정보
	private String pay;  //결제 or안됨 
	private String refund; //환불결제 or 안됨
	
	
	// 날짜 정보 파라미터를 받을 용도
	private String year;
	private String month;
	private String date;
	private String hour;
	private String min;
 
	
   
	 
 
//
//	public GoodsVo(int seq, String id, String category, String import_mdate, String name, String import_store,
//			int import_price, int import_amount, String info) {
//		super();
//		this.seq = seq;
//		this.id = id;
//		this.category = category;
//		this.import_mdate = import_mdate;
//		this.name = name;
//		this.import_store = import_store;
//		this.import_price = import_price;
//		this.import_amount = import_amount;
//		this.info = info;
//	}
//
//  
//
//
//	// 출고
//	public GoodsVo(int seq, String id, String category, String export_mdate, String name, String export_store, int export_price, int export_amount, String export_year_month) {
//		super();
//		this.seq = seq;
//		this.id = id;
//		this.category = category;
//		this.export_mdate = export_mdate;
//		this.name = name;
//		this.export_store = export_store;
//		this.export_price = export_price;
//		this.export_amount = export_amount;
//		this.export_year_month = export_year_month;
//
//	}

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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getImport_mdate() {
		return import_mdate;
	}

	public void setImport_mdate(String import_mdate) {
		this.import_mdate = import_mdate;
	}

	public String getExport_mdate() {
		return export_mdate;
	}

	public void setExport_mdate(String export_mdate) {
		this.export_mdate = export_mdate;
	}

	public String getExport_year_month() {
		return export_year_month;
	}

	public void setExport_year_month(String export_year_month) {
		this.export_year_month = export_year_month;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImport_store() {
		return import_store;
	}

	public void setImport_store(String import_store) {
		this.import_store = import_store;
	}

	public String getExport_store() {
		return export_store;
	}

	public void setExport_store(String export_store) {
		this.export_store = export_store;
	}

	public int getImport_price() {
		return import_price;
	}

	public void setImport_price(int import_price) {
		this.import_price = import_price;
	}

	public int getExport_price() {
		return export_price;
	}

	public void setExport_price(int export_price) {
		this.export_price = export_price;
	}

	public int getImport_amount() {
		return import_amount;
	}

	public void setImport_amount(int import_amount) {
		this.import_amount = import_amount;
	}

	public int getExport_amount() {
		return export_amount;
	}

	public void setExport_amount(int export_amount) {
		this.export_amount = export_amount;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
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
	
	
	
	
	
	
	
	// 파라미터를 받아서 년 월 일 합쳐주는 걸 계산하는 용도

	 

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

}
