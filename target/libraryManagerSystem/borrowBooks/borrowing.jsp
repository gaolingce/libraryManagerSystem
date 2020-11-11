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
    <div>
        <div class="public-nav">您当前的位置：<a href="">图书借阅</a>><a href="">已借图书</a></div>
        <div class="public-content">
            <div class="public-content-header">
                <h3>已借图书列表</h3>
            </div>
            <br>
            <div class="public-content-cont">
                <table class="public-cont-table">
                    <tr>
                        <th style="width:10%">全选<input name="select" type="checkbox"  v-model="selectAll"></th>
                        <th style="width:20%">图书名称</th>
                        <th style="width:20%">借书日期</th>
                        <th style="width:20%">到期日期</th>
                        <th style="width:20%">剩余免费时间</th>
                        <th style="width:10%">操作</th>
                    </tr>
                    <tr v-for="book in bookList">
                        <td><input name="select" type="checkbox"  v-model="selectAll"></td>
                        <td>{{book.bookname}}</td>
                        <td>{{book.leadtime}}</td>
                        <td>{{book.expiretime}}</td>
                        <td>{{book.freetime}}天</td>
                        <td>
                            <div class="table-fun">
                                <a href="javascript:void(0)" @click="back(book.bookcode,book.freetime)">归还</a>
                            </div>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
    </div>


</div>



</body>

<script type="text/javascript">
    new Vue({
        el: "#mainBody",
        data: {
            bookList: [],
            selectAll:[]

        },
        mounted:function () {
            const username = sessionStorage.getItem("username");
            this.$http.get("/libraryManagerSystem/borrow/showBorrowBooks",{params: {username:username}}).then(
                function (response) {
                    this.bookList = response.body;
                }
            );
        },
        methods:{
            back:function(bookcode,freetime){
                const username = sessionStorage.getItem("username");
                this.$http.get("/libraryManagerSystem/borrow/backBook",{params:{bookcode:bookcode,username:username,freetime:freetime}}).then(
                    function (response) {
                        this.bookList = response.body;
                    }
                )
            },


        }
    });
</script>

</html>