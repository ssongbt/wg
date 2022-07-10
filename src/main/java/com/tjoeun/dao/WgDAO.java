package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.mapper.WgMapper;
import com.tjoeun.vo.WgEndPerformVO;
import com.tjoeun.vo.WgHopePerformVO;
import com.tjoeun.vo.WgImageVO;
import com.tjoeun.vo.WgPerformVO;
import com.tjoeun.vo.WgUserVO;
import com.tjoeun.vo.WgWillPerformVO;

@Repository
public class WgDAO {
	
	@Autowired
	private WgMapper wgMapper;

	public boolean addUser(WgUserVO user) {
		return wgMapper.addUser(user)>0;
	}

	public boolean idcheck(String uid) {
		return (wgMapper.getUserById(uid)==null);
	}

	public boolean login(WgUserVO user) {
		System.out.println("다오uid" + user.getUid());
		System.out.println("다오pwd" + user.getPwd());
		return wgMapper.login(user)!=null;
	}

	public List<Map<String, Object>> performList() {
		return wgMapper.performanceList();
	}

	public List<Map<String, Object>> performDetail(int num) {
		return wgMapper.performDetail(num);
	}

	public boolean addPerform(WgPerformVO perform) {
		return wgMapper.addPerform(perform)>0;
	}
	
	public boolean addImage(Map<String, Object> map) {
		return wgMapper.addImage(map)>0;
	}

	public boolean addEndPerform(WgEndPerformVO endperform) {
		return wgMapper.addEndPerform(endperform)>0;
	}


	public boolean updatePerform(WgPerformVO perform) {
		return wgMapper.updatePerform(perform)>0;
	}
	
	public boolean updateImage(Map<String, Object> map) {
		return wgMapper.updateImage(map)>0;
	}

	public String getFilename(int num) {
		return wgMapper.getFilename(num);
	}

	public boolean deletePerform(int num) {
		return wgMapper.deletePerfrom(num)>0;
	}

	public boolean deleteImage(int num) {
		return wgMapper.deleteImage(num)>0;	
	}

	public boolean addwillPerform(WgWillPerformVO willperform) {
		return wgMapper.addWillPerform(willperform)>0;
	}

	public boolean addhopePerform(WgHopePerformVO hopeperform) {
		return wgMapper.addHopePerform(hopeperform)>0;
	}

	public List<Map<String, Object>> endperformByUid(String uid) {
		return wgMapper.endperformByUid(uid);
	}

	public List<Map<String, Object>> willperformByUid(String uid) {
		return wgMapper.willperformByUid(uid);
	}

	public List<Map<String, Object>> hopeperformByUid(String uid) {
		return wgMapper.hopeperformByUid(uid);
	}

	public List<Map<String, Object>> endperformDetail(String uid, int num) {
		return wgMapper.endperformDetail(uid, num);
	}

	public boolean deleteEndPerform(int num) {
		return wgMapper.deleteEndPerform(num)>0;
	}

	public List<Map<String, Object>> searchPerform(String keyword) {
		return wgMapper.searchPerform(keyword);
	}

	public boolean updateEndPerform(WgEndPerformVO endperform) {
		return wgMapper.updateEndPerform(endperform)>0;
	}

	public boolean deleteWillPerform(int wp_num) {
		return wgMapper.deleteWillPerform(wp_num)>0;
	}

	public List<Map<String, Object>> willperformDetail(String uid, int num) {
		return wgMapper.willperformDetail(uid, num);
	}

	public boolean updateWillPerform(WgWillPerformVO willperform) {
		return wgMapper.updateWillPerform(willperform)>0;
	}

	public List<Map<String, Object>> hopeperformDetail(String uid, int num) {
		return wgMapper.hopeperformDetail(uid, num);
	}

	public boolean deleteHopePerform(int num) {
		return wgMapper.deleteHopePerform(num)>0;
	}

	public boolean updateHopePerform(WgHopePerformVO hopeperform) {
		return wgMapper.updateHopePerform(hopeperform)>0;
	}

	public int getTotal(String keyword) {
		return wgMapper.getTotal(keyword);
	}

	public WgUserVO getUserById(String uid) {
		return wgMapper.getUserById(uid);
	}

	public boolean updateUser(WgUserVO user) {
		return wgMapper.updateUser(user)>0;
	}

	public boolean deleteUser(String uid) {
		return wgMapper.deleteUser(uid)>0;
	}

	public List<Map<String, Object>> gettotalList(String uid) {
		List<Map<String, Object>> total = new ArrayList<>();
		total.addAll(wgMapper.endperformByUid(uid));
		total.addAll(wgMapper.willperformByUid(uid));
		total.addAll(wgMapper.hopeperformByUid(uid));
		return total;
	}

	public int countPerformByUid(String uid) {
		return wgMapper.countPerformByUid(uid);
	}

	public int countLocByUid(String uid) {
		return wgMapper.countLocByUid(uid);
	}
	
	public List<Map<String, Object>> countGroupByUid(String uid, int year){
		return wgMapper.countGroupByUid(uid, year);
	}

	public int countGroupByUid1(String uid, int year) {
		System.out.println("다오"+year);
		return wgMapper.countGroupByUid1(uid, year);
	}
	
	public int countGroupByUid2(String uid, int year) {
		return wgMapper.countGroupByUid2(uid, year);
	}
	
	public int countGroupByUid3(String uid, int year) {
		return wgMapper.countGroupByUid3(uid, year);
	}
	
	public int countGroupByUid4(String uid, int year) {
		return wgMapper.countGroupByUid4(uid, year);
	}
	
	public int countGroupByUid5(String uid, int year) {
		return wgMapper.countGroupByUid5(uid, year);
	}
	
	public int countGroupByUid6(String uid, int year) {
		return wgMapper.countGroupByUid6(uid, year);
	}
	
	public int countGroupByUid7(String uid, int year) {
		return wgMapper.countGroupByUid7(uid, year);
	}
	
	public int countGroupByUid8(String uid, int year) {
		return wgMapper.countGroupByUid8(uid, year);
	}
	
	public int countGroupByUid9(String uid, int year) {
		return wgMapper.countGroupByUid9(uid, year);
	}
	
	public int countGroupByUid10(String uid, int year) {
		return wgMapper.countGroupByUid10(uid, year);
	}
	
	public int countGroupByUid11(String uid, int year) {
		return wgMapper.countGroupByUid11(uid, year);
	}
	
	public int countGroupByUid12(String uid, int year) {
		return wgMapper.countGroupByUid12(uid, year);
	}
	
}
