package com.system.controller;

import com.github.pagehelper.PageInfo;
import com.system.model.Book;
import com.system.model.BookReferCondition;

import com.system.service.BookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * com.system.controller
 * lenovo
 * 2020/11/10
 */
@Controller
@RequestMapping("/book")
public class BooksController {

    private BookService bookService;

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping("/addBook")
    @ResponseBody
    public void addBook(@RequestBody Book book){
        bookService.addBook(book);
    }


    //因为表里没有数量，所以一个编号的图书只能存在一本  即 图书编号 可以为主键
    @RequestMapping("/checkBookCode")
    @ResponseBody
    public Book checkBookCode(String bookcode){
       Book book = bookService.checkBookCode(bookcode);
        return book;
    }

    @RequestMapping(value = "/referBooks")
    @ResponseBody
    public PageInfo<Book> referBooks(@RequestBody BookReferCondition bookReferCondition){

        return bookService.referBooks(bookReferCondition);
    }

    @RequestMapping(value = "delBook")
    @ResponseBody
    public PageInfo<Book> delBook(String bookcode){
        //删除bookid的用户
        bookService.delBook(bookcode);
        //重新查询数据，并返回
        BookReferCondition bookReferCondition = new BookReferCondition();
        bookReferCondition.setCurrentPage(1);
        return bookService.referBooks(bookReferCondition);
    }

    @RequestMapping("/updateBook")
    @ResponseBody
    public PageInfo<Book> updateBook(@RequestBody Book book){
        //修改用户信息
        bookService.updateBook(book);

        //重新查询数据，并返回
        BookReferCondition bookReferCondition = new BookReferCondition();
        bookReferCondition.setCurrentPage(1);
        return bookService.referBooks(bookReferCondition);
    }

}
