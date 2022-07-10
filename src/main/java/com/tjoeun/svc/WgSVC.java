package com.tjoeun.svc;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tjoeun.dao.WgDAO;
import com.tjoeun.vo.AttachVO;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.User;
import com.tjoeun.vo.WgChartVO;
import com.tjoeun.vo.WgEndPerformVO;
import com.tjoeun.vo.WgHopePerformVO;
import com.tjoeun.vo.WgImageVO;
import com.tjoeun.vo.WgLocationVO;
import com.tjoeun.vo.WgPerformVO;
import com.tjoeun.vo.WgUserVO;
import com.tjoeun.vo.WgWillPerformVO;

@Service
public class WgSVC {
	
	@Autowired
	private WgDAO dao;
	
	@Autowired
	ResourceLoader resourceLoader;	

	public boolean addUser(WgUserVO user) {
		return dao.addUser(user);
	}

	public boolean idcheck(String uid) {
		return dao.idcheck(uid);
	}

	public boolean login(WgUserVO user) {
		System.out.println("서비스 user :" + user.getUid());
		return dao.login(user);
	}

	public List<WgPerformVO> performList() {
		//Map에 저장된 게시글 한 행의 정보를 BoardVO 객체로 표현한다
		List<Map<String,Object>> list = dao.performList();
		List<WgPerformVO> list2 = new ArrayList<>();
				
			//int prev_num =  0;
			for(int i=0;i<list.size();i++) {
				int bnum = (int)list.get(i).get("num");
				Map<String, Object> m = list.get(i);
				WgPerformVO perform = new WgPerformVO();
				perform.setNum(bnum);
				perform.setName((String)m.get("name"));
				perform.setGenre((String)m.get("genre"));
				perform.setCast((String)m.get("cast"));
				perform.setStartdate((java.sql.Date)m.get("startdate"));
				perform.setEnddate((java.sql.Date)m.get("enddate"));
				perform.setLoc((String)m.get("loc"));
				perform.setRun((String)m.get("run"));
				
				if(m.get("imagepath")!=null) { // 첨부파일을 가진 글이라면...
					WgImageVO image = new WgImageVO();
					image.setImg_num((int)list.get(i).get("img_num"));
					image.setImagepath((String)list.get(i).get("imagepath"));
					perform.image.add(image);
				}
				list2.add(perform);
			}
			return list2;
	}
	
	public PageInfo<Map<String, Object>> getListPage(int pageNum) {
	      PageHelper.startPage(pageNum, 5);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(dao.performList());
	      System.out.println(pageInfo);
	      return pageInfo;
	}
	
	public PageInfo<Map<String, Object>> getListPageSearch(int pageNum, String keyword) {
	      PageHelper.startPage(pageNum, 10);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(dao.searchPerform(keyword));
	      return pageInfo;
	}
	
	public int getTotal(String keyword) {
		return dao.getTotal(keyword);
	}

	public WgPerformVO performDetail(int num) {
		List<Map<String, Object>> list = dao.performDetail(num);
		WgPerformVO perform = new WgPerformVO();
		int size = list.size();
		for(int i=0;i<size;i++) {
			Map<String, Object> map = list.get(i);
			if(i==0) { // 루프 초기에 한번만 글 정보를 추출
				perform.setNum((int)map.get("num"));
				perform.setName((String)map.get("name"));
				perform.setGenre((String)map.get("genre"));
				perform.setLoc((String)map.get("loc"));
				perform.setRun((String)map.get("run"));
				perform.setStartdate((java.sql.Date)map.get("startdate"));
				perform.setEnddate((java.sql.Date)map.get("enddate"));
				perform.setCast((String)map.get("cast"));
				perform.setSynop((String)map.get("synop"));
			}
			Object obj = map.get("imagepath");
			if(obj!=null) {
				WgImageVO image = new WgImageVO();
				image.setImagepath((String)map.get("imagepath"));
				image.setImg_num((int)map.get("img_num"));
				perform.image.add(image);
			}
			Object obj2 = map.get("location");
			WgLocationVO location = new WgLocationVO();
			location.setLocation((String)map.get("location"));
			location.setLatitude((String)map.get("latitude"));
			location.setLongitude((String)map.get("longitude"));
			location.setGu_location((String)map.get("gu_location"));
			perform.location.add(location);
		}
		return perform;
	}
	
