package com.example.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Dao.ChartDao;
 
import com.example.Vo.AnnualSalesVo;
import com.example.Vo.GoodsVo;
 
@Service("chartService")
public class ChartService implements ChartDao {

	@Autowired
	private ChartDao  chartDao;

	public void setChartDao(ChartDao chartDao) {
		this.chartDao = chartDao;
	}

	//연매출
	@Override
	public List<AnnualSalesVo> annualSaleChart(HashMap hashmap){
		return chartDao.annualSaleChart(hashmap);
	}

	//베스트아이템
	@Override
	public List<GoodsVo> bestItems(HashMap hashmap) {
		return chartDao.bestItems(hashmap);
	}

}


 
