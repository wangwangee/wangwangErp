package com.example.Dao;

import java.util.List;

import org.springframework.stereotype.Repository;
 
import com.example.Vo.MapVo;
 

//거래처등록 및 거래처에 관련 일정 보여주는 Dao
@Repository
public interface MapDao {
	//거래처 등록
	public void accountRecord(MapVo vo);
	//거래처 보여주기
	public List<MapVo>accountView(String yyyyMMdd);  
	//거래처 디테일보기
	public MapVo nameUpdateDetail(int seq);
	//거래처 수정하기
	public void accountUpdate(MapVo vo);
	//거래처 삭제하기
	public void accountRemove(int seq);
	//거래처 등록 전, 조회
	public String beforeAccountRecord(String import_store);
}
