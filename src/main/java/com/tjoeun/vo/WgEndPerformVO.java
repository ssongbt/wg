package com.tjoeun.vo;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class WgEndPerformVO {
	
	private int ep_num;
	private String ep_uid;
	private int ep_pernum;
	private String ep_seat;
	private java.sql.Date ep_date;
	private String ep_time;
	private int ep_rating;
	private String ep_cast;
	private String ep_review;
	public List<WgPerformVO> perform = new ArrayList<>();
	public List<WgImageVO> image = new ArrayList<>();
	
	public int getEp_num() {
		return ep_num;
	}
	public void setEp_num(int ep_num) {
		this.ep_num = ep_num;
	}
	public String getEp_uid() {
		return ep_uid;
	}
	public void setEp_uid(String ep_uid) {
		this.ep_uid = ep_uid;
	}
	public int getEp_pernum() {
		return ep_pernum;
	}
	public void setEp_pernum(int ep_pernum) {
		this.ep_pernum = ep_pernum;
	}
	public String getEp_seat() {
		return ep_seat;
	}
	public void setEp_seat(String ep_seat) {
		this.ep_seat = ep_seat;
	}
	public java.sql.Date getEp_date() {
		return ep_date;
	}
	public void setEp_date(java.sql.Date ep_date) {
		this.ep_date = ep_date;
	}
	public String getEp_time() {
		return  ep_time;
	}
	public void setEp_time(String ep_time) {
		this.ep_time = ep_time;
	}
	public int getEp_rating() {
		return ep_rating;
	}
	public void setEp_rating(int ep_rating) {
		this.ep_rating = ep_rating;
	}
	public String getEp_cast() {
		return ep_cast;
	}
	public void setEp_cast(String ep_cast) {
		this.ep_cast = ep_cast;
	}
	public String getEp_review() {
		return ep_review;
	}
	public void setEp_review(String ep_review) {
		this.ep_review = ep_review;
	}
	public List<WgImageVO> getImage() {
		return image;
	}
	public void setImage(List<WgImageVO> image) {
		this.image = image;
	}
	public List<WgPerformVO> getPerform() {
		return perform;
	}
	public void setPerform(List<WgPerformVO> perform) {
		this.perform = perform;
	}
	
	
	
}
