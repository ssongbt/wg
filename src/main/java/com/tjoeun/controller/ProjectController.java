package com.tjoeun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.tjoeun.svc.WgSVC;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.User;
import com.tjoeun.vo.WgChartVO;
import com.tjoeun.vo.WgEndPerformVO;
import com.tjoeun.vo.WgHopePerformVO;
import com.tjoeun.vo.WgPerformVO;
import com.tjoeun.vo.WgUserVO;
import com.tjoeun.vo.WgWillPerformVO;

@Controller
@RequestMapping("/wg")
@SessionAttributes("uid")
public class ProjectController {
	
	@Autowired
	private WgSVC svc;
	
	@Autowired
	ResourceLoader resourceLoader;	
	
	@GetMapping("/login")
	public String form() {
		return "pj/loginForm";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> login(WgUserVO user, Model model) {
		Map<String, Object> map = new HashMap<>();
		boolean ok = svc.login(user);
		if(ok) {
			model.addAttribute("uid", user.getUid());
		}
		map.put("ok", ok);
		return map;
	}
	
	@GetMapping("/join")
	public String joinform() {
		return "pj/joinForm";
	}
	
	@PostMapping("/join")
	@ResponseBody
	public Map<String, Boolean> join(WgUserVO user) {
		boolean useradded = svc.addUser(user);
		Map<String, Boolean> map = new HashMap<>();
		map.put("useradded", useradded);
		return map;
	}
	
	@PostMapping("/idcheck")
	@ResponseBody	
	public Map<String, Boolean> check(@RequestParam String uid) {
		Map<String, Boolean> map = new HashMap<>();
		boolean checked = svc.idcheck(uid);
		map.put("checked", checked);
		return map;
	}
	
	@GetMapping("/home")
	public String home(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(name="year",required=false, defaultValue="2022") int year, Model model) {
		if(uid==null) {
			return "redirect:/wg/login";			// 로그인 폼으로...
		}else {
			List<WgEndPerformVO> endperform = svc.endperformByUid(uid);
			model.addAttribute("endperform", endperform);
			List<WgChartVO> chart = svc.countGroupByUid(uid, year);
			model.addAttribute("chart", chart);
			System.out.println("get연도"+year);
			int count1 = svc.countGroupByUid1(uid, year);
			System.out.println("get컨트롤러"+count1);
			model.addAttribute("count1", count1);
			int count2 = svc.countGroupByUid2(uid, year);
			model.addAttribute("count2", count2);
			int count3 = svc.countGroupByUid3(uid, year);
			model.addAttribute("count3", count3);
			int count4 = svc.countGroupByUid4(uid, year);
			model.addAttribute("count4", count4);
			int count5 = svc.countGroupByUid5(uid, year);
			model.addAttribute("count5", count5);
			int count6 = svc.countGroupByUid6(uid, year);
			model.addAttribute("count6", count6);
			int count7 = svc.countGroupByUid7(uid, year);
			model.addAttribute("count7", count7);
			int count8 = svc.countGroupByUid8(uid, year);
			model.addAttribute("count8", count8);
			int count9 = svc.countGroupByUid9(uid, year);
			model.addAttribute("count9", count9);
			int count10 = svc.countGroupByUid10(uid, year);
			model.addAttribute("count10", count10);
			int count11 = svc.countGroupByUid11(uid, year);
			model.addAttribute("count11", count11);
			int count12 = svc.countGroupByUid12(uid, year);
			model.addAttribute("count12", count12);
			
			model.addAttribute("year", year);
			
			//System.out.println("차트가안나와"+chart);
			int countPer = svc.countPerformByUid(uid);
			int countLoc = svc.countLocByUid(uid);
			model.addAttribute("countPer",countPer);
			model.addAttribute("countLoc",countLoc);
			model.addAttribute("endperform", endperform);
			WgUserVO user = svc.getUserById(uid);
			model.addAttribute("user", user);
			System.out.println("get연도::"+year);
			return "pj/home";
		}
	}
	
	@PostMapping("/home")
	@ResponseBody
	public Map<String, Object> chart(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(name="year", required=false, defaultValue="2020") int year, Model model){
		Map<String, Object> map = new HashMap<>();
		
		System.out.println("post컨트롤러"+year);
		int count1 = svc.countGroupByUid1(uid, year);
		System.out.println("post컨트롤러"+count1);
		//model.addAttribute("count1", count1);
		int count2 = svc.countGroupByUid2(uid, year);
		//model.addAttribute("count2", count2);
		int count3 = svc.countGroupByUid3(uid, year);
		//model.addAttribute("count3", count3);
		int count4 = svc.countGroupByUid4(uid, year);
		//model.addAttribute("count4", count4);
		int count5 = svc.countGroupByUid5(uid, year);
		//model.addAttribute("count5", count5);
		int count6 = svc.countGroupByUid6(uid, year);
		//model.addAttribute("count6", count6);
		int count7 = svc.countGroupByUid7(uid, year);
		//model.addAttribute("count7", count7);
		int count8 = svc.countGroupByUid8(uid, year);
		//model.addAttribute("count8", count8);
		int count9 = svc.countGroupByUid9(uid, year);
		//model.addAttribute("count9", count9);
		int count10 = svc.countGroupByUid10(uid, year);
		//model.addAttribute("count10", count10);
		int count11 = svc.countGroupByUid11(uid, year);
		//model.addAttribute("count11", count11);
		int count12 = svc.countGroupByUid12(uid, year);
		//model.addAttribute("count12", count12);
		
		map.put("year", year);
		map.put("count1", count1);
		map.put("count2", count2);
		map.put("count3", count3);
		map.put("count4", count4);
		map.put("count5", count5);
		map.put("count6", count6);
		map.put("count7", count7);
		map.put("count8", count8);
		map.put("count9", count9);
		map.put("count10", count10);
		map.put("count11", count11);
		map.put("count12", count12);
		System.out.println("post컨트롤러::"+year);
		return map;
	}
	
	
	@GetMapping("/myinfo")
	public String myinfo(@SessionAttribute(name="uid", required=false) String uid, Model model) {
		if(uid==null) {
			return "redirect:/wg/login";			// 로그인 폼으로...
		}else {
		WgUserVO user = svc.getUserById(uid);
		model.addAttribute("user", user);
		return "pj/myInfo";
		}
	}
	
	@PostMapping("/myinfo/update")
	@ResponseBody
	public Map<String, Boolean> updateUser(@SessionAttribute(name="uid", required=false) String uid, WgUserVO user){
		boolean updateduser = svc.updateUser(user);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updateduser", updateduser);
		return map;
	}
	
	@PostMapping("/myinfo/delete")
	@ResponseBody
	public Map<String, Boolean> delteUser(@SessionAttribute(name="uid", required=false) String uid){
		boolean deleteduser = svc.deleteUser(uid);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteduser", deleteduser);
		return map;
	}
	
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/wg/login";				// redirect = response.sendRedirect("/user/login");
	}

//	@GetMapping("/list")
//	public String performList(Model model) {
//		model.addAttribute("list", svc.performList());
//		return "pj/list";
//	}
	
