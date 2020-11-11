package com.system.controller;

import com.github.pagehelper.PageInfo;
import com.system.model.Book;
import com.system.model.BookReferCondition;
import com.system.model.ShowUserBooks;
import com.system.model.User;
import com.system.service.BookService;
import com.system.service.BorrowAndBackBook;
import com.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * com.system.controller
 * lenovo
 * 2020/11/10
 */
@Controller
@RequestMapping("/borrow")
public class BorrowBookController {
    private BookService bookService;
    private BorrowAndBackBook borrowAndBackBook;
    private UserService userService;


    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @Autowired
    public void setBorrowAndBackBook(BorrowAndBackBook borrowAndBackBook) {
        this.borrowAndBackBook = borrowAndBackBook;
    }

    @ResponseBody
    @RequestMapping("/borrowBook")
    public PageInfo<Book> borrowBook(String username, String bookcode){
        //查询是否有欠款，最多借五本书，有图书逾期
        List<ShowUserBooks> list = borrowAndBackBook.getUserBooks(username);
        if (list.size()>=5){
            return null;
        }

        User u = userService.checkUserName(username);
        if (u.getOwingmoney()>0){
            return null;
        }

        for (ShowUserBooks books:list){
            if (books.getFreetime()<0){
                return null;
            }
        }


        //借书
        borrowAndBackBook.borrowBook(username,bookcode);
        //查询图书列表
        BookReferCondition bookReferCondition = new BookReferCondition();
        bookReferCondition.setCurrentPage(1);
        bookReferCondition.setStatus(1);
        return bookService.referBooks(bookReferCondition);
    }


    //显示用户借书界面
    @RequestMapping("/showBorrowBooks")
    @ResponseBody
    public List<ShowUserBooks> showBorrowBooks(String username){
        List<ShowUserBooks> list = borrowAndBackBook.getUserBooks(username);
        return list;
    }




    @RequestMapping("/backBook")
    @ResponseBody
    public List<ShowUserBooks> backBook(String bookcode,String username,int freetime){
        //还书
        borrowAndBackBook.backBook(bookcode,username,freetime);
        //查询当前用户借书列表
        List<ShowUserBooks> list = borrowAndBackBook.getUserBooks(username);
        return list;
    }

}
