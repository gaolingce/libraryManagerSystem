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
    <div class="public-nav">您当前的位置：<a href="">图书借阅</a>><a href="">个人信息</a></div>
    <div class="public-content" id="addUser">
        <div class="public-content-header">
            <h3>个人信息</h3>
        </div>
        <div class="public-content-cont" >
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input class="form-input-txt" type="text" id="username"  v-model.trim="user.username"  readonly="readonly"/><span style="color: green">*</span>

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
                    <input class="form-input-txt" type="text" id="phone" v-model.trim="user.phone"/>
                </div>
                <div class="form-group">
                    <label for="createtime">创建时间</label>
                    <input class="form-input-txt" type="text" id="createtime" v-model.trim="user.createtime" readonly="readonly"/><span style="color: green">*</span>
                </div>
                <div class="form-group">
                    <label for="owingmoney">欠费</label>
                    <input class="form-input-txt" id="owingmoney" v-model="user.owingmoney" readonly="readonly"/><span style="color: green">*</span><a style="text-decoration:underline;" href="javascript:void(0)" @click="paymoney" v-if="user.owingmoney>0">去付款</a>
                </div>
                <div class="form-group">
                    <label for="status">用户状态</label>
                    <input class="form-input-txt" id="status" v-model="user.status==1?'正常':'锁定'" readonly="readonly"/><span style="color: green">*</span>
                </div>
                <div class="form-group">
                    <span style="color: red">带*的为不可修改项</span>
                </div>
        </div>

        <div class="clearfix"></div>
        <div class="form-group" style="margin-left:150px;">
            <input type="button" class="sub-btn" @click="addUser"  value="修  改"  v-bind:disabled="isDisable" />
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
            msg:'',
            user:{
                username:'',
                password:'',
                idcard:'',
                phone:'',
                status:'',
                createtime:'',
                owingmoney:''
            }
        },
        mounted:function(){
            const username = sessionStorage.getItem("username");
            this.$http.get("/libraryManagerSystem/user/checkUsername",{params:{username:username}}).then(
                function (response) {
                    this.user.username = response.body.username;
                    this.user.password = response.body.password;
                    this.user.idcard = response.body.idcard;
                    this.user.phone = response.body.phone;
                    this.user.status = response.body.status;
                    this.user.createtime = response.body.createtime;
                    this.user.owingmoney = response.body.owingmoney;
                }
            )
        },
        methods:{
            addUser:function () {

                this.$http.post("/libraryManagerSystem/user/addUser",this.user).then(function () {
                    alert("修改成功");
                    this.reset();
                })
            },
            reset:function () {
                const f = confirm("是否确认重置信息？");
                if (f){
                    this.user.password = '';
                    this.user.idcard = '';
                    this.user.phone = '';
                }

            },
            paymoney:function () {
                alert("支付成功");
                const username = sessionStorage.getItem("username");
                this.$http.get("/libraryManagerSystem/user/paymoney",{params: {username:username}}).then(
                    function () {
                        this.user.owingmoney = 0;
                    }
                )
            }
        }


    });


</script>
</body>
</html>
