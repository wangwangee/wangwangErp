package com.example.Dao;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.example.Vo.ManagementVo;
@Repository

public interface ManagementDao {
	//입고
	public void importGoods(ManagementVo mvo);
	//출고
	public void exportGoods(ManagementVo mvo);
//	//import삭제시 management변경
//	public void importRemove(HashMap<String, String> hashmap);
	//출고 전에, 입고량 확인하기
	public String improtCheckBeforeExport (String name);
	//출고전 확인
	public int improtCheckBeforeExportAmount(String name);
 
}
