package com.example.Dao;
import java.util.HashMap;

import org.springframework.stereotype.Repository;
 
import com.example.Vo.ProfitVo;
 
@Repository
public interface ProfitDao {

	//입고
	public boolean importGoods(ProfitVo pvo);
	//출고
	public boolean exportGoods(ProfitVo pvo);
	//import삭제시 profit변경
	public void importRemove(HashMap<String, String> hashmap);
}
