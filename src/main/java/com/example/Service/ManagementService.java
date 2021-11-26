package com.example.Service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 
import com.example.Dao.ManagementDao;
import com.example.Vo.ManagementVo;

@Service("managementService")
public class ManagementService  implements ManagementDao {
	@Autowired
	private ManagementDao  managementDao;
	
	public void setManagementDao(ManagementDao managementDao) {
		this.managementDao = managementDao;
	}
	 
	//입고
	public void importGoods(ManagementVo mvo) {
		managementDao.importGoods(mvo);
	}
	//출고
	public void exportGoods(ManagementVo mvo) {
		managementDao.exportGoods(mvo);
	}
//	//import삭제시 management변경
//	public void importRemove(HashMap<String, String> hashmap) {
//		managementDao.importRemove(hashmap);
//	}
// 
	//출고 전에, 입고량 확인하기
	public String improtCheckBeforeExport(String name) {
		return managementDao.improtCheckBeforeExport (name);
	}
	public int improtCheckBeforeExportAmount(String name) {
		return managementDao.improtCheckBeforeExportAmount (name);
	}
}