	public boolean addPerform(WgPerformVO perform) {
		return dao.addPerform(perform);
	}
	
	@Transactional(rollbackFor={Exception.class})
	public boolean addPerform(HttpServletRequest request, WgPerformVO perform, MultipartFile mfiles) {
		boolean saved = addPerform(perform);				// 게시 글 저장 
		if(mfiles!=null) {
			
		int perform_num = perform.getNum();					// 글 저장 시 자동증가 필드
		if(!saved) {
			System.out.println("글 저장 실패");
			return false;			
		}
		
		Resource resource = (Resource)resourceLoader.getResource("/images");
		//Resource resource = resourceLoader.getResource("classpath:/static/images");
	      String absolutePath = null;
		//ServletContext context = request.getServletContext();	
		try {
			absolutePath = resource.getFile().getAbsolutePath();
			System.out.println("절대경로=" + absolutePath);
			File test = new File(absolutePath);
			System.out.println("파일:" + test.exists());
			
				String  filename = mfiles.getOriginalFilename();
				mfiles.transferTo(new File(absolutePath+"/"+filename)); // 서버측 디스크에 저장
				Map<String, Object> map = new HashMap<>();
				map.put("perform_num", perform_num);
				map.put("imagepath", filename);
				boolean fSaved = dao.addImage(map); 
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
		return true;
	}
	
	

	public boolean addEndPerform(String uid, int per_num, WgEndPerformVO endperform) {
		endperform.setEp_uid(uid);
		System.out.println("uid" + uid);
		endperform.setEp_pernum((Integer) per_num);
		System.out.println("per_num" + per_num);
		return dao.addEndPerform(endperform);
	}


	@Transactional(rollbackFor={Exception.class})
	public boolean updatePerform(HttpServletRequest request, WgPerformVO perform, MultipartFile mfiles) {
		dao.updatePerform(perform);
		System.out.println("mfiles :" + mfiles);
		if(mfiles!=null){ 
			int perform_num = perform.getNum();
			int img_num = 0;
			System.out.println(perform.getName());
			List<WgPerformVO> list = performList();
			//System.out.println(list);
			for(int i=0;i<list.size();i++) {
				if(list.get(i).getNum()==perform_num) {
					System.out.println("num값 " +perform_num);
					List<WgImageVO> image = list.get(i).getImage();
					for(int j=0; j<image.size();j++) {
						img_num = image.get(j).getImg_num();
					}
			String savedfile= getFilename(img_num);
			System.out.println("파일이름은?"+getFilename(img_num));
			
			System.out.println("저장된 파일 있는지" + savedfile);
			
			if(savedfile != null) {
				String filename = getFilename(img_num);
				System.out.println("파일이름" + filename);
				Resource resource = (Resource)resourceLoader.getResource("/images/"+filename);
				System.out.println("resource" + resource);
				boolean deleted = false;
				try {
					String abPath = resource.getFile().getAbsolutePath();
					File fileDel = new File(abPath);
					deleted = fileDel.exists() ? fileDel.delete() : false;
					System.out.println("삭제여부" + deleted);
				} catch (IOException e) {
					e.printStackTrace();
				}
				if(deleted) {
					System.out.println("이미지번호:"+img_num);
					dao.deleteImage(img_num);
					
					resource = (Resource)resourceLoader.getResource("/images");
					//Resource resource = resourceLoader.getResource("classpath:/static/images");
				      String absolutePath = null;
					//ServletContext context = request.getServletContext();	
					try {
						absolutePath = resource.getFile().getAbsolutePath();
						System.out.println("절대경로=" + absolutePath);
						File test = new File(absolutePath);
						System.out.println("파일:" + test.exists());
						
						//for(int k=0;k<mfiles.length;k++) {
						String  imagepath = mfiles.getOriginalFilename();
						mfiles.transferTo(new File(absolutePath+"/"+filename)); 
					Map<String, Object> nmap = new HashMap<>();
					nmap.put("perform_num", perform_num);
					nmap.put("imagepath", imagepath);
					System.out.println("이미지패스" + mfiles.getOriginalFilename());
					System.out.println("공연번호" + perform_num);
					dao.addImage(nmap);
					dao.updatePerform(perform);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			}
			
			if(savedfile==null) {
				System.out.println("공연넘버" + perform_num);
				Resource resource = (Resource)resourceLoader.getResource("/images");
				//Resource resource = resourceLoader.getResource("classpath:/static/images");
			      String absolutePath = null;
				//ServletContext context = request.getServletContext();	
				try {
					absolutePath = resource.getFile().getAbsolutePath();
					System.out.println("절대경로=" + absolutePath);
					File test = new File(absolutePath);
					System.out.println("파일:" + test.exists());
					
					//for(int k=0;k<mfiles.length;k++) {
					String  filename = mfiles.getOriginalFilename();
					mfiles.transferTo(new File(absolutePath+"/"+filename)); // 서버측 디스크에 저장
					Map<String, Object> nmap = new HashMap<>();
					nmap.put("perform_num", perform_num);
					nmap.put("imagepath", filename);
					dao.addImage(nmap); 
					dao.updatePerform(perform);
					return true;
				//}
				} catch (Exception e) {
					e.printStackTrace();
				}
				}
				}
			}
		}return true;
	}
		

	public boolean updateImage(Map<String, Object> map) {
		return dao.updateImage(map);
	}
	
	public boolean addImage(Map<String, Object> map) {
		return dao.addImage(map);
	}
	
	public boolean delete_file(int num, ResourceLoader resourceLoader) {
		dao.deleteImage(num);
		String filename = getFilename(num);
		System.out.println("파일이름" + filename);
		Resource resource = (Resource)resourceLoader.getResource("/images/"+filename);
		System.out.println("resource" + resource);
		boolean deleted = false;
		try {
			String abPath = resource.getFile().getAbsolutePath();
			File fileDel = new File(abPath);
			deleted = fileDel.exists() ? fileDel.delete() : false;
		} catch (IOException e) {
			e.printStackTrace();
		}return true;
	}

	private String getFilename(int num) {
		return dao.getFilename(num);
	}
	
	@Transactional(rollbackFor={Exception.class})
	public boolean deletePerform(int num, ResourceLoader resourceLoader) {
		int img_num=0;
		List<WgPerformVO> perform = performList();
		for(int i=0;i<perform.size();i++) {
			if(perform.get(i).getNum()==num) {
				System.out.println("num값 " +num);
				List<WgImageVO> image = perform.get(i).getImage();
				for(int j=0; j<image.size();j++) {
					img_num=image.get(j).getImg_num();
				}
				System.out.println("img_num"+img_num);
				
				String filename = getFilename(img_num);
				System.out.println("파일이름" + filename);
				Resource resource = (Resource)resourceLoader.getResource("/images/"+filename);
				System.out.println("resource" + resource);
				boolean deleted = false;
				try {
					String abPath = resource.getFile().getAbsolutePath();
					File fileDel = new File(abPath);
					deleted = fileDel.exists() ? fileDel.delete() : false;
				} catch (IOException e) {
					e.printStackTrace();
				} if(deleted) {
					dao.deleteImage(img_num);
					dao.deletePerform(num);
					return true;
				}
			} 
		} return dao.deletePerform(num);
	}

	public boolean updatePerform(WgPerformVO perform) {
		return dao.updatePerform(perform);
	}

	public boolean addwillPerform(String uid, int wp_pernum, WgWillPerformVO willperform) {
		willperform.setWp_uid(uid);
		willperform.setWp_pernum(wp_pernum);
		return dao.addwillPerform(willperform);
	}

	public boolean addhopePerform(String uid, int hp_pernum, WgHopePerformVO hopeperform) {
		hopeperform.setHp_uid(uid);
		hopeperform.setHp_pernum(hp_pernum);
		return dao.addhopePerform(hopeperform);
	}

	public List<WgEndPerformVO> endperformByUid(String uid) {
		List<Map<String, Object>> list = dao.endperformByUid(uid);
		List<WgEndPerformVO> list2 = new ArrayList<>();
			for(int i=0;i<list.size();i++) {
				int bnum = (int)list.get(i).get("ep_num");
				Map<String, Object> m = list.get(i);
				WgEndPerformVO endperform = new WgEndPerformVO();
				endperform.setEp_num((int)m.get("ep_num"));
				endperform.setEp_uid((String)m.get("ep_uid"));
				endperform.setEp_cast((String)m.get("ep_cast"));
				endperform.setEp_date((java.sql.Date)m.get("ep_date"));
				endperform.setEp_rating((int)m.get("ep_rating"));
				endperform.setEp_review((String)m.get("ep_review"));
				endperform.setEp_seat((String)m.get("ep_seat"));
				endperform.setEp_time((String)m.get("ep_time"));
				
				if(m.get("ep_pernum")!=null) {
					
					WgPerformVO perform = new WgPerformVO();
					perform.setNum((int)m.get("ep_pernum"));
					perform.setName((String)m.get("name"));
					endperform.perform.add(perform);
					
					if(perform.getImage()!=null) {
						
						WgImageVO image = new WgImageVO();
						image.setImg_num((int)list.get(i).get("img_num"));
						image.setImagepath((String)list.get(i).get("imagepath"));
						perform.image.add(image);
						}
				}
		
				list2.add(endperform);
			}
		return list2;
	}
	
	public List<WgWillPerformVO> willperformByUid(String uid) {
		List<Map<String, Object>> list = dao.willperformByUid(uid);
		List<WgWillPerformVO> list2 = new ArrayList<>();
			for(int i=0;i<list.size();i++) {
				int bnum = (int)list.get(i).get("wp_num");
				Map<String, Object> m = list.get(i);
				WgWillPerformVO willperform = new WgWillPerformVO();
				willperform.setWp_num((int)m.get("wp_num"));
				willperform.setWp_uid((String)m.get("wp_uid"));
				willperform.setWp_date((java.sql.Date)m.get("wp_date"));
				willperform.setWp_time((String)m.get("wp_time"));
				willperform.setWp_seat((String)m.get("wp_seat"));
			
				if(m.get("wp_pernum")!=null) {
					
					WgPerformVO perform = new WgPerformVO();
					perform.setNum((int)m.get("wp_pernum"));
					perform.setName((String)m.get("name"));
					perform.setGenre((String)m.get("genre"));
					willperform.perform.add(perform);
					
					if(perform.getImage()!=null) {
						
						WgImageVO image = new WgImageVO();
						image.setImg_num((int)list.get(i).get("img_num"));
						image.setImagepath((String)list.get(i).get("imagepath"));
						perform.image.add(image);
						}
				}
		
				list2.add(willperform);
			}
		return list2;
	}

	public List<WgHopePerformVO> hopeperformByUid(String uid) {
		List<Map<String, Object>> list = dao.hopeperformByUid(uid);
		List<WgHopePerformVO> list2 = new ArrayList<>();
			for(int i=0;i<list.size();i++) {
				int bnum = (int)list.get(i).get("hp_num");
				Map<String, Object> m = list.get(i);
				WgHopePerformVO hopeperform = new WgHopePerformVO();
				hopeperform.setHp_num((int)m.get("hp_num"));
				hopeperform.setHp_uid((String)m.get("hp_uid"));
				hopeperform.setHp_rating((int)m.get("hp_rating"));
				hopeperform.setHp_review((String)m.get("hp_review"));
	
			
				if(m.get("hp_pernum")!=null) {
					
					WgPerformVO perform = new WgPerformVO();
					perform.setNum((int)m.get("hp_pernum"));
					perform.setName((String)m.get("name"));
					perform.setGenre((String)m.get("genre"));
					hopeperform.perform.add(perform);
					
					if(perform.getImage()!=null) {
						
						WgImageVO image = new WgImageVO();
						image.setImg_num((int)list.get(i).get("img_num"));
						image.setImagepath((String)list.get(i).get("imagepath"));
						System.out.println("이미지패스"+(String)list.get(i).get("imagepath"));
						perform.image.add(image);
						}
				}
				list2.add(hopeperform);
			}
		return list2;
	}

	public WgEndPerformVO endperformDetail(String uid, int num) {
		List<Map<String, Object>> list = dao.endperformDetail(uid, num);
		WgEndPerformVO endperform = new WgEndPerformVO();
		int size = list.size();
		for(int i=0;i<size;i++) {
			Map<String, Object> map = list.get(i);
			if(i==0) { // 루프 초기에 한번만 글 정보를 추출
				endperform.setEp_uid((String)map.get("ep_uid"));
				endperform.setEp_num((int)map.get("ep_num"));
				endperform.setEp_date((java.sql.Date)map.get("ep_date"));
				endperform.setEp_cast((String)map.get("ep_cast"));
				endperform.setEp_time((String)map.get("ep_time"));
				endperform.setEp_rating((int)map.get("ep_rating"));
				endperform.setEp_seat((String)map.get("ep_seat"));
				endperform.setEp_review((String)map.get("ep_review"));
				endperform.setEp_pernum((int)map.get("ep_pernum"));
			}
			Object obj = map.get("ep_pernum");
			if(obj!=null) {
				WgPerformVO perform = new WgPerformVO();
				perform.setName((String)map.get("name"));
				perform.setNum((int)map.get("ep_pernum"));
				perform.setGenre((String)map.get("genre"));
				perform.setLoc((String)map.get("loc"));;
				endperform.perform.add(perform);
				
				Object obj2 = map.get("imagepath");
				if(obj2 !=null) {
					WgImageVO image = new WgImageVO();
					image.setImagepath((String)map.get("imagepath"));
					image.setImg_num((int)map.get("img_num"));
					perform.image.add(image);
				}
			}
		}
		return endperform;
	}

	public boolean deleteEndPerform(int num) {
		return dao.deleteEndPerform(num);
	}

	public boolean updateEndPerform(WgEndPerformVO endperform) {
		return dao.updateEndPerform(endperform);
	}

	public boolean deleteendaddwillperform(int ep_num, String uid, int wp_pernum, WgWillPerformVO willperform) {
		dao.deleteEndPerform(ep_num);
		willperform.setWp_uid(uid);
		willperform.setWp_pernum(wp_pernum);
		dao.addwillPerform(willperform);
		return true;
	}

	public boolean deleteendaddhopeperform(int ep_num, String uid, int hp_pernum, WgHopePerformVO hopeperform) {
		dao.deleteEndPerform(ep_num);
		hopeperform.setHp_uid(uid);
		hopeperform.setHp_pernum(hp_pernum);
		dao.addhopePerform(hopeperform);
		return true;
	}

	public WgWillPerformVO willperformDetail(String uid, int num) {
		List<Map<String, Object>> list = dao.willperformDetail(uid, num);
		WgWillPerformVO willperform = new WgWillPerformVO();
		int size = list.size();
		for(int i=0;i<size;i++) {
			Map<String, Object> map = list.get(i);
			if(i==0) { // 루프 초기에 한번만 글 정보를 추출
				willperform.setWp_uid((String)map.get("wp_uid"));
				willperform.setWp_num((int)map.get("wp_num"));
				willperform.setWp_date((java.sql.Date)map.get("wp_date"));
				willperform.setWp_seat((String)map.get("wp_seat"));
				willperform.setWp_time((String)map.get("wp_time"));
				willperform.setWp_pernum((int)map.get("wp_pernum"));
				
			}
			Object obj = map.get("wp_pernum");
			if(obj!=null) {
				WgPerformVO perform = new WgPerformVO();
				perform.setName((String)map.get("name"));
				perform.setNum((int)map.get("wp_pernum"));
				perform.setGenre((String)map.get("genre"));
				perform.setLoc((String)map.get("loc"));
				willperform.perform.add(perform);
				
				Object obj2 = map.get("imagepath");
				if(obj2 !=null) {
					WgImageVO image = new WgImageVO();
					image.setImagepath((String)map.get("imagepath"));
					image.setImg_num((int)map.get("img_num"));
					perform.image.add(image);
				}
			}
		}
		return willperform;
	}

	public boolean deleteWillPerform(int num) {
		return dao.deleteWillPerform(num);
	}

	public boolean updateWillPerform(WgWillPerformVO willperform) {
		return dao.updateWillPerform(willperform);
	}

	public boolean deletewilladdendperform(int wp_num, String uid, int ep_pernum, WgEndPerformVO endperform) {
		dao.deleteWillPerform(wp_num);
		endperform.setEp_uid(uid);
		endperform.setEp_pernum(ep_pernum);
		dao.addEndPerform(endperform);
		return true;
	}

	public boolean deletewilladdhopeperform(int wp_num, String uid, int hp_pernum, WgHopePerformVO hopeperform) {
		dao.deleteWillPerform(wp_num);
		hopeperform.setHp_uid(uid);
		hopeperform.setHp_pernum(hp_pernum);
		dao.addhopePerform(hopeperform);
		return true;
	}

	public WgHopePerformVO hopeperformDetail(String uid, int num) {
		List<Map<String, Object>> list = dao.hopeperformDetail(uid, num);
		WgHopePerformVO hopeperform = new WgHopePerformVO();
		int size = list.size();
		for(int i=0;i<size;i++) {
			Map<String, Object> map = list.get(i);
			if(i==0) { // 루프 초기에 한번만 글 정보를 추출
				hopeperform.setHp_uid((String)map.get("hp_uid"));
				hopeperform.setHp_num((int)map.get("hp_num"));
				hopeperform.setHp_rating((int)map.get("hp_rating"));
				hopeperform.setHp_review((String)map.get("hp_review"));
				hopeperform.setHp_pernum((int)map.get("hp_pernum"));
			}
			Object obj = map.get("hp_pernum");
			if(obj!=null) {
				WgPerformVO perform = new WgPerformVO();
				perform.setName((String)map.get("name"));
				perform.setNum((int)map.get("hp_pernum"));
				perform.setGenre((String)map.get("genre"));
				perform.setLoc((String)map.get("loc"));
				hopeperform.perform.add(perform);
				
				Object obj2 = map.get("imagepath");
				if(obj2 !=null) {
					WgImageVO image = new WgImageVO();
					image.setImagepath((String)map.get("imagepath"));
					image.setImg_num((int)map.get("img_num"));
					perform.image.add(image);
				}
			}
		}
		return hopeperform;
	}

	public boolean deleteHopePerform(int num) {
		return dao.deleteHopePerform(num);
	}

	public boolean updateHopePerform(WgHopePerformVO hopeperform) {
		return dao.updateHopePerform(hopeperform);
	}

	public boolean deletehopeaddendperform(int hp_num, String uid, int ep_pernum, WgEndPerformVO endperform) {
		dao.deleteHopePerform(hp_num);
		endperform.setEp_uid(uid);
		endperform.setEp_pernum(ep_pernum);
		dao.addEndPerform(endperform);
		return true;
	}

	public boolean deletehopeaddwillperform(int hp_num, String uid, int wp_pernum, WgWillPerformVO willperform) {
		dao.deleteHopePerform(hp_num);
		willperform.setWp_uid(uid);
		willperform.setWp_pernum(wp_pernum);
		dao.addwillPerform(willperform);
		return true;
	}

	public WgUserVO getUserById(String uid) {
		return dao.getUserById(uid);
	}

	public boolean updateUser(WgUserVO user) {
		return dao.updateUser(user);
	}

	public boolean deleteUser(String uid) {
		return dao.deleteUser(uid);
	}
	
	public PageInfo<Map<String, Object>> gettotalListPage(int pageNum, String uid) {
		List<Map<String, Object>> total = new ArrayList<>();
		total.addAll(dao.endperformByUid(uid));
		total.addAll(dao.willperformByUid(uid));
		total.addAll(dao.hopeperformByUid(uid));
		
	      PageHelper.startPage(pageNum, 2);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(total);
		return pageInfo;
	}

	public PageInfo<Map<String, Object>> getendListPage(int pageNum, String uid) {
	      PageHelper.startPage(pageNum, 5);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(dao.endperformByUid(uid));
		return pageInfo;
	}

	public PageInfo<Map<String, Object>> getwillListPage(int pageNum, String uid) {
	      PageHelper.startPage(pageNum, 5);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(dao.willperformByUid(uid));
		return pageInfo;
	}

	public PageInfo<Map<String, Object>> gethopeListPage(int pageNum, String uid) {
	      PageHelper.startPage(pageNum, 5);
	      PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(dao.hopeperformByUid(uid));
		return pageInfo;
	}

	public int countPerformByUid(String uid) {
		return dao.countPerformByUid(uid);
	}

	public int countLocByUid(String uid) {
		return dao.countLocByUid(uid);
	}
	
	public List<WgChartVO> countGroupByUid(String uid, int year){
		List<Map<String, Object>> list = dao.countGroupByUid(uid, year);
		List<WgChartVO> list2 = new ArrayList<>();
			for(int i=0;i<list.size();i++) {
				//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
				Map<String, Object> m = list.get(i);
				WgChartVO chart = new WgChartVO();
				//String Year =((String)m.get("ym")).split("-")[0];
				//String month =((String)m.get("ym")).split("-")[1];
				chart.setYear(Integer.parseInt(String.valueOf(m.get("date")).split("-")[0]));
				chart.setMonth(Integer.parseInt(String.valueOf(m.get("date")).split("-")[1]));
				chart.setCount(Integer.parseInt(String.valueOf(m.get("cnt"))));
				//System.out.println("년도 :" + chart.getYear());
				//System.out.println("달 :" + chart.getMonth());
				//System.out.println("횟수:" + chart.getCount());
				list2.add(chart);
			}
				
		return list2;
	}
	
	public int countGroupByUid1(String uid, int year) {
		System.out.println("서비스연도"+ year);
		return dao.countGroupByUid1(uid, year);
	}
	
	public int countGroupByUid2(String uid, int year) {
		return dao.countGroupByUid2(uid, year);
	}
	
	public int countGroupByUid3(String uid, int year) {
		return dao.countGroupByUid3(uid, year);
	}
	
	public int countGroupByUid4(String uid, int year) {
		return dao.countGroupByUid4(uid, year);
	}
	
	public int countGroupByUid5(String uid, int year) {
		return dao.countGroupByUid6(uid, year);
	}
	
	public int countGroupByUid6(String uid, int year) {
		return dao.countGroupByUid6(uid, year);
	}
	
	public int countGroupByUid7(String uid, int year) {
		return dao.countGroupByUid7(uid, year);
	}
	
	public int countGroupByUid8(String uid, int year) {
		return dao.countGroupByUid8(uid, year);
	}
	
	public int countGroupByUid9(String uid, int year) {
		return dao.countGroupByUid9(uid, year);
	}
	
	public int countGroupByUid10(String uid, int year) {
		return dao.countGroupByUid10(uid, year);
	}
	
	public int countGroupByUid11(String uid, int year) {
		return dao.countGroupByUid11(uid, year);
	}
	
	public int countGroupByUid12(String uid, int year) {
		return dao.countGroupByUid12(uid, year);
	}
	
	
//	public Map<WgWillPerformVO, Integer> Ddays(String uid) {
//		Map<WgWillPerformVO, Integer> dDayMap = new HashMap<WgWillPerformVO, Integer>();
//		List<Map<String, Object>> list = dao.willperformByUid(uid);
//		List<WgWillPerformVO> list2 = new ArrayList<>();
//			for(int i=0;i<list.size();i++) {
//				int bnum = (int)list.get(i).get("wp_num");
//				Map<String, Object> m = list.get(i);
//				WgWillPerformVO willperform = new WgWillPerformVO();
//
//				Object obj = m.get("wp_date");
//				System.out.println("obj : " + obj);
//				
//				String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
//				System.out.println("오늘날짜" + todayDate);
//				
//				String strDate = String.valueOf(obj);
//				
//				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//				
//				Date date;
//				try {
//					date = new Date(dateFormat.parse(strDate).getTime());
//					Date today = new Date(dateFormat.parse(todayDate).getTime());
//					long calculate = date.getTime() - today.getTime();
//					int Ddays = (int) (calculate / (24*60*60*1000));
//					
//					willperform.setWp_nowdate(Ddays);
//					System.out.println("차이일" +  Ddays);
//					
//					dDayMap.put(willperform, Ddays);
//					
//				} catch (ParseException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
//			return dDayMap;
//	}
			
		
		
		
//		
//		Map<WgWillPerformVO, Integer> dDayMap = new HashMap<WgWillPerformVO, Integer>();
//		List<Map<String, Object>> list = dao.willperformByUid(uid);
//		for(int i=0;i<list.size();i++) {
//			Map<String, Object> map = list.get(i);
//			map.put(, map)
//			for(int j=0; j<map.size();j++) {
//				map.get
//			}
//			WgWillPerformVO willperform = new WgWillPerformVO();
//			System.out.println("wilperform" + willperform);
//			java.sql.Date date = (Date) list.get(8).get(willperform.getWp_date());
//			System.out.println("날짜" + date);
//			String strDate = (String) list.get(i).get(willperform.getWp_date());
//			System.out.println("기준일" + strDate);
//			String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
//			
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//			 
//			try {
//				date = new Date(dateFormat.parse(strDate).getTime());
//				Date today = new Date(dateFormat.parse(todayDate).getTime());
//				long calculate = date.getTime() - today.getTime();
//				int Ddays = (int) (calculate / (24*60*60*1000));
//				willperform.setWp_nowdate(Ddays);
//				
//				dDayMap.put(willperform, Ddays);
//			} catch (ParseException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			  
//		}
//		return dDayMap;
//	}
	
	
	
	
}
