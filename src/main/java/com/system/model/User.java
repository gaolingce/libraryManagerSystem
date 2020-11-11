package com.system.model;

import javax.persistence.*;
import java.util.Date;

/**
 * @Description  
 * @Author  Henry
 * @Date 2020-11-05 
 */


@Table ( name ="user" )
public class User  {

	private Integer userid;

	private String username;

	private String password;

	private String idcard;

	private String phone;

	private String createtime;

	private Integer status;

	private Double owingmoney;

	private Integer pageNum;
	private Integer pageSize;

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Double getOwingmoney() {
		return owingmoney;
	}

	public void setOwingmoney(Double owingmoney) {
		this.owingmoney = owingmoney;
	}
}
