package com.example.Vo;

import java.util.Date;

//db를 써야하는데 db를 직접적 접근이아니라 spring통해 접근하도록
//domain 패키지 생성
/*
 * 
 * 각계층간 데이터 교환을 위한 자바 객체를 의미한다. 데이터를 에이어간 전달하는 목적을 가지고있다
 * 
create table member (
    id varchar(20) not null primary key,
    pwd varchar(20) not null,
   	name varchar(20) not null,
    regtime TIMESTAMP not null default CURRENT_TIMESTAMP

 );
 */
//source > generate getter and setter

public class UserVo {

	private String id; //아이디 모든 클래스에서 여기에 접근가능. 
	private String pwd;					//보안취약점 개선하려고 private
	private String name;
	private Date regtime;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
 

	public Date getRegtime() {
		return regtime;
	}
	public void setRegtime(Date regtime) {
		this.regtime = regtime;
	}
	@Override
	public String toString() {
		return "UserVO [userId=" + id + ", userPass=" + pwd + ", userName=" + name + ", regDate="
				+ regtime + "]";
	}
	
	
}
