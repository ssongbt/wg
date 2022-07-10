package com.tjoeun.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Component;

@Component
public class WgUserVO {
	
	private String uid;
	private String pwd;
	private String nick;
	public List<WgEndPerformVO> end = new ArrayList<>();
	
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
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(this.uid);
	}
	
	@Override
	public boolean equals(Object obj) {
		WgUserVO vo = (WgUserVO) obj;
		return this.uid.equals(vo.getUid());
	}
	
	@Override
	public String toString() {
		return String.format("%s %s %s", uid, pwd, nick);
	}

	public List<WgEndPerformVO> getEnd() {
		return end;
	}

	public void setEnd(List<WgEndPerformVO> end) {
		this.end = end;
	}
	
	
	
}
