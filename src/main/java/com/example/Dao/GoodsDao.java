package com.example.Dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.Vo.CalendarVo;
import com.example.Vo.ExportVo;
import com.example.Vo.GoodsVo;
import com.example.Vo.ImportVo;
@Repository
public interface GoodsDao {
	//<9.30>입고
	public boolean importGoods(GoodsVo vo);
	//<9.30>출고
	public boolean  exportGoods(GoodsVo vo);

	//<10.07>Import 리스트조회 , 달력에 보여주기
	public List<ImportVo> calImportList(HashMap<String,String> map);	
	//<10.08>Export 리스트조회 , 달력에 보여주기
	public List<ExportVo> calExportList(HashMap<String,String> map);	
	
	//<10.08>일정갯수 조회하기: select문, 파라미터 : id, yyyyMMdd ->Ajax , hover로 갯수 보여주기
	public int  ImportcalCount(HashMap<String,String> hashmap);	
	//<10.08>일정갯수 조회하기: select문, 파라미터 : id, yyyyMMdd ->Ajax , hover로 갯수 보여주기
	public int  ExportcalCount(HashMap<String,String> hashmap);	
 
	//<10.08>일정 목록조회하기 : select문, 결과 :List , 파라미터 : id,yyyyMMdd (게시판같은 거)
	public List<ImportVo> calImportBoardList(HashMap<String,String> map);
	//<10.08>일정 목록조회하기 : select문, 결과 :List , 파라미터 : id,yyyyMMdd (게시판같은 거)
	public List<ExportVo> calExportBoardList(HashMap<String,String> map);
	//<10.19>결제 후 처리 :Ajax
	public boolean goodsBuying(HashMap<String,String> hashmap);
	
	//<11.03>import 일정 자세히 보기
	public GoodsVo calDetail(int seq);
	//<11.03>import 수정 페이지 구현 - POST
	public boolean calUpdate(GoodsVo vo);
	//<11.04>import수정시, import_price,amount가져와서 다른지 비교
	public GoodsVo compareProfitAmount(int seq);
	//<11.04>export 일정 자세히 보기
	public GoodsVo calDetail_export(int seq);
	//<11.04>export 수정 페이지 구현 - POST
	public boolean calUpdate_export(GoodsVo vo);
	//<11.05>export수정시,export_price,amount가져와서 다른지 비교
	public GoodsVo compareProfitAmount_export(int seq);
//	//<11.06>삭제 이전, export_mdate정보를 조회하여 update할지 delete를 할지 결정
//	public String exportMdateFind(int seq);
//	//<11.06>import삭제구현 null로 없데이트
//	public void importRemove(int seq);
//	//<11.06>import삭제구현 delete로 컬럼자체를 삭제
//	public void importRemoveColumn(int seq);
	//<11.07>반품
	public void returnGoods(GoodsVo vo);
	//<11.11>export수정시,출고될 수 있는 수량보다 더 많게 되지 않도록 하기
	public int previousAmountCount(int seq);
}
