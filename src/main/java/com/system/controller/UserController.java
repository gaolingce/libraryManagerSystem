package com.system.controller;

import com.github.pagehelper.PageInfo;
import com.system.model.User;
import com.system.model.UserReferCondition;
import com.system.service.UserService;
import com.system.util.IDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * com.system.controller
 * lenovo
 * 2020/11/7
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private UserService service;

    @Autowired
    public void setService(UserService service) {
        this.service = service;
    }


    @RequestMapping(value = "/login")
    @ResponseBody
    public User login(String username, String password){
        User user = service.login(username,password);
        if (user == null){
            user = new User();
            user.setUserid(-1);
            user.setUsername("用户名或密码错误");
        }
        return user;
    }

    @RequestMapping(value = "/referUsers")
    @ResponseBody
    public PageInfo<User> referUsers(@RequestBody UserReferCondition useReferCondition){
       // System.out.println(useReferCondition.toString());

        return service.referUsers(useReferCondition);
    }

    @RequestMapping(value = "delUser")
    @ResponseBody
    public PageInfo<User> delUser(Integer userid){
        //删除userid的用户
        service.delUser(userid);
        //重新查询数据，并返回
        UserReferCondition userReferCondition = new UserReferCondition();
        userReferCondition.setCurrentPage(1);
        return service.referUsers(userReferCondition);
    }



    @RequestMapping("/addUser")
    @ResponseBody
    public void addUser(@RequestBody User user){
        user.setCreatetime(IDUtil.getNowTime());
        user.setOwingmoney(0.0);
        service.addUser(user);
    }


    //检查用户名是否重复 以及，修改用户信息时，通过用户名返回信息
    @RequestMapping("/checkUsername")
    @ResponseBody
    public User checkUsername(String username){
        User u = service.checkUserName(username);
        return u;
    }


    @RequestMapping("/updateUser")
    @ResponseBody
    public PageInfo<User> updateUser(@RequestBody User user){
        //修改用户信息
        service.updateUser(user);

        //重新查询数据，并返回
        UserReferCondition userReferCondition = new UserReferCondition();
        userReferCondition.setCurrentPage(1);
        return service.referUsers(userReferCondition);
    }

    //付款
    @RequestMapping("/paymoney")
    @ResponseBody
    public User paymoney(String username){
       return service.paymoney(username);
    }




}