	@GetMapping("/page")
	//@ResponseBody
	public String getPage(@RequestParam int pageNum, Model model) {
	      PageInfo<Map<String, Object>> pageInfo = svc.getListPage(pageNum);
	      pageInfo.getNavigatepageNums(); // pageInfo.navigatepageNums
	      model.addAttribute("pageInfo",pageInfo);
	      return "pj/listPage";
	}
	
	@GetMapping("/list")
	//@ResponseBody
	public String getPageSearch(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model, @RequestParam(defaultValue="") String keyword) {
	      PageInfo<Map<String, Object>> pageInfo = svc.getListPageSearch(pageNum, keyword);
	      pageInfo.getNavigatepageNums(); // pageInfo.navigatepageNums
//	      System.out.println("토탈"+pageInfo.getTotal());
//	      System.out.println("사이즈"+ pageInfo.getSize());
//	      System.out.println("현재페이지"+pageInfo.getPageNum());
//	      System.out.println("첫페이지" + pageInfo.getNavigateFirstPage());   
//	      System.out.println("마지막페이지"+ pageInfo.getNavigateLastPage());
//	      System.out.println("네비게이션페이지"+ pageInfo.getNavigatePages());
//	      System.out.println("페이지수"+pageInfo.getPages());
//	      System.out.println("startrow"+pageInfo.getStartRow());
	      model.addAttribute("pageInfo",pageInfo);
	      model.addAttribute("list",pageInfo.getList());
	      model.addAttribute("keyword",keyword);
	      model.addAttribute("uid",uid);
	      return "pj/listPageSearch2";
	}
	
	
	@GetMapping("/addPerform")
	public String addPerformForm() {
		return "pj/addForm";
	}
	
