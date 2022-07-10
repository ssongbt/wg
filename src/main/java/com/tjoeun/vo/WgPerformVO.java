package com.tjoeun.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class WgPerformVO {
	
	private int num;
	private String name;
	private java.sql.Date startdate;
	private java.sql.Date enddate;
	private String loc;
	private String  genre;
	private String run;
	private String cast;
	private String synop;
	public List<WgImageVO> image = new ArrayList<>();
	private String keyword;
	public List<WgLocationVO> location = new ArrayList<>();
	
	public WgPerformVO() {}
	
	public WgPerformVO(int num) {
		this.setNum(num);
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public java.sql.Date getStartdate() {
		return startdate;
	}
	public void setStartdate(java.sql.Date startdate) {
		this.startdate = startdate;
	}
	public java.sql.Date getEnddate() {
		return enddate;
	}
	public void setEnddate(java.sql.Date enddate) {
		this.enddate = enddate;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRun() {
		return run;
	}
	public void setRun(String run) {
		this.run = run;
	}
	public String getCast() {
		return cast;
	}
	public void setCast(String cast) {
		this.cast = cast;
	}
	public String getSynop() {
		return synop;
	}
	public void setSynop(String synop) {
		this.synop = synop;
	}
	public List<WgImageVO> getImage() {
		return image;
	}
	public void setImage(List<WgImageVO> image) {
		this.image = image;
	}
	
	@Override
	public String toString() {
		return num + " " + name + " " + startdate + " " + enddate + " " + loc + " " + genre + " " + run + " " + cast + " " + synop;
	}

	@Override
	public boolean equals(Object obj) {
		WgPerformVO perform = (WgPerformVO) obj;
		return this.num==perform.num;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public List<WgLocationVO> getLocation() {
		return location;
	}

	public void setLocation(List<WgLocationVO> location) {
		this.location = location;
	}
	
	
	
	
}
