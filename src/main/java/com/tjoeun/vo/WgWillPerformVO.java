package com.tjoeun.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class WgWillPerformVO {
	
	private int wp_num;
	private String wp_uid;
	private int wp_pernum;
	private java.sql.Date wp_date;
	private String wp_time;
	private String wp_seat;
	public List<WgPerformVO> perform = new ArrayList<>();
	public List<WgImageVO> image = new ArrayList<>();
	
	public int getWp_num() {
		return wp_num;
	}
	public void setWp_num(int wp_num) {
		this.wp_num = wp_num;
	}
	public String getWp_uid() {
		return wp_uid;
	}
	public void setWp_uid(String wp_uid) {
		this.wp_uid = wp_uid;
	}
	public int getWp_pernum() {
		return wp_pernum;
	}
	public void setWp_pernum(int wp_pernum) {
		this.wp_pernum = wp_pernum;
	}
	public java.sql.Date getWp_date() {
		return wp_date;
	}
	public void setWp_date(java.sql.Date wp_date) {
		this.wp_date = wp_date;
	}
	public String getWp_time() {
		return wp_time;
	}
	public void setWp_time(String wp_time) {
		this.wp_time = wp_time;
	}
	public String getWp_seat() {
		return wp_seat;
	}
	public void setWp_seat(String wp_seat) {
		this.wp_seat = wp_seat;
	}
	public List<WgPerformVO> getPerform() {
		return perform;
	}
	public void setPerform(List<WgPerformVO> perform) {
		this.perform = perform;
	}
	public List<WgImageVO> getImage() {
		return image;
	}
	public void setImage(List<WgImageVO> image) {
		this.image = image;
	}

	
	
}
