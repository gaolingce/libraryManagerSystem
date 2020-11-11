package com.system.model;

import javax.persistence.*;
import java.util.Date;

/**
 * @Description  
 * @Author  Henry
 * @Date 2020-11-05 
 */


@Table ( name ="book_record" )
public class BookRecord  {


	private Integer recordid;

	private String username;

	private String bookcode;

	private String lendtime;

	private String returntime;

	private String expiretime;


	public Integer getRecordid() {
		return recordid;
	}

	public void setRecordid(Integer recordid) {
		this.recordid = recordid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getBookcode() {
		return bookcode;
	}

	public void setBookcode(String bookcode) {
		this.bookcode = bookcode;
	}

	public String getLendtime() {
		return lendtime;
	}

	public void setLendtime(String lendtime) {
		this.lendtime = lendtime;
	}

	public String getReturntime() {
		return returntime;
	}

	public void setReturntime(String returntime) {
		this.returntime = returntime;
	}

	public String getExpiretime() {
		return expiretime;
	}

	public void setExpiretime(String expiretime) {
		this.expiretime = expiretime;
	}
}
