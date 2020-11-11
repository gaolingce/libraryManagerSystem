package com.system.service;

import com.github.pagehelper.PageInfo;
import com.system.model.Book;
import com.system.model.BookReferCondition;

public interface BookService {
    void addBook(Book book);

    Book checkBookCode(String bookcode);

    PageInfo<Book> referBooks(BookReferCondition bookReferCondition);

    void delBook(String bookcode);

    void updateBook(Book book);
}
