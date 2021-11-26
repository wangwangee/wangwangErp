package com.example.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Dao.MapDao;
import com.example.Vo.MapVo;

@Service("mapService")
public class MapService implements MapDao {
	@Autowired
	private MapDao mapDao;

	public void setMapDao(MapDao mapDao) {
	 this.mapDao= mapDao;
	}

	@Override
	public void accountRecord(MapVo vo) {
		mapDao.accountRecord(vo);
	}

	@Override
	public List<MapVo> accountView(String yyyyMMdd) { 
		return mapDao.accountView(yyyyMMdd);
	}

	@Override
	public void accountUpdate(MapVo vo) {
		mapDao.accountUpdate(vo);
	}

	@Override
	public MapVo nameUpdateDetail(int seq) {
		return mapDao.nameUpdateDetail(seq);
	}

	@Override
	public void accountRemove(int seq) { 
		mapDao.accountRemove(seq);
	}

	@Override
	public String beforeAccountRecord(String import_store) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