	@PostMapping("/addPerform")
	@ResponseBody
	public Map<String, Boolean> addPerform(@RequestParam(value="files", required=false) MultipartFile mfiles,
			HttpServletRequest request,
			WgPerformVO perform){
		Map<String, Boolean> map = new HashMap<>();
		boolean addedPerform = svc.addPerform(request, perform, mfiles);
		map.put("addedPerform", addedPerform);
		return map; 
	}
	
	
	@GetMapping("/detail")
	public String detail(@RequestParam int num, Model model) {
		WgPerformVO perform = svc.performDetail(num);
		model.addAttribute("perform",perform);
		return "pj/detailPerform";
	}
	
	@GetMapping("/updatePerform")
	public String updatePerformForm(@RequestParam int num, Model model) {
		WgPerformVO perform = svc.performDetail(num);
		model.addAttribute("perform",perform);
		return "pj/updatePerform";
	}
	
	@PostMapping("/updatePerform")
	@ResponseBody
	public Map<String, Boolean> updatePerform(@RequestParam(value="files", required=false) MultipartFile mfiles,
			HttpServletRequest request, WgPerformVO perform){
		System.out.println("콘트롤러");
//		if(mfiles==null) {
//			Map<String, Boolean> map = new HashMap<>();
//			boolean updatedPerform = svc.updatePerform(perform);
//			map.put("updatedPerform", updatedPerform);
//			return map;
//		}
		boolean updatedPerform = svc.updatePerform(request, perform, mfiles);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updatedPerform", updatedPerform);
		return map;
	}
	
