package com.system.service;

import com.github.pagehelper.PageInfo;
import com.system.model.User;
import com.system.model.UserReferCondition;
import org.apache.ibatis.annotations.Param;

public interface UserService {
    //登录
    User login( String username, String password);

    //条件查询并分页
    PageInfo<User> referUsers(UserReferCondition condition);

    //删除指定userid的用户
    void delUser(Integer userid);

    void addUser(User user);

    User checkUserName(String username);

    void updateUser(User user);

    User paymoney(String username);
}
