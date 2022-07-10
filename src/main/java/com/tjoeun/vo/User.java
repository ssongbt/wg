package com.tjoeun.vo;

import java.util.Objects;

import org.springframework.stereotype.Component;

@Component					// mvc에서 쓰이는 컴퍼넌트 라는 선언하면 스프링에서 알아서 처리해줌
public class User {
	private String uid;			//변수 이름은 form 에 있는 필드 name과 같아야함
	private String pwd;
	private String name;
	private String phone;
	
	@Override
	public String toString() {
		return String.format("%s,%s,%s,%s", uid, pwd, name, phone);
	}

	public String getLine() {
		return String.format("%s|%s|%s|%s", uid, pwd, name, phone);
	}

	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public boolean equals(Object obj) {
		User u = (User) obj;
		return this.uid.equals(u.getUid());
	}

	@Override
	public int hashCode() {
		return Objects.hash(this.uid);
	}
	
	
	
	
	
}