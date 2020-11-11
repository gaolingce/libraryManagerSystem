package com.system.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * com.system.model
 * lenovo
 * 2020/11/9
 *
 * 用户管理界面，封装查询条件 和 当前页
 */
public class UserReferCondition {

    private Integer userid;
    private String username;
    private Timestamp startTime;
    private Timestamp endTime;
    private Integer status;
    private Integer currentPage;


    @Override
    public String toString() {
        return "UserReferCondition{" +
                "userid=" + userid +
                ", username='" + username + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", status=" + status +
                ", currentPage=" + currentPage +
                '}';
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
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

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
