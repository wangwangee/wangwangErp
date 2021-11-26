package com.example.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Dao.GoodsDao;
import com.example.Vo.ExportVo;
import com.example.Vo.GoodsVo;
import com.example.Vo.ImportVo;
 
@Service("goodsService")
public class GoodsService implements GoodsDao{
	@Autowired
	private GoodsDao goodsDao; // dao에 객체 주입, Service는 dao없이는 아무것도 못함

	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}
	//입고
	@Override
	public boolean importGoods(GoodsVo vo) {
		return goodsDao.importGoods(vo);
	}
	//출고
	@Override
	public boolean exportGoods(GoodsVo vo) {
		return goodsDao.exportGoods(vo);
	}
	 //<10.07>import 리스트조회 
	@Override
	public List<ImportVo> calImportList(HashMap<String, String> map) {
		return goodsDao.calImportList(map);
	}
	//<10.08>export 리스트조회 
	@Override
	public List<ExportVo> calExportList(HashMap<String, String> map) {
		return goodsDao.calExportList(map);
	}
	//<10.08>일정갯수 조회하기: select문, 파라미터 : id, yyyyMMdd
	@Override
	public int ImportcalCount(HashMap<String, String> hashmap) {
		return goodsDao.ImportcalCount(hashmap);
	}
	//<10.08>일정갯수 조회하기: select문, 파라미터 : id, yyyyMMdd
	@Override
	public int ExportcalCount(HashMap<String, String> hashmap) {
		return goodsDao.ExportcalCount(hashmap);
	}  
	
	//<10.08>일정 목록조회하기 : select문, 결과 :List , 파라미터 : id,yyyyMMdd (게시판같은 거)
	public List<ImportVo> calImportBoardList(HashMap<String,String> map){
		return goodsDao.calImportBoardList(map);
	}
	//<10.08>일정 목록조회하기 : select문, 결과 :List , 파라미터 : id,yyyyMMdd (게시판같은 거)
	public List<ExportVo> calExportBoardList(HashMap<String,String> map){
		return goodsDao.calExportBoardList(map);
	}
	//결제 후 처리 : Ajax
	@Override
	public boolean goodsBuying(HashMap<String, String> hashmap) {
		return goodsDao.goodsBuying(hashmap);
	}
	//<11.03>import 일정 자세히 보기
	@Override
	public GoodsVo calDetail(int seq) {
		return goodsDao.calDetail(seq);
	}
	//<11.03>import 수정 페이지 구현 - POST
	@Override
	public boolean calUpdate(GoodsVo vo) {
		return goodsDao.calUpdate(vo);
	}
	//<11.04>import수정시, import_price,amount가져와서 다른지 비교
	public GoodsVo compareProfitAmount(int seq) {
		return goodsDao.compareProfitAmount(seq);
	}
	@Override
	public GoodsVo calDetail_export(int seq) {
		return goodsDao.calDetail_export(seq);
	}
	//<11.04>export 수정 페이지 구현 - POST
	@Override
	public boolean calUpdate_export(GoodsVo vo) {
		return goodsDao.calUpdate_export(vo);
	}
	//<11.05>export수정시,export_price,amount가져와서 다른지 비교
	@Override
	public GoodsVo compareProfitAmount_export(int seq) {
		// TODO Auto-generated method stub
		return goodsDao.compareProfitAmount_export(seq);
	}
//	//<11.06>삭제 이전, export_mdate정보를 조회하여 update할지 delete를 할지 결정
//	public String exportMdateFind(int seq) {
//		return goodsDao.exportMdateFind(seq);
//	}
//	
//	//<11.06>import삭제구현
//	@Override
//	public void importRemove(int seq) {
//		goodsDao. importRemove(seq);
//		
//	}
//	//<11.06>import삭제구현 delete로 컬럼자체를 삭제
//	public void importRemoveColumn(int seq) {
//		goodsDao.importRemoveColumn(seq);
//	}
	//<11.07>반품
	public void returnGoods(GoodsVo vo) {
		goodsDao.returnGoods(vo);
	}
	@Override
	public int previousAmountCount(int seq) {
		
		return goodsDao.previousAmountCount(seq);
	}

}
