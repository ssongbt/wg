package com.tjoeun.vo;

import java.util.ArrayList;
import java.util.List;

public class WgHopePerformVO {
	
	private int hp_num;
	private String hp_uid;
	private int hp_pernum;
	private int hp_rating;
	private String hp_review;
	public List<WgPerformVO> perform = new ArrayList<>();
	public List<WgImageVO> image = new ArrayList<>();
	
	public int getHp_num() {
		return hp_num;
	}
	public void setHp_num(int hp_num) {
		this.hp_num = hp_num;
	}
	public String getHp_uid() {
		return hp_uid;
	}
	public void setHp_uid(String hp_uid) {
		this.hp_uid = hp_uid;
	}
	public int getHp_pernum() {
		return hp_pernum;
	}
	public void setHp_pernum(int hp_pernum) {
		this.hp_pernum = hp_pernum;
	}
	public int getHp_rating() {
		return hp_rating;
	}
	public void setHp_rating(int hp_rating) {
		this.hp_rating = hp_rating;
	}
	public String getHp_review() {
		return hp_review;
	}
	public void setHp_review(String hp_review) {
		this.hp_review = hp_review;
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
