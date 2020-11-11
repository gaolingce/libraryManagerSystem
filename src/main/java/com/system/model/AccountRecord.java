package com.system.model;


import javax.persistence.*;
import java.util.Date;

/**
 * @Description  
 * @Author  Henry
 * @Date 2020-11-05 
 */

@Entity

@Table ( name ="account_record" )
public class AccountRecord  {


	private Integer recordid;

	private String username;

	private Double money;

	private String changetime;

	private Integer type;



	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getRecordid() {
		return recordid;
	}

	public void setRecordid(Integer recordid) {
		this.recordid = recordid;
	}


	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getChangetime() {
		return changetime;
	}

	public void setChangetime(String changetime) {
		this.changetime = changetime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
