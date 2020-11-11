<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/11/7
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台欢迎页</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/content.css" />
    <script src="../js/vue.min.js" ></script>
    <script src="../js/vue-resource.min.js"></script>
    <script src="../js/json2.js"></script>
</head>
<body marginwidth="0" marginheight="0">
<div class="container">
    <div class="public-nav">您当前的位置：<a href="">系统设置</a>><a href="">新增用户</a></div>
    <div class="public-content" id="addUser">
        <div class="public-content-header">
            <h3>新增用户</h3>
        </div>
        <div class="public-content-cont" >
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input class="form-input-txt" type="text" id="username" @change="checkUsername"  v-model.trim="user.username" /> <span style="color: red">{{msg}}</span>
                </div>
                <div class="form-group">
                    <label for="password">密码</label>
                    <input class="form-input-txt" type="password" id="password" v-model.trim="user.password"/>
                </div>
                <div class="form-group">
                    <label for="idcard">身份证号</label>
                    <input class="form-input-txt" type="text" id="idcard" v-model.trim="user.idcard"/>
                </div>
                <div class="form-group">
                    <label for="phone">联系电话</label>
                    <input class="form-input-txt" type="text" id="phone" v-model.trim="user.phone" @change="ckPhone"/><span style="color: red">{{checkPhone}}</span>
                </div>
                <div class="form-group">
                    <label for="status">用户状态</label>
                    <select class="form-input-txt" id="status" v-model="user.status">
                        <option value="1" >正常</option>
                        <option value="-1" >锁定</option>
                    </select>
                </div>
        </div>

        <div class="clearfix"></div>
        <div class="form-group" style="margin-left:150px;">
            <input type="button" class="sub-btn" @click="addUser"  value="提  交"  v-bind:disabled="isDisable" />
            <input type="button" class="sub-btn" @click="reset" value="重  置" />
        </div>
    </div>
</div>
</div>
<script>
    new Vue({
        el:"#addUser",
        data:{
            isDisable:false,
            checkPhone:'',
            msg:'',
            user:{
                username:'',
                password:'',
                idcard:'',
                phone:'',
                status:''
            }
        },
        methods:{
            addUser:function () {
                if (this.isDisable === true){
                    return;
                }
                this.$http.post("/libraryManagerSystem/user/addUser",this.user).then(function () {
                    alert("新增成功");
                    this.reset();
                })
            },
            reset:function () {
                this.user.username = '';
                this.user.password = '';
                this.user.idcard = '';
                this.user.phone = '';
                this.user.status = '';
            },
            checkUsername:function () {
                this.$http.get("/libraryManagerSystem/user/checkUsername",{params:{username:this.user.username}}).then(
                    function (response) {
                        if (response.bodyText !== ""){
                            this.msg = "用户名已存在！";
                            this.isDisable = true;
                        }else {
                            this.isDisable = false;
                            this.msg ='';
                        }
                    }
                )
            },
            ckPhone:function () {
                if (!/^1[345789]\d{9}/.test(this.user.phone)){
                    this.checkPhone = "请输入正确的手机号！";
                    this.isDisable = true;
                }else {
                    this.checkPhone = "";
                }
            }
        }


    });


</script>
</body>
</html>
