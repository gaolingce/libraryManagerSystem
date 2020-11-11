package com.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.system.mappers.BookMapper;
import com.system.mappers.UserMapper;
import com.system.model.User;
import com.system.model.UserReferCondition;
import com.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * com.system.service.impl
 * lenovo
 * 2020/11/7
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    private UserMapper userMapper;
    private BookMapper bookMapper;

    @Override
    public User login(String username, String password) {
        User user = userMapper.loginPage(username,password);
        return user;
    }

    @Override
    public PageInfo<User> referUsers(UserReferCondition condition) {

        PageHelper.startPage(condition.getCurrentPage(),5);
        List<User> list = userMapper.getAllUsers(condition);
        Page<User> page = (Page<User>)list;
        PageInfo<User> pageInfo = new PageInfo<>(page);

       // System.out.println(pageInfo.toString());

        return pageInfo;
    }

    @Override
    public void delUser(Integer userid) {
        userMapper.delUser(userid);
    }

    @Override
    public void addUser(User user) {
        userMapper.addUser(user);
    }

    @Override
    public User checkUserName(String username) {
        User user = userMapper.checkUserName(username);
        return user;
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    @Override
    public User paymoney(String username) {
        //欠款更新为0
        userMapper.paymoney(username);
        //查询个人信息
        return userMapper.checkUserName(username);
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }
}
