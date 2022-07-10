package com.tjoeun.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tjoeun.vo.WgEndPerformVO;
import com.tjoeun.vo.WgHopePerformVO;
import com.tjoeun.vo.WgImageVO;
import com.tjoeun.vo.WgPerformVO;
import com.tjoeun.vo.WgUserVO;
import com.tjoeun.vo.WgWillPerformVO;

@Mapper
public interface WgMapper {
	
	/*로그인 관련*/
	int addUser(WgUserVO user);
	WgUserVO getUserById(String uid);

	String login(WgUserVO user);
	
	int updateUser(WgUserVO user);
	int deleteUser(String uid);
	
	/*전체 공연 관련*/
	List<Map<String, Object>> performanceList();
	List<Map<String, Object>> performDetail(int num);
	
	List<Map<String, Object>> searchPerform(String keyword);
	int getTotal(String keyword);

	int addPerform(WgPerformVO perform);
	int addImage(Map<String, Object> map);
	
	int updatePerform(WgPerformVO perform);
	int updateImage(Map<String, Object> map);
	
	String getFilename(int num);
	int deletePerfrom(int num);
	int deleteImage(int num);
	
	/*회원별 공연관련 - 관람한 공연*/
	List<WgEndPerformVO> getEndPerform();
	
	int addEndPerform(WgEndPerformVO endperform);
	List<Map<String, Object>> endperformByUid(String uid);
	List<Map<String, Object>> endperformDetail(String uid, int num);
	
	int updateEndPerform(WgEndPerformVO endperform);
	int deleteEndPerform(int num);
	
	
	int countPerformByUid(String uid);
	int countLocByUid(String uid);
	
	List<Map<String, Object>> countGroupByUid(String uid, int year);
	int countGroupByUid1(String uid, int year);
	int countGroupByUid2(String uid, int year);
	int countGroupByUid3(String uid, int year);
	int countGroupByUid4(String uid, int year);
	int countGroupByUid5(String uid, int year);
	int countGroupByUid6(String uid, int year);
	int countGroupByUid7(String uid, int year);
	int countGroupByUid8(String uid, int year);
	int countGroupByUid9(String uid, int year);
	int countGroupByUid10(String uid, int year);
	int countGroupByUid11(String uid, int year);
	int countGroupByUid12(String uid, int year);
	
	/*회원별 공연관련 - 관람예정 공연*/
	int addWillPerform(WgWillPerformVO willperform);
	
	List<Map<String, Object>> willperformByUid(String uid);
	List<Map<String, Object>> willperformDetail(String uid, int num);
	
	int updateWillPerform(WgWillPerformVO willperform);
	int deleteWillPerform(int num);
	
	/*회원별 공연관련 - 관람하고싶은 공연*/
	int addHopePerform(WgHopePerformVO hopeperform);
	
	List<Map<String, Object>> hopeperformByUid(String uid);
	List<Map<String, Object>> hopeperformDetail(String uid, int num);
	
	int updateHopePerform(WgHopePerformVO hopeperform);	
	int deleteHopePerform(int num);
	
}
