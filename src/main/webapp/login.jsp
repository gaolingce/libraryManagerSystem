<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/11/7
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/login.css" />
    <script src="js/vue.min.js" ></script>
    <script src="js/vue-resource.min.js"></script>
    <script src="js/json2.js"></script>

</head>
<body>
<div class="page">
    <div class="loginwarrp">
        <div class="logo">图书管理系统</div>
        <div class="login_form" id="loginPage">
            <form id="Login" name="Login"  >
                <li class="login-item">
                    <span>用户名：</span>
                    <input type="text" name="UserName" class="login_input" v-model.lazy="username">
                </li>
                <li class="login-item">
                    <span>密　码：</span>
                    <input type="password" name="password" class="login_input" v-model="password">
                </li>
<%--                <li class="login-item verify">--%>
<%--                    <span>验证码：</span>--%>
<%--                    <input type="text" name="CheckCode" class="login_input verify_input">--%>
<%--                </li>--%>
<%--                <img src="images/verify.png" border="0" class="verifyimg" />--%>
                <div class="clearfix"></div>
                <li class="login-sub">
                    <input type="button" name="Submit" @click="login" value="登录" /> <br>
                    <span style="color: red">{{msg}}</span>
                </li>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    new Vue({
        el:"#loginPage",
        data:{
            username:'',
            password:'',
            msg:''
        },
        methods:{
            login:function () {
                this.msg='';

                this.$http.post("user/login",{username:this.username,password:this.password},{emulateJSON:true}).then(
                    function(resp){
                        if(resp.body.userid === -1){
                            this.msg = resp.body.username;
                        }else {
                            sessionStorage.setItem("username",resp.body.username);
                            location.href="index.jsp";
                        }
                    }
                )
            }
        }
    });
</script>

</body>
</html>




