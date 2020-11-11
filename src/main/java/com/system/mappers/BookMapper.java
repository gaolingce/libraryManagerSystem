package com.system.mappers;

import com.system.model.Book;
import com.system.model.BookReferCondition;

import java.util.List;

public interface BookMapper {

    List<Book> getAllBooks(BookReferCondition bookReferCondition);

    void addBook(Book book);

    Book checkBookCode(String bookcode);

    void delBook(String bookcode);

    void updateBook(Book book);

    void borrowBook(Book book);
}
