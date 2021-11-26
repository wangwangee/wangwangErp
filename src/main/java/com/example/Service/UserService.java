package com.example.Service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.Dao.UserDao;
import com.example.Vo.UserVo;


@Service("userService")
public class UserService implements UserDao{
	
	@Autowired
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		
		this.userDao= userDao;
	}

	
	@Override //회원가입
	 public void join(UserVo vo) {

		userDao.join(vo);
		
	 }
	
	@Override//로그인
	public UserVo login(UserVo vo) {
		
		return userDao.login(vo);
		
	}
	
	@Override//회원 정보 수정
	public void update(UserVo vo) {
		
		 userDao.update(vo);
		
	}
	
	@Override//회원정보가져오기 ->회원 정보 수정, 탈퇴에서 사용하기
	public UserVo getUser(String id) {
		
		return userDao.getUser(id);
		
	}
	@Override //회원 로그아웃하기
	public void logout(UserVo vo) {
	 
	  userDao.logout(vo);
 	}
	@Override //회원 탈퇴하기
	public void withdraw(UserVo vo) {
		
		userDao.withdraw(vo);
	}
}
