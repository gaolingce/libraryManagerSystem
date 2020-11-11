package com.system.service;

import com.system.model.ShowUserBooks;

import java.util.List;

public interface BorrowAndBackBook {

    void borrowBook(String username, String bookcode);

    void backBook(String bookcode, String username,int freetime);

    List<ShowUserBooks> getUserBooks(String username);
}
