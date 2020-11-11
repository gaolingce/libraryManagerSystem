package com.system.service.impl;

import com.system.mappers.AccountRecordMapper;
import com.system.mappers.BookMapper;
import com.system.mappers.BookRecordMapper;
import com.system.mappers.UserMapper;
import com.system.model.Book;
import com.system.model.BookRecord;
import com.system.model.ShowUserBooks;
import com.system.service.BorrowAndBackBook;
import com.system.util.IDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * com.system.service.impl
 * lenovo
 * 2020/11/10
 */

@Service("borrowAndBackBook")
public class BorrowAndBackBookImpl implements BorrowAndBackBook {

    private UserMapper userMapper;
    private BookMapper bookMapper;
    private BookRecordMapper bookRecordMapper;
    private AccountRecordMapper accountRecordMapper;

    @Autowired
    public void setBookRecordMapper(BookRecordMapper bookRecordMapper) {
        this.bookRecordMapper = bookRecordMapper;
    }

    @Autowired
    public void setAccountRecordMapper(AccountRecordMapper accountRecordMapper) {
        this.accountRecordMapper = accountRecordMapper;
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public void borrowBook(String username, String bookcode) {
        //借书 改变book表的status，book_record 表的相关信息
        Book book = new Book();
        book.setBookcode(bookcode);
        book.setStatus(-1);
        bookMapper.borrowBook(book);
        //向book_record表插入记录 ，将信息封装到bookrecord对象中，再insert into表
        BookRecord bookRecord = new BookRecord();
        bookRecord.setUsername(username);
        bookRecord.setBookcode(bookcode);
        bookRecord.setLendtime(IDUtil.getNowTime());
        bookRecord.setExpiretime(IDUtil.getThirtyDay());
        bookRecordMapper.addRecord(bookRecord);
    }


    @Override
    public List<ShowUserBooks> getUserBooks(String username) {
        //联合查询 该用户借的  图书编码，图书名称，借书时间，到期时间
        List<ShowUserBooks> list = bookRecordMapper.getUserBooks(username);
        //计算当前时间与到期时间的时间差
        for (ShowUserBooks boos:list){
            int d = IDUtil.dateDifference(IDUtil.getNowTime(),boos.getExpiretime());
            boos.setFreetime(d);
        }
        return list;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public void backBook(String bookcode, String username,int freetime) {
        //将对于图书的状态改为1
        Book book = new Book();
        book.setBookcode(bookcode);
        book.setStatus(1);
        bookMapper.borrowBook(book);

        //获取当前时间，完善借书记录表的returntime
        String returntime = IDUtil.getNowTime();
        bookRecordMapper.backBook(bookcode,username,returntime);

        //根据是否逾期修改账户欠费金额
        if (freetime<0){
            double owingmoney =(Math.abs(freetime))*0.2;
            bookRecordMapper.shouldPayMoney(owingmoney,username);
        }

    }




}
