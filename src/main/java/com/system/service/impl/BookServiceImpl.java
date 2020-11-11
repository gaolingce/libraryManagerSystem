package com.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.system.mappers.BookMapper;
import com.system.model.Book;
import com.system.model.BookReferCondition;

import com.system.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * com.system.service.impl
 * lenovo
 * 2020/11/10
 */
@Service("bookService")
public class BookServiceImpl implements BookService {

    private BookMapper bookMapper;

    @Autowired
    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    @Override
    public void addBook(Book book) {
        bookMapper.addBook(book);
    }

    @Override
    public Book checkBookCode(String bookcode) {
        Book book = bookMapper.checkBookCode(bookcode);
        return book;
    }

    @Override
    public PageInfo<Book> referBooks(BookReferCondition bookReferCondition) {
        PageHelper.startPage(bookReferCondition.getCurrentPage(),5);
        List<Book> list = bookMapper.getAllBooks(bookReferCondition);
        Page<Book> page = (Page<Book>)list;
        PageInfo<Book> pageInfo = new PageInfo<>(page);
        return pageInfo;
    }

    @Override
    public void delBook(String bookcode) {
        bookMapper.delBook(bookcode);
    }

    @Override
    public void updateBook(Book book) {
        bookMapper.updateBook(book);
    }
}
