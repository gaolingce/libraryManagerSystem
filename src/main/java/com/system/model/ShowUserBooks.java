package com.system.model;

/**
 * com.system.model
 * lenovo
 * 2020/11/10
 */
public class ShowUserBooks {
    private String bookcode;
    private String bookname;
    private String lendtime;
    private String expiretime;
    private int freetime;

    public ShowUserBooks(){}

    public String getBookcode() {
        return bookcode;
    }

    public void setBookcode(String bookcode) {
        this.bookcode = bookcode;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public String getLeadtime() {
        return lendtime;
    }

    public void setLeadtime(String leadtime) {
        this.lendtime = leadtime;
    }

    public String getExpiretime() {
        return expiretime;
    }

    public void setExpiretime(String expiretime) {
        this.expiretime = expiretime;
    }

    public int getFreetime() {
        return freetime;
    }

    public void setFreetime(int freetime) {
        this.freetime = freetime;
    }
}
