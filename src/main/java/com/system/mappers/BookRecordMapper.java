package com.system.mappers;

import com.system.model.BookRecord;
import com.system.model.ShowUserBooks;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BookRecordMapper {
    void addRecord(BookRecord bookRecord);

    void backBook(@Param("bookcode") String bookcode,@Param("username") String username,@Param("returntime") String returntime);

    List<ShowUserBooks> getUserBooks(String username);

    void shouldPayMoney(@Param("owingmoney")double owingmoney,@Param("username") String username);
}
