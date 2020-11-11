<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/11/7
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台欢迎页</title>
    <link rel="stylesheet" href="../css/reset.css"/>
    <link rel="stylesheet" href="../css/content.css"/>
<%--    <script type="text/javascript" src="../js/laydate/laydate.js"></script>--%>
    <script type="text/javascript" src="../js/vue.min.js"></script>
    <script type="text/javascript" src="../js/vue-resource.min.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
</head>
<body marginwidth="0" marginheight="0">
<div class="container" id="mainBody">
    <div v-show="display">
        <div class="public-nav">您当前的位置：<a href="">系统设置</a>><a href="">用户管理</a></div>
        <div class="public-content">
            <div class="public-content-header">
                <h3>用户管理</h3>
            </div>
            <br>
            <div id="refer" class="public-content-cont">
                编号：<input type="text" v-model="useReferCondition.userid"/>
                用户名： <input type="text" v-model="useReferCondition.username" />
                状态：
                <select class="form-input-txt"  v-model="useReferCondition.status">
                    <option value="1" >正常</option>
                    <option value="-1" >锁定</option>
                </select>
                注册日期：
                <input type="text" id="startTime" v-model="useReferCondition.startTime">
                -
                <input type="text" id="endTime" v-model="useReferCondition.endTime">
                <input type="button" class="page-btn" value="查询" @click="refer">
            </div>
            <div class="public-content-cont">
                <table class="public-cont-table">
                    <tr>
                        <th style="width:10%">编号</th>
                        <th style="width:10%">用户名</th>
                        <th style="width:15%">身份证号</th>
                        <th style="width:10%">联系电话</th>
                        <th style="width:15%">注册日期</th>
                        <th style="width:10%">状态</th>
                        <th style="width:10%">欠费金额</th>
                        <th style="width:20%">操作</th>
                    </tr>
                    <tr v-for="user in userList">
                        <td>{{user.userid}}</td>
                        <td>{{user.username}}</td>
                        <td>{{user.idcard}}</td>
                        <td>{{user.phone}}</td>
                        <td>{{user.createtime}}</td>
                        <td>{{user.status==1?"正常":"锁定"}}</td>
                        <td>{{user.owing_money}}</td>
                        <td>
                            <div class="table-fun">
                                <a href="#" @click="ud(user.username)">修改</a>
                                <a href="#" @click="del(user.username)">删除</a>
                            </div>
                        </td>
                    </tr>

                </table>
                <div class="page">

                    共<span>{{page.totalRecords}}</span>个用户
                    <a href="javascript:void(0)" @click="toFirstPage">首页</a>
                    <a href="javascript:void(0)" @click="toPrePage">上一页</a>
                    <a href="javascript:void(0)" @click="toNextPage">下一页</a>
                    第<span style="color:red;font-weight:600">{{useReferCondition.currentPage}}</span>页
                    共<span style="color:red;font-weight:600">{{page.totalPage}}</span>页
                    <a href="javascript:void(0)" @click="toLastPage">末页</a>
                    <input type="text" class="page-input" v-model="page.jumpage" >
                    <input type="submit" class="page-btn" value="跳转" @click="jump">

                </div>
            </div>
        </div>
    </div>


    <!--修改用户信息-->
    <div class="container" v-show="hidden">
        <div class="public-content-cont" id="addUser">
            <div class="form-group">
                <label for="username">用户名</label>
                <input class="form-input-txt" type="text" id="username" v-model="udUser.username" readonly="readonly"/>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input class="form-input-txt" type="password" id="password" v-model="udUser.password"/>
            </div>
            <div class="form-group">
                <label for="idcard">身份证号</label>
                <input class="form-input-txt" type="text" id="idcard" v-model="udUser.idcard"/>
            </div>
            <div class="form-group">
                <label for="phone">联系电话</label>
                <input class="form-input-txt" type="text" id="phone" v-model="udUser.phone"/>
            </div>
            <div class="form-group">
                <label for="status">用户状态</label>
                <select class="form-input-txt" id="status" v-model="udUser.status">
                    <option value="1">正常</option>
                    <option value="-1">锁定</option>
                </select>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="form-group" style="margin-left:150px;">
            <input type="button" class="sub-btn"  @click="saveChange" value="提  交"/>
            <input type="button" class="sub-btn" @click="reset"  value="重  置"/>
        </div>
    </div>

</div>



</body>

<script type="text/javascript">
    new Vue({
        el: "#mainBody",
        data: {
            selectBirthDate:'',
            display:'',
            hidden: '',
            userList: [],
            user: {
                username: '',
                password: '',
                idcard: '',
                phone: '',
                status: ''
            },
            page:{
                totalRecords: '',
                totalPage: '',
                upPage: '',
                lastPage: '',
                jumpage:''
            },
            udUser:{
                username: '',
                password: '',
                idcard: '',
                phone: '',
                status: ''
            },
            useReferCondition:{
                userid:'',
                username:'',
                startTime:'',
                endTime:'',
                status:'',
                currentPage: 1
            }

        },
        mounted:function () {
            this.display = true;
            this.hidden = false;
            <!--页面加载，就调用referUsers（） currentPage=1 -->
            this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                function (response) {
                    this.userList = response.body.list;
                    this.useReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;
                    this.page.totalRecords = response.body.total;
                }
            );
        },
        methods:{
            del:function (username) {
                this.$http.get("/libraryManagerSystem/user/delUser",{params:{username:username}}).then(function (response) {
                    this.userList = response.body.list;
                    this.useReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;
                    this.page.totalRecords = response.body.total;
                })
            },
            <!--同步修改信息-->
            ud:function (username) {
                this.display = false;
                this.hidden = true;
                this.$http.get("/libraryManagerSystem/user/checkUsername",{params:{username:username}}).then(
                    function (response) {
                        this.udUser.username = response.body.username;
                        this.udUser.password = response.body.password;
                        this.udUser.idcard = response.body.idcard;
                        this.udUser.phone = response.body.phone;
                        this.udUser.status = response.body.status;
                    }
                )
            },
            <!--修改完成后保存-->
            saveChange:function () {
                if (this.isDisable === true){
                    return;
                }
                this.$http.post("/libraryManagerSystem/user/updateUser",this.udUser).then(function (response) {
                    alert("修改成功！");
                    this.reset();
                    this.userList = response.body.list;
                    this.useReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;
                    this.page.totalRecords = response.body.total;

                    this.display = true;
                    this.hidden = false;
                })
            },
            reset:function () {
                this.user.username = '';
                this.user.password = '';
                this.user.idcard = '';
                this.user.phone = '';
                this.user.status = '';
            },
            refer:function () {
                this.useReferCondition.currentPage = 1;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            jump:function () {
                this.useReferCondition.currentPage = this.page.jumpage;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toFirstPage:function () {
                this.useReferCondition.currentPage = 1;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toPrePage:function () {
                if (this.useReferCondition.currentPage-2<0){
                    alert("当前为第一页");
                    return;
                }
                --this.useReferCondition.currentPage;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toNextPage:function () {
                if (this.useReferCondition.currentPage+1>this.page.totalPage){
                    alert("当前为最后一页");
                    return;
                }

                ++this.useReferCondition.currentPage;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toLastPage:function () {
                this.useReferCondition.currentPage = this.page.totalPage;
                this.$http.post("/libraryManagerSystem/user/referUsers",this.useReferCondition).then(
                    function (response) {
                        this.userList = response.body.list;
                        this.useReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            }
        }

    });
</script>

</html>