package com.example.Dao;
 
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.example.Vo.AnnualSalesVo;
import com.example.Vo.GoodsVo;
 
 
@Repository
public interface ChartDao {
	
	 
	//졸작테스팅 DAO
	public List<AnnualSalesVo> annualSaleChart(HashMap hashmap);
	public List<GoodsVo> bestItems (HashMap hashmap);
	
}