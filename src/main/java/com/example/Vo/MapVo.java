package com.example.Vo;
/*
 * 
 * <<상품 테이블 구현>>
	create table map(
		seq int not null  primary key auto_increment,
		id varchar(20) not null,
    	import_store varchar(30) not null,  
	  	latitude varchar(30) not null,
	  	longitude varchar(30) not null
	);

 */
public class MapVo {
	private int seq;
	private String id; // id
	private String import_store;
	private String latitude;
	private String longitude;
	
	
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
 
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getImport_store() {
		return import_store;
	}
	public void setImport_store(String import_store) {
		this.import_store = import_store;
	}
	
	
	
}
