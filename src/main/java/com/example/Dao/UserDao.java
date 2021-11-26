package com.example.Dao;

import org.springframework.stereotype.Repository;
import com.example.Vo.UserVo;


@Repository
public interface UserDao {
	
     public void join(UserVo vo); //회원가입
     
     public UserVo login(UserVo vo);//로그인
     
     public void update(UserVo vo);//회원정보 수정
     
 	 public UserVo getUser(String id); //회원정보 가져오기
 	 
 	 public void logout(UserVo vo); //회원 로그아웃하기
 	 
 	 public void withdraw(UserVo vo); //회원 탈퇴하기
 	 
 	 
  }
