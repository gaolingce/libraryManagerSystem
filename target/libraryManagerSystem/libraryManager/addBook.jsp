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
    <div class="public-nav">您当前的位置：<a href="">系统设置</a>><a href="">新增图书</a></div>
    <div class="public-content" id="addUser">
        <div class="public-content-header">
            <h3>新增图书</h3>
        </div>
        <div class="public-content-cont" >
            <div class="form-group">
                <label for="bookcode">图书编号</label>
                <input class="form-input-txt" type="text" id="bookcode" @change="checkBookCode"  v-model.trim="book.bookcode" /> <span style="color: red">{{msg}}</span>
            </div>
            <div class="form-group">
                <label for="username">图书名称</label>
                <input class="form-input-txt" type="text" id="username"   v-model.trim="book.bookname" />
            </div>
            <div class="form-group">
                <label for="password">图书作者</label>
                <input class="form-input-txt" type="text" id="password" v-model.trim="book.author"/>
            </div>
            <div class="form-group">
                <label for="idcard">图书价格</label>
                <input class="form-input-txt" type="text" id="idcard" v-model.trim="book.price"/>
            </div>
            <div class="form-group">
                <label for="phone">出版社</label>
                <input class="form-input-txt" type="text" id="phone" v-model.trim="book.publisher"/>
            </div>
            <div class="form-group">
                <label for="status">图书状态</label>
                <select class="form-input-txt" id="status" v-model="book.status">
                    <option value="1" >在馆</option>
                    <option value="-1" >借出</option>
                </select>
            </div>
        </div>

        <div class="clearfix"></div>
        <div class="form-group" style="margin-left:150px;">
            <input type="button" class="sub-btn" @click="addBook"  value="提  交"  v-bind:disabled="isDisable" />
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
            book:{
                bookcode:'',
                bookname:'',
                author:'',
                price:'',
                publisher:'',
                status:''
            }
        },
        methods:{
            addBook:function () {
                if (this.isDisable === true){
                    return;
                }
                this.$http.post("/libraryManagerSystem/book/addBook",this.book).then(function () {
                    alert("新增成功");
                    this.reset();
                })
            },
            reset:function () {
                this.book.bookname = '';
                this.book.author = '';
                this.book.price = '';
                this.book.publisher = '';
                this.book.bookcode = '';
                this.book.status = '';
            },
            checkBookCode:function () {
                this.$http.get("/libraryManagerSystem/book/checkBookCode",{params:{bookcode:this.book.bookcode}}).then(
                    function (response) {
                        if (response.bodyText !== ""){
                            this.msg = "图书已存在！";
                            this.isDisable = true;
                        }else {
                            this.isDisable = false;
                            this.msg ='';
                        }
                    }
                )
            },

        }


    });


</script>
</body>
</html>
