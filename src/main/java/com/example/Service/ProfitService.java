package com.example.Service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Dao.ProfitDao;
import com.example.Vo.GoodsVo;
import com.example.Vo.ProfitVo;

@Service("profitService")
public class ProfitService implements ProfitDao {

	@Autowired
	private ProfitDao profitDao; // dao에 객체 주입, Service는 dao없이는 아무것도 못함

	public void setProfitDao(ProfitDao profitDao) {
		this.profitDao = profitDao;
	}
	//입고
	@Override
	public boolean importGoods(ProfitVo pvo) {
		return profitDao.importGoods(pvo);
	}
	//출고
	@Override
	public boolean exportGoods(ProfitVo pvo) { 
		return profitDao.exportGoods(pvo);
	}
	@Override
	public void importRemove(HashMap<String, String> hashmap) {
		profitDao.importRemove(hashmap);
	}

}