	@PostMapping("/file/delete")
	@ResponseBody
	public Map<String, Boolean> delete_file(@RequestParam int num){
		boolean deleted = svc.delete_file(num, resourceLoader);	//파일의 절대경로를 받을 때 필요
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
	@PostMapping("/deletePerform")
	@ResponseBody
	public Map<String, Boolean> deletePerform(@RequestParam int num){
		boolean deletedPerform =svc.deletePerform(num, resourceLoader);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletedPerform", deletedPerform);
		return map;
	}
	
	@GetMapping("/addEndPerform")
	public String endPerformform(@SessionAttribute(name="uid", required=false) String uid, int per_num, Model model) {
		WgPerformVO perform = svc.performDetail(per_num);
		model.addAttribute("perform", perform);
		return "pj/endPerform";
	}
	
	@PostMapping("/addEndPerform")
	@ResponseBody
	public Map<String, Boolean> addendPerform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int per_num, WgEndPerformVO endperform){
		boolean addendPerform = svc.addEndPerform(uid, per_num, endperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addendPerform", addendPerform);
		return map;
	}
	
	@GetMapping("/mylist")
	public String getmylistPage(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model) {
		System.out.println("list uid :" + uid);
		if(uid==null) {
			return "redirect:/wg/login";			// 로그인 폼으로...
		}else {
	      //PageInfo<Map<String, Object>> pageInfo = svc.gettotalListPage(pageNum, uid);
	      PageInfo<Map<String, Object>> pageendInfo = svc.getendListPage(pageNum, uid);
	      PageInfo<Map<String, Object>> pagewillInfo = svc.getwillListPage(pageNum, uid);
	      PageInfo<Map<String, Object>> pagehopeInfo = svc.gethopeListPage(pageNum, uid);
	      pageendInfo.getNavigatepageNums(); // pageInfo.navigatepageNums
	      pagewillInfo.getNavigatepageNums();
	      pagehopeInfo.getNavigatepageNums();
	      model.addAttribute("pageendInfo",pageendInfo);
	      model.addAttribute("pagewillInfo",pagewillInfo);
	      model.addAttribute("pagehopeInfo",pagehopeInfo);
	      return "pj/mylist2";
		}
	}
	
	@GetMapping("/myendlist")
	public String myendlistPage(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model) {
		System.out.println("list uid :" + uid);
		if(uid==null) {
			return "redirect:/wg/login";			
		}else {
		    PageInfo<Map<String, Object>> pageInfo = svc.getendListPage(pageNum, uid);
		    pageInfo.getNavigatepageNums(); 
		    model.addAttribute("pageInfo",pageInfo);
			return "pj/myendlist";						
		}
	}
	
	
//	@GetMapping("/mywilllist")
//	public String mywilllist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model) {
//		System.out.println("list uid :" + uid);
//		if(uid==null) {
//			return "redirect:/wg/login";			
//		}else {
//		    PageInfo<Map<String, Object>> pageInfo = svc.getwillListPage(pageNum, uid);
//		    pageInfo.getNavigatepageNums();
//		    model.addAttribute("pageInfo",pageInfo);
//			return "pj/mywilllist";						
//		}
//	}
	
	@GetMapping("/mywilllist")
	public String mywilllist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model) {
		System.out.println("list uid :" + uid);
		if(uid==null) {
			return "redirect:/wg/login";			
		}else {
//			Map<WgWillPerformVO, Integer> Ddays = svc.Ddays(uid);
			PageInfo<Map<String, Object>> pageInfo = svc.getwillListPage(pageNum, uid);
		    pageInfo.getNavigatepageNums();
		    model.addAttribute("pageInfo",pageInfo);
//		    model.addAttribute("Ddays",Ddays);
			return "pj/mywilllist";						
		}
	}
	
	
	@GetMapping("/myhopelist")
	public String myhopelist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam(required=false, defaultValue="1") int pageNum, Model model) {
		System.out.println("list uid :" + uid);
		if(uid==null) {
			return "redirect:/wg/login";			
		}else {
		    PageInfo<Map<String, Object>> pageInfo = svc.gethopeListPage(pageNum, uid);
		    pageInfo.getNavigatepageNums(); 
		    model.addAttribute("pageInfo",pageInfo);
			return "pj/myhopelist";						
		}
	}
	
	
	@GetMapping("/addmylist")
	public String addmylist(@SessionAttribute(name="uid", required=false) String uid, int per_num, Model model) {
		if(uid==null) {
			return "redirect:/wg/login";			
		}else {
		WgPerformVO perform = svc.performDetail(per_num);
		model.addAttribute("perform",perform);
		return "pj/addmylist";
		}
	}

	@PostMapping("/addmyendlist")
	@ResponseBody
	public Map<String, Boolean> addmyendlist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int ep_pernum, WgEndPerformVO endperform){
		boolean addendPerform = svc.addEndPerform(uid, ep_pernum, endperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addendPerform", addendPerform);
		return map;
	}
	
	@PostMapping("/addmywilllist")
	@ResponseBody
	public Map<String, Boolean> addmywilllist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int wp_pernum, WgWillPerformVO willperform){
		boolean addwillPerform = svc.addwillPerform(uid, wp_pernum, willperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addwillPerform", addwillPerform);
		return map;
	}
	
	@PostMapping("/addmyhopelist")
	@ResponseBody
	public Map<String, Boolean> addmyhopelist(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int hp_pernum, WgHopePerformVO hopeperform){
		boolean addhopePerform = svc.addhopePerform(uid, hp_pernum, hopeperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addhopePerform", addhopePerform);
		return map;
	}
	
	@GetMapping("/mylist/end")
	public String endperformdetail(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int num, Model model) {
		WgEndPerformVO endperform = svc.endperformDetail(uid, num);
		model.addAttribute("endperform", endperform);
		return "pj/detail_end";
	}
	
	@PostMapping("/mylist/end/delete")
	@ResponseBody
	public Map<String, Boolean> deletdendperform(@SessionAttribute(name="uid", required=false) String uid, int num){
		boolean deleteendperform = svc.deleteEndPerform(num);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteendperform", deleteendperform);
		return map;
	}
	
	@GetMapping("/mylist/end/update")
	public String endperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int ep_num, Model model) {
		WgEndPerformVO endperform = svc.endperformDetail(uid, ep_num);
		model.addAttribute("endperform", endperform);
		return "pj/update_endmydetail";
	}
	
	@PostMapping("/mylist/end/update")
	@ResponseBody
	public Map<String, Boolean> updateendperform(@SessionAttribute(name="uid", required=false) String uid, WgEndPerformVO endperform, Model model) {
		boolean updateendperform = svc.updateEndPerform(endperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updateendperform", updateendperform);
		return map;
	}
	
	@PostMapping("/mylist/end/update2")
	@ResponseBody
	public Map<String, Boolean> deleteendaddwillperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int ep_num, @RequestParam int wp_pernum, WgWillPerformVO willperform){
		boolean deleteendaddwillperform = svc.deleteendaddwillperform(ep_num, uid, wp_pernum, willperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteendaddwillperform",deleteendaddwillperform);
		return map;
	}
	
	@PostMapping("/mylist/end/update3")
	@ResponseBody
	public Map<String, Boolean> deleteendaddhopeperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int ep_num, @RequestParam int hp_pernum, WgHopePerformVO hopeperform){
		boolean deleteendaddhopeperform = svc.deleteendaddhopeperform(ep_num, uid, hp_pernum, hopeperform);
		System.out.println("deleteendaddhopeperform" +deleteendaddhopeperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteendaddhopeperform",deleteendaddhopeperform);
		return map;
	}
	
	
	@GetMapping("/mylist/will")
	public String willperformdetail(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int num, Model model) {
		WgWillPerformVO willperform = svc.willperformDetail(uid, num);
		System.out.println(willperform);
		model.addAttribute("willperform", willperform);
		return "pj/detail_will";
	}
	
	@PostMapping("/mylist/will/delete")
	@ResponseBody
	public Map<String, Boolean> deletdwillperform(@SessionAttribute(name="uid", required=false) String uid, int num){
		boolean deletewillperform = svc.deleteWillPerform(num);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletewillperform", deletewillperform);
		return map;
	}
	
	@GetMapping("/mylist/will/update")
	public String willperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int wp_num, Model model) {
		WgWillPerformVO willperform = svc.willperformDetail(uid, wp_num);
		model.addAttribute("willperform", willperform);
		return "pj/update_willmydetail";
	}
	
	@PostMapping("/mylist/will/update")
	@ResponseBody
	public Map<String, Boolean> updatewillperform(@SessionAttribute(name="uid", required=false) String uid, WgWillPerformVO willperform, Model model) {
		boolean updatewillperform = svc.updateWillPerform(willperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updatewillperform", updatewillperform);
		return map;
	}
	
	@PostMapping("/mylist/will/update2")
	@ResponseBody
	public Map<String, Boolean> deletewilladdendperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int wp_num, @RequestParam int ep_pernum, WgEndPerformVO endperform) {
		boolean deletewilladdendperform = svc.deletewilladdendperform(wp_num, uid, ep_pernum, endperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletewilladdendperform", deletewilladdendperform);
		return map;
	}
	
	@PostMapping("/mylist/will/update3")
	@ResponseBody
	public Map<String, Boolean> deletewilladdhopeperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int wp_num, @RequestParam int hp_pernum, WgHopePerformVO hopeperform) {
		boolean deletewilladdhopeperform = svc.deletewilladdhopeperform(wp_num, uid, hp_pernum, hopeperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletewilladdhopeperform", deletewilladdhopeperform);
		return map;
	}
	
	@GetMapping("/mylist/hope")
	public String hopeperformdetail(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int num, Model model) {
		WgHopePerformVO hopeperform = svc.hopeperformDetail(uid, num);
		model.addAttribute("hopeperform", hopeperform);
		return "pj/detail_hope";
	}
	
	@PostMapping("/mylist/hope/delete")
	@ResponseBody
	public Map<String, Boolean> deletdhopeperform(@SessionAttribute(name="uid", required=false) String uid, int num){
		boolean deletehopeperform = svc.deleteHopePerform(num);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletehopeperform", deletehopeperform);
		return map;
	}
	
	@GetMapping("/mylist/hope/update")
	public String hopeperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int hp_num, Model model) {
		WgHopePerformVO hopeperform = svc.hopeperformDetail(uid, hp_num);
		model.addAttribute("hopeperform", hopeperform);
		return "pj/update_hopemydetail";
	}
	
	@PostMapping("/mylist/hope/update")
	@ResponseBody
	public Map<String, Boolean> updatehopeperform(@SessionAttribute(name="uid", required=false) String uid, WgHopePerformVO hopeperform, Model model) {
		boolean updatehopeperform = svc.updateHopePerform(hopeperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updatehopeperform", updatehopeperform);
		return map;
	}
	
	@PostMapping("/mylist/hope/update2")
	@ResponseBody
	public Map<String, Boolean> deletehopeaddendperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int hp_num, @RequestParam int ep_pernum, WgEndPerformVO endperform) {
		boolean deletehopeaddendperform = svc.deletehopeaddendperform(hp_num, uid, ep_pernum, endperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletehopeaddendperform", deletehopeaddendperform);
		return map;
	}
	
	@PostMapping("/mylist/hope/update3")
	@ResponseBody
	public Map<String, Boolean> deletehopeaddwillperform(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int hp_num, @RequestParam int wp_pernum, WgWillPerformVO willperform) {
		boolean deletehopeaddwillperform = svc.deletehopeaddwillperform(hp_num, uid, wp_pernum, willperform);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deletehopeaddwillperform", deletehopeaddwillperform);
		return map;
	}
	
	
	
}
