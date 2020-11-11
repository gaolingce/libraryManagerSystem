package com.system.mappers;

import com.system.model.User;
import com.system.model.UserReferCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    //登录
    User loginPage(@Param("username") String username,@Param("password") String password);

    //获取所有用户信息
    List<User> getAllUsers(UserReferCondition condition);

    //删除指定userid的用户
    void delUser(Integer userid);


    void addUser(User user);

    User checkUserName(String username);

    void updateUser(User user);

    User paymoney(String username);
}
